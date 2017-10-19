library pay_common.src.models.product;

import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
part 'product.g.dart';

@serializable
class _Product extends Model {
  String userId, name, description, coverImage;
  num price;
}