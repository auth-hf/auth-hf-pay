library pay_common.src.models.upload;

import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
part 'upload.g.dart';

@serializable
class _Upload extends Model {
  String userId, path, mimeType, filename;
}