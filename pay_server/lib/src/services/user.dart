import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/hooks.dart' as hooks;
import 'package:angel_mongo/angel_mongo.dart';
import 'package:angel_websocket/hooks.dart' as ws;
import 'package:mongo_dart/mongo_dart.dart';

AngelConfigurer configureServer(Db db) {
  return (Angel app) async {
    HookedService service =
        app.use('/api/users', new MongoService(db.collection('users')));
    app.inject('userService', service);

    service
      ..before([
        HookedServiceEvent.indexed,
        HookedServiceEvent.created,
        HookedServiceEvent.modified,
        HookedServiceEvent.updated,
        HookedServiceEvent.removed,
      ], hooks.disable())
      ..beforeCreated.listen(hooks.transform((Map user) {
        return user..['balance'] = 0.0;
      }))
      ..beforeModified.listen(hooks.chainListeners([
        hooks.remove('balance'),
        hooks.transform((Map user) {
          return user..remove('applications');
        })
      ]))
      ..afterAll(ws.doNotBroadcast())
      ..afterRead.listen(hooks.remove([
        'hf_id',
        'access_token',
        'refresh_token',
      ]));
  };
}
