import 'package:flutter/material.dart';

// Utils
import '../../utils/utils.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

class ForgotPasswordPage extends StatefulWidget {
  final MainModel model;

  ForgotPasswordPage({@required this.model});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _registerData = {
    'email': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Password Reset Email'),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesPath.backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 20,
              child: Container(
                // color: Colors.green[100],
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter email',
                            ),
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter email';
                              return null;
                            },
                            onSaved: (value) {
                              _registerData['email'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.model.isLoading
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    'Send Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      widget.model.sendPasswordResetEmail(
                                        authData: _registerData,
                                      );
                                      showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text(
                                              'Reset Password Email Sent. Please check your Inbox'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, '/');
                                              },
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
