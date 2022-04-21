import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

// Widgets
import '../../widgets/button_w.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/product_m.dart';
import '../../models/listing_m.dart';

class SubProductIndexPage extends StatefulWidget {
  final MainModel model;
  // arguments: product_id, name
  final Map<String, dynamic> arguments;

  SubProductIndexPage({
    @required this.model,
    @required this.arguments,
  });

  @override
  _SubProductIndexPageState createState() => _SubProductIndexPageState();
}

class _SubProductIndexPageState extends State<SubProductIndexPage> {
  String _name;
  int _productId;
  Product _product;
  Listing _listing;

  @override
  void initState() {
    _name = widget.arguments['name'];
    _productId = widget.arguments['id'];
    getListingDetails();
    getProduct();
    getListing();
    super.initState();
  }

  getListingDetails() {
    widget.model.updateDetails();
  }

  getProduct() {
    _product = widget.model.products
        .where((product) => product.id == _productId)
        .toList()[0];
  }

  getListing() {
    _listing = widget.model.listings
        .where((listing) => listing.id == _product.listingId)
        .toList()[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Products'),
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
        //       image: AssetImage(ImagesPath.backgroundImage), fit: BoxFit.fill),
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
                  _listing.name + ' --> ' + _name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                if (widget.model.subProducts.length > 0)
                  ...widget.model.subProducts.map((_subProduct) {
                    if (_subProduct.productId == _productId)
                      return ButtonWidget(
                        id: _subProduct.id,
                        name: _subProduct.name,
                        url: _listing.type == 1 ? '/send_kyc' : '/add_to_cart',
                      );
                    return Container();
                  }).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
