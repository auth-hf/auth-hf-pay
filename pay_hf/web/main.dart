import 'package:angel_websocket/browser.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_config/fnx_config_read.dart';
import 'package:pay_hf/pay_hf.dart';
import 'package:pay_hf/providers.dart';

void main() {
  var cfg = fnxConfig();
  var providers = [
    ROUTER_PROVIDERS,
    provide(Angel, useValue: new WebSockets(cfg['hostname'] + '/ws')),
    payHFProviders,
  ];

  if (fnxConfigMeta()['mode'] == 'debug') {
    providers.add(
      provide(LocationStrategy, useClass: HashLocationStrategy),
    );
  }

  bootstrap(PayHFComponent, providers);
}
