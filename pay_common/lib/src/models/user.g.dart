// GENERATED CODE - DO NOT MODIFY BY HAND

part of pay_common.src.models.user;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class User extends _User {
  @override
  String id;

  @override
  String hfId;

  @override
  String username;

  @override
  String avatar;

  @override
  String accessToken;

  @override
  String refreshToken;

  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  User(
      {this.id,
      this.hfId,
      this.username,
      this.avatar,
      this.accessToken,
      this.refreshToken,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map data) {
    return new User(
        id: data['id'],
        hfId: data['hf_id'],
        username: data['username'],
        avatar: data['avatar'],
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
        createdAt: data['created_at'] is DateTime
            ? data['created_at']
            : (data['created_at'] is String
                ? DateTime.parse(data['created_at'])
                : null),
        updatedAt: data['updated_at'] is DateTime
            ? data['updated_at']
            : (data['updated_at'] is String
                ? DateTime.parse(data['updated_at'])
                : null));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'hf_id': hfId,
        'username': username,
        'avatar': avatar,
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String()
      };

  static User parse(Map map) => new User.fromJson(map);

  User clone() {
    return new User.fromJson(toJson());
  }
}
