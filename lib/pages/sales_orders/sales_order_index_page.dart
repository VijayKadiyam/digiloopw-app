import 'package:digiloopw_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Widgets
import '../../widgets/take_image_w.dart';

class SalesOrderIndexPage extends StatefulWidget {
  final MainModel model;

  SalesOrderIndexPage({@required this.model});

  @override
  _SalesOrderIndexPageState createState() => _SalesOrderIndexPageState();
}

class _SalesOrderIndexPageState extends State<SalesOrderIndexPage> {
  @override
  void initState() {
    widget.model.fetchSalesOrders();
    super.initState();
  }

  getInvoice(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
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
                children: widget.model.salesOrders.map((_salesOrder) {
                  return Card(
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
                          // Gross Total
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Invoice:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    String url = '';
                                    if (_salesOrder.logistics.length > 0) {
                                      url =
                                          '${widget.model.baseUrl}logistics/${_salesOrder.logistics[0]['id']}/stream';
                                      getInvoice(url);
                                    } else {
                                      showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text(
                                              'The Sales Order is still on hold'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Print Invoice',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 15, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Gross Total
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Payment Details:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: TakeImageWidget(
                                  model: widget.model,
                                  imagePath: '',
                                  salesOrderId: _salesOrder.id,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/orderId',
                                          arguments: {
                                            'sales_order': _salesOrder,
                                          });
                                    },
                                    child: Text(
                                      'Order Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: RaisedButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      _salesOrder.salesOrderDetails
                                          .forEach((detail) {
                                        Map<String, dynamic> _detailsData = {
                                          'name': detail.name,
                                          'sub_product_id': detail.subProductId,
                                          'quantity':
                                              detail.quantity.toString(),
                                          'quantity_id':
                                              detail.quantityId.toString(),
                                          'rate': detail.rate.toString(),
                                          'amount': detail.amount.toString(),
                                        };
                                        widget.model.addOrUpdateSalesOrder(
                                          salesOrderDetailData: _detailsData,
                                        );
                                        Navigator.pushNamed(context, '/cart');
                                      });
                                    },
                                    child: Text(
                                      'Re-Order',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
