import 'dart:async';
import 'dart:collection';
import 'package:angular/angular.dart';
import 'package:angel_client/angel_client.dart';
import 'package:pay_common/models.dart';

@Injectable()
class AuthService {
  final Angel app;
  final Queue<Completer<User>> _onLogin = new Queue();

  User _user;

  AuthService(this.app) {
    app.authenticate().then(_handleAuth).catchError((_) {
      // Fail silently if no user exists
    });
  }

  User get user => _user;

  void _handleAuth(AngelAuthResult auth) {
    _user = User.parse(auth.data);

    while (_onLogin.isNotEmpty) _onLogin.removeFirst().complete(_user);
  }

  void close() {
    while (_onLogin.isNotEmpty)
      _onLogin.removeFirst().completeError(new StateError(
          'The AuthService was closed before the future completed.'));
  }

  Future login() {
    return app.authenticateViaPopup('/auth/hf').first.then((jwt) {
      return app.authenticate(
        credentials: {
          'token': jwt,
        },
      ).then(_handleAuth);
    });
  }

  Future onLogin<T>(FutureOr<T> callback(User user)) {
    var c = new Completer<User>();

    if (_user != null)
      c.complete(_user);
    else
      _onLogin.addLast(c);

    return c.future.then<T>(callback);
  }
}
