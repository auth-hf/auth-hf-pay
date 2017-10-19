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
  String uploadId;

  @override
  num price;

  @override
  String gateway;

  @override
  String transactionId;

  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  Escrow(
      {this.id,
      this.buyer,
      this.seller,
      this.productId,
      this.uploadId,
      this.price,
      this.gateway,
      this.transactionId,
      this.createdAt,
      this.updatedAt});

  factory Escrow.fromJson(Map data) {
    return new Escrow(
        id: data['id'],
        buyer: data['buyer'],
        seller: data['seller'],
        productId: data['product_id'],
        uploadId: data['upload_id'],
        price: data['price'],
        gateway: data['gateway'],
        transactionId: data['transaction_id'],
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
        'upload_id': uploadId,
        'price': price,
        'gateway': gateway,
        'transaction_id': transactionId,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String()
      };

  static Escrow parse(Map map) => new Escrow.fromJson(map);

  Escrow clone() {
    return new Escrow.fromJson(toJson());
  }
}
