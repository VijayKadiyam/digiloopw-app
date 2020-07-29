import 'package:flutter/material.dart';
import 'dart:io';

// Utils
import '../utils/utils.dart';

// Widgets
import '../widgets/drawer_w.dart';

// Scoped model
import '../scoped_models/main_sm.dart';

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage({@required this.model});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> _tabData = [
    {
      'name': 'KYC',
      'url': '/listings',
      'arguments': {
        'type': 1,
      }
    },
    {
      'name': 'WholeSale',
      'url': '/listings',
      'arguments': {
        'type': 2,
      }
    },
  ];
  @override
  void initState() {
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
                // Navigator.of(context).pop(true);
                exit(0);
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                widget.model.logout();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
        body: Container(
          width: Dimensions().getWidth(context),
          height: Dimensions().getHeight(context),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hi, ' + widget.model.authenticatedUser.name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                ..._tabData.map((_tab) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, _tab['url'],
                          arguments: _tab['arguments']);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 120,
                          // color: Colors.red,
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                              ),
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            width: Dimensions().getWidth(context) - 20,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(ImagesPath.backgroundImage),
                                  fit: BoxFit.fill),
                            ),
                            child: Center(
                              child: Text(
                                _tab['name'],
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  // bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
