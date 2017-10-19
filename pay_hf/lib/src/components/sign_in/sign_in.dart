import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import '../../providers/auth_service.dart';
import '../../providers/title_service.dart';

@Component(selector: 'sign-in', templateUrl: 'sign_in.html')
class SignInComponent implements OnActivate {
  final TitleService _titleService;
  final AuthService auth;

  SignInComponent(this._titleService, this.auth);

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    _titleService.title = 'Sign In';
  }
}
