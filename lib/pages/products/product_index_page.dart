import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

// Widgets
import '../../widgets/button_w.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

class ProductIndexPage extends StatefulWidget {
  final MainModel model;
  // arguments: listing_id, name
  final Map<String, dynamic> arguments;

  ProductIndexPage({
    @required this.model,
    @required this.arguments,
  });

  @override
  _ProductIndexPageState createState() => _ProductIndexPageState();
}

class _ProductIndexPageState extends State<ProductIndexPage> {
  String _name;
  int _listingId;

  @override
  void initState() {
    _name = widget.arguments['name'];
    _listingId = widget.arguments['id'];
    getListingDetails();
    super.initState();
  }

  getListingDetails() {
    widget.model.updateDetails();
  }

  getListingProducts() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
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
                  _name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                if (widget.model.products.length > 0)
                  ...widget.model.products.map((product) {
                    if (product.listingId == _listingId)
                      return ButtonWidget(
                        id: product.id,
                        name: product.name,
                        url: '/sub_products',
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
