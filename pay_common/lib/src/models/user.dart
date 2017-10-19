library pay_common.src.models.user;

import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
part 'user.g.dart';

@serializable
class _User extends Model {
  static final Uri hackForums = Uri.parse('https://hackforums.net');

  String hfId, username, avatar, accessToken, refreshToken;
  int reputation;
  double balance;
  DateTime expiresIn;

  String get imageUrl => hackForums.resolve(avatar).toString();
}
