import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'src/components/sign_in/sign_in.dart';
import 'src/providers/auth_service.dart';

@Component(
  selector: 'pay-hf',
  templateUrl: 'pay_hf.html',
  styleUrls: const ['pay_hf.css'],
  directives: const [
    COMMON_DIRECTIVES,
    ROUTER_DIRECTIVES,
  ],
)
@RouteConfig(const [
  const Route(
    path: '/sign-in',
    name: 'SignIn',
    component: SignInComponent,
  ),
])
class PayHFComponent {
  final AuthService auth;
  bool navbarActive = false;

  PayHFComponent(this.auth);
}
