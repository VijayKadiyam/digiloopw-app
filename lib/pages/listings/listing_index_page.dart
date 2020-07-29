import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

// Widgets
import '../../widgets/drawer_w.dart';
import '../../widgets/button_w.dart';

// Scoped model
import '../../scoped_models/main_sm.dart';

class ListingIndexPage extends StatefulWidget {
  final MainModel model;
  // type
  final arguments;
  ListingIndexPage({@required this.model, @required this.arguments});

  @override
  _ListingIndexPageState createState() => _ListingIndexPageState();
}

class _ListingIndexPageState extends State<ListingIndexPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int type;

  @override
  void initState() {
    type = widget.arguments['type'];
    getListingDetails();
    super.initState();
  }

  getListingDetails() {
    widget.model.updateDetails();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressedForAppExit() {
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Are you sure you want to exit the app'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressedForAppExit,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(
          model: widget.model,
        ),
        appBar: AppBar(
          title: Text('Digiloop'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                );
              },
            ),
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
                    type == 1
                        ? 'Detail for KYC'
                        : 'Buy Digital Signature & Token',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.model.listings.length > 0)
                    ...widget.model.listings.map((listing) {
                      if (listing.type == type)
                        return ButtonWidget(
                          id: listing.id,
                          name: listing.name,
                          url: '/products',
                        );
                      else
                        return Container();
                    }).toList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
