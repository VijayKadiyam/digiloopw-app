import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/sub_product_m.dart';
import '../../models/product_m.dart';
import '../../models/listing_m.dart';

class AddToCartPage extends StatefulWidget {
  final MainModel model;
  // arguments: sub_product_id, name
  final Map<String, dynamic> arguments;

  AddToCartPage({
    @required this.model,
    @required this.arguments,
  });

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  String _name;
  int _subProductId;
  SubProduct _subProduct;
  Product _product;
  Listing _listing;
  List<Map<String, dynamic>> _quantities = [
    {
      'name': 'Select Qty',
      'value': '',
      'price': '0',
    },
  ];

  Map<String, dynamic> _detailsData = {
    'name': '',
    'sub_product_id': '',
    'quantity': '',
    'quantity_id': '',
    'rate': '0',
    'amount': '0',
  };

  @override
  void initState() {
    _name = widget.arguments['name'];
    _subProductId = widget.arguments['id'];
    getListingDetails();
    getSubProduct();
    getProduct();
    getListing();
    getQuantities();
    _detailsData['sub_product_id'] = _subProductId;
    _detailsData['name'] =
        _listing.name + ' / ' + _product.name + ' / ' + _subProduct.name;
    super.initState();
  }

  getListingDetails() {
    widget.model.updateDetails();
  }

  getSubProduct() {
    _subProduct = widget.model.subProducts
        .where((subProduct) => subProduct.id == _subProductId)
        .toList()[0];
  }

  getProduct() {
    _product = widget.model.products
        .where((product) => product.id == _subProduct.productId)
        .toList()[0];
  }

  getListing() {
    _listing = widget.model.listings
        .where((listing) => listing.id == _product.listingId)
        .toList()[0];
  }

  getQuantities() {
    _quantities = [
      {
        'name': 'Select Qty',
        'value': '',
        'price': '0',
      },
    ];
    widget.model.quantities.forEach((q) {
      if (q.subProductId == _subProductId) {
        _quantities.add(
          {
            'name': q.quantity.toString(),
            'value': q.id.toString(),
            'price': q.price.toString(),
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add to Cart'),
          actions: <Widget>[
            Badge(
              position: BadgePosition.topRight(top: 0, right: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                widget.model.salesOrder.salesOrderDetails.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ),
          ],
        ),
        body: Container(
          // width: Dimensions().getWidth(context),
          // height: Dimensions().getHeight(context),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage(ImagesPath.backgroundImage),
          //       fit: BoxFit.fill),
          // ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _listing.name + ' --> ' + _product.name + ' --> ' + _name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        // Quantity
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Qty:',
                                  style: Theme.of(context).textTheme.title,
                                ),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _detailsData['quantity_id'] = value;
                                      Map<String, dynamic> _quantity =
                                          _quantities
                                              .where(
                                                  (_q) => _q['value'] == value)
                                              .toList()[0];

                                      _detailsData['amount'] = (double.parse(
                                                  _quantity['price']) *
                                              double.parse(_quantity['name']))
                                          .toString();

                                      _detailsData['quantity'] =
                                          _quantity['name'];

                                      _detailsData['rate'] = (double.parse(
                                                  _detailsData['amount']) /
                                              double.parse(
                                                  _detailsData['quantity']))
                                          .toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Rate
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Rate (Inc. GST):',
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '₹ ' + _detailsData['rate'],
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Total
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Total (Inc. GST):',
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '₹ ' + _detailsData['amount'],
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (_detailsData['quantity'] == '') {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text('Please enter quantity'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      } else {
                        widget.model.addOrUpdateSalesOrder(
                          salesOrderDetailData: _detailsData,
                        );
                        Fluttertoast.showToast(
                          msg: "Added To Cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Add to Cart',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/listings');
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
