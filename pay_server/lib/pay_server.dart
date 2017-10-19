import 'dart:async';
import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'src/services/services.dart' as services;
import 'src/auth.dart' as auth;

Future configureServer(Angel app) async {
  const fs = const LocalFileSystem();
  await app.configure(configuration(fs));

  await app.configure(auth.configureServer);

  var db = new Db(app.configuration['mongo_db']);
  await db.open();
  await app.configure(services.configureServer(db));
}
