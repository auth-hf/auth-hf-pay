import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/hooks.dart' as hooks;
import 'package:angel_mongo/angel_mongo.dart';
import 'package:angel_security/hooks.dart' as auth;
import 'package:angel_validate/server.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:pay_common/validators.dart' as validators;

AngelConfigurer configureServer(Db db) {
  return (Angel app) async {
    HookedService service = app.use(
      '/api/products',
      new MongoService(db.collection('products')),
    );
    app.inject('productService', service);

    service.beforeCreated.listen(hooks.chainListeners([
      validateEvent(validators.createProduct),
      auth.associateCurrentUser(ownerField: 'user_id'),
      hooks.addCreatedAt(key: 'created_at'),
    ]));

    service.beforeModified.listen(hooks.chainListeners([
      validateEvent(validators.product),
      auth.restrictToOwner(ownerField: 'user_id'),
    ]));

    service.beforeUpdated.listen(hooks.disable());

    service.beforeModify(
      hooks.addUpdatedAt(key: 'updated_at'),
    );

    service.beforeRemoved.listen(auth.restrictToOwner(ownerField: 'user_id'));
  };
}
