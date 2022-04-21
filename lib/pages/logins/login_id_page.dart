import 'package:flutter/material.dart';

// Scoped  Model
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/my_response_m.dart';

class LoginIdPage extends StatefulWidget {
  final MainModel model;
  // Login
  var arguments;
  LoginIdPage({
    @required this.model,
    @required this.arguments,
  });

  @override
  _LoginIdPageState createState() => _LoginIdPageState();
}

class _LoginIdPageState extends State<LoginIdPage> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _loginData = {
      'id': widget.arguments['login']['id'],
      'name': widget.arguments['login']['value'],
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Login'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _loginKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Enter login name'),
                    initialValue: _loginData['name'],
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter name';
                      return null;
                    },
                    onSaved: (value) {
                      _loginData['name'] = value;
                    },
                  ),
                  Text(widget.model.errors != null ? widget.model.errors : ''),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Update Login',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_loginKey.currentState.validate()) {
                        _loginKey.currentState.save();
                        MyResponse _response = await widget.model.updateLogin(
                          loginData: _loginData,
                        );
                        widget.model.autoAuthenticate();

                        if (_response.success) {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text(_response.message),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    widget.model.autoAuthenticate();
                                    // Navigator.pushNamed(context, '/profile');
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
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
