import 'package:flutter/foundation.dart';

class Quantity {
  final int id;
  final int subProductId;
  final int quantity;
  final int price;

  Quantity({
    @required this.id,
    @required this.subProductId,
    @required this.quantity,
    @required this.price,
  });
}
