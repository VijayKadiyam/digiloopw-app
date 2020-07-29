import 'package:flutter/material.dart';

// Utils
import '../../utils/utils.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

class ProfileIndexPage extends StatelessWidget {
  final MainModel model;

  ProfileIndexPage({@required this.model});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _userData = [
      {
        'name': 'Name',
        'value': model.authenticatedUser.name,
      },
      {
        'name': 'Email',
        'value': model.authenticatedUser.email,
      },
      {
        'name': 'Phone',
        'value': model.authenticatedUser.phone.toString(),
      },
      {
        'name': 'Organization Name',
        'value': model.authenticatedUser.organizationName
      },
      {
        'name': 'Address',
        'value': model.authenticatedUser.address1 +
            ' ' +
            model.authenticatedUser.address2 +
            model.authenticatedUser.state
      },
      {
        'name': 'GST Registered',
        'value': model.authenticatedUser.gstRegistered
      },
      {'name': 'GST No', 'value': model.authenticatedUser.gstin},
      {'name': 'Organization PAN No', 'value': model.authenticatedUser.pan}
    ];

    print(model.authenticatedUser.logins);
    List<Map<String, dynamic>> _loginsData = model.authenticatedUser.logins
        .map(
          (_login) => {
            'id': _login['id'],
            'name': 'Name',
            'value': _login['name'],
          },
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('My Profile'),
      ),
      body: Container(
        height: double.infinity,
        // color: Colors.green[100],
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(ImagesPath.maleAvatar),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model.authenticatedUser.name,
                  style: Theme.of(context).textTheme.headline,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/profileId');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0XFF5AC035),
                      ),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: Theme.of(context).textTheme.title.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/logins/create');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0XFF5AC035),
                      ),
                      child: Center(
                        child: Text(
                          'Add Login',
                          style: Theme.of(context).textTheme.title.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // User Details
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: _userData.map((data) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  data['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  data['value'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Logins
                Center(
                  child: Text(
                    'Logins',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: _loginsData.map((data) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  data['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      data['value'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .subhead
                                          .copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/loginId',
                                            arguments: {
                                              'login': data,
                                            });
                                      },
                                      child: Text(
                                        'edit',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
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
