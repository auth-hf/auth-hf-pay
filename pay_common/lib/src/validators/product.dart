import 'package:angel_validate/angel_validate.dart';

final Validator product = new Validator({
  'name,description,cover_image': isNonEmptyString,
  'price': [
    isNum,
    greaterThanOrEqualTo(1.0),
  ]
});

final Validator createProduct = product.extend({})
  ..requiredFields.addAll([
    'name',
    'description',
    'price',
  ]);
