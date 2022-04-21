import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/sub_product_m.dart';
import '../../models/product_m.dart';
import '../../models/listing_m.dart';
import '../../models/my_response_m.dart';

class SendKycIndexPage extends StatefulWidget {
  final MainModel model;
  // arguments: sub_product_id, name
  final Map<String, dynamic> arguments;

  SendKycIndexPage({
    @required this.model,
    @required this.arguments,
  });

  @override
  _SendKycIndexPageState createState() => _SendKycIndexPageState();
}

class _SendKycIndexPageState extends State<SendKycIndexPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  int _subProductId;
  SubProduct _subProduct;
  Product _product;
  Listing _listing;

  Map<String, dynamic> _detailsData = {
    'name': '',
    'sub_product_id': '',
  };

  Map<String, dynamic> _emailData = {
    'fromId': null,
    'fromName': null,
    'subProductId': null,
    'sendToEmail': null,
    'replyToEmail': null
  };

  @override
  void initState() {
    _name = widget.arguments['name'];
    _subProductId = widget.arguments['id'];
    getListingDetails();
    getSubProduct();
    getProduct();
    getListing();
    _detailsData['sub_product_id'] = _subProductId;
    _detailsData['name'] =
        _listing.name + ' / ' + _product.name + ' / ' + _subProduct.name;

    _emailData['fromId'] = widget.model.authenticatedUser.id;
    _emailData['fromName'] = widget.model.authenticatedUser.name;
    _emailData['subProductId'] = _subProduct.id;
    _emailData['replyToEmail'] = widget.model.authenticatedUser.email;
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

  whatsAppOpen() async {
    var url = "https://wa.me/" +
        _emailData['phone'] +
        "?text=" +
        (_subProduct.description != null ? _subProduct.description : '') +
        " %0A%0ALinks: %0A" +
        (_subProduct.image1Path != null && _subProduct.image1Path != ""
            ? (_subProduct.image1Description != null
                    ? _subProduct.image1Description
                    : '') +
                '%0A' +
                widget.model.mediaUrl +
                _subProduct.image1Path +
                '%0A%0A'
            : ' ') +
        (_subProduct.image2Path != null && _subProduct.image2Path != ""
            ? (_subProduct.image2Description != null
                    ? _subProduct.image2Description
                    : '') +
                '%0A' +
                widget.model.mediaUrl +
                _subProduct.image2Path +
                '%0A%0A'
            : ' ') +
        (_subProduct.image3Path != null && _subProduct.image3Path != ""
            ? (_subProduct.image3Description != null
                    ? _subProduct.image3Description
                    : '') +
                '%0A' +
                widget.model.mediaUrl +
                _subProduct.image3Path +
                '%0A%0A'
            : ' ') +
        (_subProduct.image4Path != null && _subProduct.image4Path != ""
            ? (_subProduct.image4Description != null
                    ? _subProduct.image4Description
                    : '') +
                '%0A' +
                widget.model.mediaUrl +
                _subProduct.image4Path +
                's%0A%0A'
            : ' ');

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Send KYC Details'),
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
        body: SingleChildScrollView(
          child: Container(
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
                    height: 10,
                  ),
                  Text(
                    _subProduct.description,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Send Requirement',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: 'Enter email...',
                              ),
                              // initialValue: 'kvjkumr@gmail.com',
                              validator: (value) {
                                if (value.isEmpty) return 'Please enter email';
                                return null;
                              },
                              onSaved: (value) {
                                _emailData['sendToEmail'] = value;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.phone),
                                labelText: 'Enter phone (include 91)...',
                              ),
                              // initialValue: '919579862371',
                              onSaved: (String value) {
                                _emailData['phone'] = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (widget
                                        .model.authenticatedUser.canSendEmail ==
                                    0) {
                                  Fluttertoast.showToast(
                                    msg: "Not Authorized to Send Email...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else {
                                  _formKey.currentState.save();

                                  if (_emailData['sendToEmail'] != null &&
                                      _emailData['sendToEmail'] != "") {
                                    Fluttertoast.showToast(
                                      msg: "Sending Email...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    widget.model.sendEmail(
                                      _emailData['fromId'].toString(),
                                      _emailData['fromName'],
                                      _emailData['sendToEmail'],
                                      _emailData['replyToEmail'],
                                      _emailData['subProductId'].toString(),
                                    );
                                    Fluttertoast.showToast(
                                      msg:
                                          "Email will be sent in 5-10 seconds...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please enter Email ID...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Send Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                _formKey.currentState.save();
                                if (_emailData['phone'] != null &&
                                    _emailData['phone'] != "") {
                                  whatsAppOpen();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Please enter Phone no...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: Text(
                                'Send on WhatsApp',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
