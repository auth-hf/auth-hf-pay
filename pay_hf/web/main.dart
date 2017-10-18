import 'dart:html';
import 'package:angel_client/browser.dart';
import 'package:angular/angular.dart';
import 'package:pay_hf/pay_hf.dart';
import 'package:pay_hf/providers.dart';

void main() {
  // var wsUrl = Uri.parse(window.location.href).resolve('/ws').toString();
  bootstrap(PayHFComponent, [
    provide(Angel, useValue: new Rest(window.location.origin)),
    payHFProviders,
  ]);
}
