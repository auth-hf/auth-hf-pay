import 'package:angel_framework/angel_framework.dart';
import 'package:angel_websocket/server.dart';
import 'package:logging/logging.dart';
import 'package:pay_server/pay_server.dart' as pay_server;

main() async {
  var app = new Angel()..lazyParseBodies = true;
  await app.configure(pay_server.configureServer);

  var ws = new AngelWebSocket(app, sendErrors: true);
  app.all('/ws', ws.handleRequest);

  app.logger = new Logger('pay_server')
  ..onRecord.listen((rec) {
    print(rec);

    if (rec.error != null) {
      print(rec.error);
      print(rec.stackTrace);
    }
  });

  var server = await app.startServer('127.0.0.1', 3001);
  print('Listening at http://${server.address.address}:${server.port}');
}