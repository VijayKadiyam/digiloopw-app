import 'package:flutter/material.dart';

// Utils
import '../utils/utils.dart';

// Scoped Model
import '../scoped_models/main_sm.dart';

class DrawerWidget extends StatelessWidget {
  final MainModel model;
  DrawerWidget({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                  ImagesPath.maleAvatar,
                  height: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  model.authenticatedUser.name,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text(
              'My Orders',
              style: Theme.of(context).textTheme.headline,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Account Information',
              style: Theme.of(context).textTheme.headline,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.title,
            ),
            onTap: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text(
                    'Are you sure you want to logout?',
                    style: Theme.of(context).textTheme.title,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CANCEL',
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        model.logout();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
