import 'dart:async';
import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';
import 'src/auth.dart' as auth;

Future configureServer(Angel app) async {
  const fs = const LocalFileSystem();
  await app.configure(configuration(fs));
  await app.configure(auth.configureServer);
}