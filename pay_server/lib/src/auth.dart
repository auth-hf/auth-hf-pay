import 'dart:async';
import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:uuid/uuid.dart';

Future configureServer(Angel app) async {}

class AuthHFStrategy extends AuthStrategy {
  static final Uri authorizationEndpoint =
          Uri.parse('https://auth-hf.com/oauth2/authorize'),
      tokenEndpoint = Uri.parse('https://auth-hf.com/oauth2/token');

  final String clientId, clientSecret;
  final Uri redirectUri;
  final Uuid _uuid = new Uuid();

  AuthHFStrategy(Map config)
      : clientId = config['id'],
        clientSecret = config['secret'],
        redirectUri = Uri.parse(config['redirect_uri']);

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
  }

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

    var grant = _createGrant();
    var client = await grant.handleAuthorizationCode(code);

    // Get user data
    var response = await client.post('https://auth-hf.com/api/call', body: {
      'endpoint': '/user',
    });

    // TODO: Persist to user service
  }
}
