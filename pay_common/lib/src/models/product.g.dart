// GENERATED CODE - DO NOT MODIFY BY HAND

part of pay_common.src.models.product;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class Product extends _Product {
  @override
  String id;

  @override
  String userId;

  @override
  String name;

  @override
  String description;

  @override
  String coverImage;

  @override
  num price;

  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  Product(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.coverImage,
      this.price,
      this.createdAt,
      this.updatedAt});

  factory Product.fromJson(Map data) {
    return new Product(
        id: data['id'],
        userId: data['user_id'],
        name: data['name'],
        description: data['description'],
        coverImage: data['cover_image'],
        price: data['price'],
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
        'user_id': userId,
        'name': name,
        'description': description,
        'cover_image': coverImage,
        'price': price,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String()
      };

  static Product parse(Map map) => new Product.fromJson(map);

  Product clone() {
    return new Product.fromJson(toJson());
  }
}
