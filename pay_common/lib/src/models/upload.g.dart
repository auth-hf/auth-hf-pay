// GENERATED CODE - DO NOT MODIFY BY HAND

part of pay_common.src.models.upload;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class Upload extends _Upload {
  @override
  String id;

  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  Upload({this.id, this.createdAt, this.updatedAt});

  factory Upload.fromJson(Map data) {
    return new Upload(
        id: data['id'],
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
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String()
      };

  static Upload parse(Map map) => new Upload.fromJson(map);

  Upload clone() {
    return new Upload.fromJson(toJson());
  }
}
