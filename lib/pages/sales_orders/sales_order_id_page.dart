import 'package:flutter/material.dart';

// Utils
import 'package:digiloopw_app/utils/utils.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Model
import '../../models/sales_order_m.dart';

class SalesOrderIdPage extends StatefulWidget {
  final MainModel model;
  final arguments;

  SalesOrderIdPage({@required this.model, @required this.arguments});

  @override
  _SalesOrderIdPageState createState() => _SalesOrderIdPageState();
}

class _SalesOrderIdPageState extends State<SalesOrderIdPage> {
  SalesOrder _salesOrder;

  List<String> _detailHeaders = [
    'Par.',
    'Rate',
    'Qty',
    // 'Net',
    // 'GST',
    'Total',
  ];

  @override
  void initState() {
    _salesOrder = widget.arguments['sales_order'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _getSubTotalFrom(total, gstPercent) {
      double gst = total - total * (100 / (100 + gstPercent));
      return (total - gst).toStringAsFixed(2);
    }

    String _getGstFrom(total, gstPercent) {
      double gst = total - total * (100 / (100 + gstPercent));
      return gst.toStringAsFixed(2);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Container(
        width: Dimensions().getWidth(context),
        height: Dimensions().getHeight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesPath.backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(5),
        child: widget.model.isLoading
            ? Text('Loading...')
            : ListView(
                children: [
                  Card(
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Order ID: ' + _salesOrder.id.toString(),
                            style:
                                Theme.of(context).textTheme.subtitle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Date
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Date:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _salesOrder.date.substring(0, 10),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          // Amount
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Amount:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹ ' +
                                      double.parse(_salesOrder.amount)
                                          .toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          // Gst
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'GST:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹ ' +
                                      (_salesOrder.gst != null
                                          ? double.parse(_salesOrder.gst)
                                              .toStringAsFixed(2)
                                          : ''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          // Gross Total
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Gross Total:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹ ' +
                                      (_salesOrder.grossTotal != null
                                          ? double.parse(_salesOrder.grossTotal)
                                              .toStringAsFixed(2)
                                          : ''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          // Status
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Status:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              if (_salesOrder.status == '0')
                                Expanded(
                                  child: Text(
                                    'Bal Pay Submit',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                              if (_salesOrder.status == '1')
                                Expanded(
                                  child: Text(
                                    'Submitted',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                              if (_salesOrder.status == '2')
                                Expanded(
                                  child: Text(
                                    'Rejected',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                              if (_salesOrder.status == '3')
                                Expanded(
                                  child: Text(
                                    'On Hold',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Sales Order Details',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Card(
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(),
                              ),
                            ),
                            child: Row(
                              children: _detailHeaders.map((_header) {
                                return Expanded(
                                  child: Text(
                                    _header,
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          ..._salesOrder.salesOrderDetails.map((_orderDetails) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(),
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          _orderDetails.name,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '₹ ' +
                                              _getSubTotalFrom(
                                                _orderDetails.rate,
                                                _orderDetails.gstPercent,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          _orderDetails.quantity.toString(),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Text(
                                      //     '₹ ' +
                                      //         _getSubTotalFrom(
                                      //           _orderDetails.amount,
                                      //           _orderDetails.gstPercent,
                                      //         ),
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   child: Text(
                                      //     '₹ ' +
                                      //         _getGstFrom(
                                      //           _orderDetails.amount,
                                      //           _orderDetails.gstPercent,
                                      //         ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Text(
                                          '₹ ' +
                                              _orderDetails.amount
                                                  .toStringAsFixed(2),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            );
                          }).toList(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹ ' +
                                      double.parse(_salesOrder.amount)
                                          .toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹ ' +
                                      (_salesOrder.gst != null
                                          ? double.parse(_salesOrder.gst)
                                              .toStringAsFixed(2)
                                          : ''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹ ' +
                                      (_salesOrder.grossTotal != null
                                          ? double.parse(_salesOrder.grossTotal)
                                              .toStringAsFixed(2)
                                          : ''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
