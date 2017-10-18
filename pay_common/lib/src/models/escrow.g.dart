// GENERATED CODE - DO NOT MODIFY BY HAND

part of pay_common.src.models.escrow;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class Escrow extends _Escrow {
  @override
  String id;

  @override
  String buyer;

  @override
  String seller;

  @override
  String productId;

  @override
  num price;

  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  Escrow(
      {this.id,
      this.buyer,
      this.seller,
      this.productId,
      this.price,
      this.createdAt,
      this.updatedAt});

  factory Escrow.fromJson(Map data) {
    return new Escrow(
        id: data['id'],
        buyer: data['buyer'],
        seller: data['seller'],
        productId: data['product_id'],
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
        'buyer': buyer,
        'seller': seller,
        'product_id': productId,
        'price': price,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String()
      };

  static Escrow parse(Map map) => new Escrow.fromJson(map);

  Escrow clone() {
    return new Escrow.fromJson(toJson());
  }
}
