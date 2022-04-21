// Models
import 'sales_order_detail_m.dart';

class SalesOrder {
  final int id;
  int userId;
  String createdBy;
  String date;
  String amount;
  String gst;
  String grossTotal;
  String status;
  List<SalesOrderDetail> salesOrderDetails;
  List<dynamic> payments;
  List<dynamic> logistics;

  SalesOrder({
    this.id,
    this.userId,
    this.createdBy,
    this.date,
    this.amount,
    this.gst,
    this.grossTotal,
    this.status,
    this.salesOrderDetails,
    this.payments,
    this.logistics,
  });
}
