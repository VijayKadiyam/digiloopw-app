import 'package:digiloopw_app/utils/utils.dart';
import 'package:flutter/material.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/my_response_m.dart';

// Widgets
import '../../widgets/take_image_w.dart';

class CartPage extends StatefulWidget {
  final MainModel model;
  CartPage({@required this.model});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int loginId;
  String address;
  TextEditingController _addressController = TextEditingController();

  List<Map<String, dynamic>> _logins = [
    {
      'name': 'Select Login',
      'value': null,
    }
  ];

  @override
  void initState() {
    _addressController.text = widget.model.authenticatedUser.address1 +
        ' ' +
        widget.model.authenticatedUser.address2 +
        widget.model.authenticatedUser.state;
    getLogins();
    super.initState();
  }

  getLogins() {
    widget.model.authenticatedUser.logins.forEach((_login) {
      _logins.add({
        'name': _login['name'],
        'value': _login['id'],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/listings',
              arguments: {
                'type': 2,
              },
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('My Cart'),
      ),
      body: Container(
        // color: Colors.green[100],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                // Header
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.blue[300]),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            'Product',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Qty',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Price',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Remove',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Values
                ...widget.model.salesOrder.salesOrderDetails.map(
                  (orderDetail) {
                    List<Map<String, dynamic>> _quantities = [
                      {
                        'name': 'Qty',
                        'value': '',
                        'price': '0',
                      },
                    ];
                    widget.model.quantities.forEach((q) {
                      if (q.subProductId == orderDetail.subProductId) {
                        _quantities.add(
                          {
                            'name': q.quantity.toString(),
                            'value': q.id.toString(),
                            'price': q.price.toString(),
                          },
                        );
                      }
                    });
                    Map<String, dynamic> _detailsData = {
                      'name': orderDetail.name,
                      'sub_product_id': orderDetail.subProductId,
                      'quantity': orderDetail.quantity,
                      'quantity_id': orderDetail.quantityId.toString(),
                      'rate': orderDetail.rate,
                      'amount': orderDetail.amount,
                    };
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(),
                          right: BorderSide(),
                          left: BorderSide(),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  orderDetail.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: DropdownButtonFormField(
                                value: _detailsData['quantity_id'],
                                items: _quantities.map((_quantity) {
                                  return DropdownMenuItem(
                                    value: _quantity['value'],
                                    child: Text(
                                      _quantity['name'],
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _detailsData['quantity_id'] = value;
                                    Map<String, dynamic> _quantity = _quantities
                                        .where((_q) => _q['value'] == value)
                                        .toList()[0];

                                    _detailsData['amount'] =
                                        (double.parse(_quantity['price']) *
                                                double.parse(_quantity['name']))
                                            .toString();

                                    _detailsData['quantity'] =
                                        _quantity['name'];

                                    _detailsData['rate'] =
                                        (double.parse(_detailsData['amount']) /
                                                double.parse(
                                                    _detailsData['quantity']))
                                            .toString();
                                    widget.model.addOrUpdateSalesOrder(
                                      salesOrderDetailData: _detailsData,
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '₹ ' + orderDetail.amount.toString(),
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: IconButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  widget.model.removeSalesOrderDetail(
                                    salesOrderDetail: orderDetail,
                                  );
                                },
                                icon: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Logins
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Dimensions().getWidth(context),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Select Login',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonFormField(
                              value: loginId,
                              items: _logins.map((_login) {
                                return DropdownMenuItem(
                                  value: _login['value'],
                                  child: Text(_login['name']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  loginId = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Address
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Dimensions().getWidth(context),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Address',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(fontSize: 15),
                          ),
                          TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Enter address',
                            ),
                            controller: _addressController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Payment Details
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Add Payment Details:',
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
                              salesOrderId: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Place Order
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/listings',
                                arguments: {
                                  'type': 2,
                                },
                              );
                            },
                            child: Text(
                              'Continue Shopping',
                              style: Theme.of(context).textTheme.title.copyWith(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Place Order',
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: Text('Confirm the order'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('No'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          if (loginId == null) {
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                title: Text(
                                                    'Please select the login'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            // Add address
                                            if (_addressController.text !=
                                                null) {
                                              Map<String, dynamic>
                                                  _profileData = {
                                                'name': widget.model
                                                    .authenticatedUser.name,
                                                'email': widget.model
                                                    .authenticatedUser.email,
                                                'phone': widget.model
                                                    .authenticatedUser.phone,
                                                'organization_name': widget
                                                    .model
                                                    .authenticatedUser
                                                    .organizationName,
                                                'address_1': widget.model
                                                    .authenticatedUser.address1,
                                                'address_2': widget.model
                                                    .authenticatedUser.address2,
                                                'state': widget.model
                                                    .authenticatedUser.state,
                                                'gst_registered': widget
                                                    .model
                                                    .authenticatedUser
                                                    .gstRegistered,
                                                'gstin': widget.model
                                                    .authenticatedUser.gstin,
                                                'pan_no': widget.model
                                                    .authenticatedUser.pan,
                                                'sales_order_address':
                                                    _addressController.text,
                                              };

                                              await widget.model.updateUser(
                                                userData: _profileData,
                                              );
                                            }

                                            // Add sales order
                                            Navigator.pop(context);
                                            MyResponse _response = await widget
                                                .model
                                                .addSalesOrder(
                                              loginId: loginId,
                                            );
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                title: Text(_response.message),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pushNamed(
                                                          context, '/');
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                // Payment Details
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Dimensions().getWidth(context),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Payment Details'),
                          Text(widget.model.companyDetails != null
                              ? widget.model.companyDetails
                              : ''),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
