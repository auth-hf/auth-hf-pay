import 'dart:async';
import 'dart:convert';
import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:pay_common/models.dart';
import 'package:uuid/uuid.dart';

Future configureServer(Angel app) async {
  var auth = new AngelAuth<User>(
    jwtKey: app.configuration['jwt_secret'],
    allowCookie: false,
    allowTokenInQuery: false,
  );

  auth.serializer = (User user) async => user.id;
  auth.deserializer =
      (String id) => app.service('api/users').read(id).then(User.parse);

  auth.strategies.add(new AuthHFStrategy(
    app.configuration['base_url'],
    app.configuration['auth_hf'],
  ));

  app.use(auth.decodeJwt);
  app.get('/auth/hf', auth.authenticate('hf'));
  app.get(
      '/auth/hf/callback',
      auth.authenticate(
        'hf',
        new AngelAuthOptions(callback: confirmPopupAuthentication()),
      ));
}

class AuthHFStrategy extends AuthStrategy {
  final String clientId, clientSecret;
  final Uri authorizationEndpoint, tokenEndpoint, callEndpoint;
  final Uri redirectUri;
  final Uuid _uuid = new Uuid();

  @override
  final String name = 'hf';

  AuthHFStrategy(String baseUrl, Map config)
      : clientId = config['id'],
        clientSecret = config['secret'],
        redirectUri = Uri.parse(config['redirect_uri']),
        authorizationEndpoint =
            Uri.parse('https://auth-hf.com/oauth2/authorize'),
        tokenEndpoint = Uri.parse('https://auth-hf.com/oauth2/token'),
        callEndpoint = Uri.parse('https://auth-hf.com/api/call');

  oauth2.AuthorizationCodeGrant _createGrant() {
    return new oauth2.AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecret,
    );
  }

  @override
  Future<bool> canLogout(RequestContext req, ResponseContext res) async => true;

  @override
  Future authenticate(RequestContext req, ResponseContext res,
      [AngelAuthOptions options]) async {
    if (options != null) return await authenticateCallback(req, res, options);

    var state = req.session['auth_state'] = _uuid.v4();
    var grant = _createGrant();
    var url = grant.getAuthorizationUrl(
      redirectUri,
      state: state,
      scopes: const ['/user'],
    );
    grant.close();
    res.redirect(url.toString());
    return false;
  }

  final RegExp _avatar = new RegExp(r'avatar_([0-9]+)');

  Future authenticateCallback(RequestContext req, ResponseContext res,
      [AngelAuthOptions options]) async {
    // Prevent CSRF
    if (!req.session.containsKey('auth_state') ||
        req.query['state'] != req.session.remove('auth_state'))
      throw new AngelHttpException.badRequest();

    var error = req.query['error'];

    if (error != null) {
      // TODO: Auto-closing page
      res.write('You may now close this window.');
      return false;
    }

    var code = req.query['code'];
    if (code == null) throw new AngelHttpException.badRequest();

    var grant = _createGrant()..getAuthorizationUrl(redirectUri);
    var client = await grant.handleAuthorizationCode(code);

    // Get user data
    var response = await client.post(callEndpoint, body: {
      'endpoint': '/user',
    });

    if (response.statusCode != 200 ||
        response.headers['content-type']?.contains('application/json') !=
            true) {
      print(response.statusCode);
      print(response.body);
      throw new StateError(
          'Could not sign you in. Did you grant us account access?');
    }

    var data = JSON.decode(response.body);

    if (data['success'] != true) {
      throw new StateError(
          'Could not fetch your profile. Your API key may be invalid.');
    }

    Map userData = data['result'];
    String username = userData['username'], avatar = userData['avatar'];
    int reputation = userData['reputation'];

    // For some reason, the HF API doesn't send you the user's ID.
    // So, parse it out from the avatar URL.
    var hfId = _avatar.firstMatch(avatar)?.group(1);

    if (hfId == null) {
      throw new StateError('Could not determine your account ID.');
    }

    var userService = req.grab<Service>('userService');
    Iterable<User> existing = await userService.index({
      'query': {
        'hf_id': hfId,
      }
    }).then((it) => it.map(User.parse));

    var newData = {
      'username': username,
      'avatar': avatar,
      'reputation': reputation,
      'access_token': client.credentials.accessToken,
      'refresh_token': client.credentials.refreshToken,
      'expires_in': client.credentials.expiration,
    };

    User user;

    if (existing.isNotEmpty) {
      user =
          await userService.modify(existing.first.id, newData).then(User.parse);
    } else {
      newData['hf_id'] = hfId;
      user = await userService.create(newData).then(User.parse);
    }

    return user;
  }
}
