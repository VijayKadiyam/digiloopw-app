import 'package:flutter/foundation.dart';

class SalesOrderDetail {
  final int id;
  final int salesOrderId;
  String name;
  int gstPercent;
  int subProductId;
  int quantityId;
  int quantity;
  double rate;
  double amount;
  final String createdBy;

  SalesOrderDetail({
    this.id,
    this.salesOrderId,
    this.name,
    @required this.subProductId,
    this.gstPercent,
    @required this.quantityId,
    @required this.quantity,
    @required this.rate,
    @required this.amount,
    @required this.createdBy,
  });
}
