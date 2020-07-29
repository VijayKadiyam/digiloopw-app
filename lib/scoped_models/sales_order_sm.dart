import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Utils
import '../utils/network.dart';

// Scoped Model
import 'connected_sm.dart';

// Models
import '../models/sales_order_m.dart';
import '../models/sales_order_detail_m.dart';
import '../models/my_response_m.dart';

mixin SalesOrderModel on ConnectedModel {
  String _message;
  bool _success;

  void addPayment({@required Map<String, dynamic> paymentData}) {
    setLoading();

    payments.add(paymentData);

    unSetLoading();
  }

  void fetchSalesOrders() async {
    setLoading();

    final Map<String, dynamic> _responseData = await Network().get(
      url: 'sales_orders?userId=${authenticatedUser.id}',
    );

    if (_responseData['success'] == null) {
      errors = _responseData['errors'];
    } else if (_responseData['success']) {
      List<dynamic> _salesOrdersData = _responseData['data'];
      salesOrders = [];
      _salesOrdersData.forEach((_order) {
        List<SalesOrderDetail> _salesOrderDetails = [];
        _order['sales_order_details'].forEach((_detail) {
          _salesOrderDetails.add(
            SalesOrderDetail(
              id: _detail['id'] ?? null,
              name: _detail['sub_product']['product']['listing']['name'] +
                  ' / ' +
                  _detail['sub_product']['product']['name'] +
                  ' / ' +
                  _detail['sub_product']['name'],
              gstPercent: int.parse(_detail['sub_product']['tax_rate']) ?? '',
              subProductId: _detail['sub_product']['id'] ?? null,
              quantityId: _detail['quantity_id'] ?? null,
              quantity: _detail['quantity']['qty'] ?? null,
              rate: double.parse(_detail['rate'].toString()) ?? null,
              amount: double.parse(_detail['amount'].toString()) ?? null,
              createdBy: _detail['created_by'] ?? '',
            ),
          );
        });

        salesOrders.add(
          SalesOrder(
            id: _order['id'] ?? null,
            userId: _order['user_id'] ?? null,
            createdBy: _order['created_by'] ?? '',
            date: _order['date'] ?? '',
            amount: _order['amount'] ?? null,
            gst: _order['gst'] ?? null,
            grossTotal: _order['gross_total'] ?? null,
            status: _order['status'] ?? '',
            salesOrderDetails: _salesOrderDetails,
            logistics: _order['logistics'],
          ),
        );
      });
    }

    unSetLoading();
  }

  void addOrUpdateSalesOrder(
      {@required Map<String, dynamic> salesOrderDetailData}) {
    setLoading();

    SalesOrderDetail salesOrderDetail = salesOrder.salesOrderDetails.firstWhere(
      (salesOrderDetail) =>
          salesOrderDetail.subProductId ==
          salesOrderDetailData['sub_product_id'],
      orElse: () => null,
    );

    if (salesOrderDetail != null) {
      salesOrderDetail.name = salesOrderDetailData['name'];
      salesOrderDetail.subProductId = salesOrderDetailData['sub_product_id'];
      salesOrderDetail.quantityId =
          int.parse(salesOrderDetailData['quantity_id']);
      salesOrderDetail.quantity = int.parse(salesOrderDetailData['quantity']);
      salesOrderDetail.rate = double.parse(salesOrderDetailData['rate']);
      salesOrderDetail.amount = double.parse(salesOrderDetailData['amount']);
    } else {
      salesOrder.salesOrderDetails.add(
        SalesOrderDetail(
          name: salesOrderDetailData['name'],
          subProductId: salesOrderDetailData['sub_product_id'],
          quantityId: int.parse(salesOrderDetailData['quantity_id']),
          quantity: int.parse(salesOrderDetailData['quantity']),
          rate: double.parse(salesOrderDetailData['rate']),
          amount: double.parse(salesOrderDetailData['amount']),
          createdBy: '2',
        ),
      );
    }

    unSetLoading();
  }

  removeSalesOrderDetail({@required SalesOrderDetail salesOrderDetail}) {
    setLoading();

    salesOrder.salesOrderDetails = salesOrder.salesOrderDetails
        .where((detail) => detail.subProductId != salesOrderDetail.subProductId)
        .toList();

    unSetLoading();
  }

  Future<MyResponse> addSalesOrder({@required loginId}) async {
    setLoading();

    salesOrder.date = DateFormat('dd-MM-yyyy').format(DateTime.now());

    double _total = 0;
    salesOrder.salesOrderDetails.forEach((detail) {
      _total += detail.amount;
    });
    salesOrder.amount = _total.toString();

    salesOrder.status = '3';

    Map<String, dynamic> _order = {
      'user_id': authenticatedUser.id,
      'created_by': salesOrder.createdBy,
      'date': salesOrder.date,
      'amount': salesOrder.amount,
      'gst': salesOrder.gst,
      'gross_total': salesOrder.grossTotal,
      'status': salesOrder.status,
      'login_id': loginId,
      'products': [],
      'payments': [],
    };

    salesOrder.salesOrderDetails.forEach((detail) {
      _order['products'].add({
        'sub_product_id': detail.subProductId,
        'quantity_id': detail.quantityId,
        'rate': detail.rate,
        'amount': detail.amount,
        'created_by': detail.createdBy,
      });
    });

    final Map<String, dynamic> _responseData = await Network().post(
      url: 'sales_orders',
      body: _order,
    );

    if (_responseData['success'] == null) {
      _success = false;
      _message = 'Something went wrong';
    } else if (_responseData['success']) {
      int id = _responseData['data']['id'];

      // Add payment
      await addPaymentDetals(
        salesOrderId: id,
      );

      // Send Email
      Network().get(url: 'emails/order-received');

      _success = true;
      _message =
          'Order Successfully Placed. If you do not receive confirmation within 10 minutes, call us.';
    }
    emptyOrder();

    unSetLoading();

    return MyResponse(
      success: _success,
      message: _message,
    );
  }

  addPaymentDetals({@required int salesOrderId}) async {
    // Add payment
    if (payments.length > 0)
      await Network().postMultiPartPayment(
        url: 'sales_orders/$salesOrderId/sales_order_payments',
        body: payments[0],
      );
  }

  void emptyOrder() {
    salesOrder = SalesOrder(
      createdBy: '2',
      salesOrderDetails: [],
    );
  }
}
