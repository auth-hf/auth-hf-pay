library pay_common.src.models.escrow;

import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
part 'escrow.g.dart';

@serializable
class _Escrow extends Model {
  String buyer, seller, productId, uploadId;
  num price;

  // Payment info
  String gateway, transactionId;

  bool get paid {
    return transactionId != null;
  }
}

abstract class Gateway {
  static const String stripe = 'stripe',
      paypal = 'paypal',
      coinPayments = 'coin_payments';

  static const List<String> all = const [
    stripe,
    paypal,
    coinPayments,
  ];
}
