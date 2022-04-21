import 'package:flutter/material.dart';

// Scoped  Model
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/my_response_m.dart';

class LoginCreatePage extends StatefulWidget {
  final MainModel model;
  LoginCreatePage({@required this.model});

  @override
  _LoginCreatePageState createState() => _LoginCreatePageState();
}

class _LoginCreatePageState extends State<LoginCreatePage> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  Map<String, dynamic> _loginData = {
    'name': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Login'),
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
                      'Save Login',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_loginKey.currentState.validate()) {
                        _loginKey.currentState.save();
                        MyResponse _response = await widget.model.saveLogin(
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
