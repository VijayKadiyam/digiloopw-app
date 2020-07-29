import 'package:flutter/material.dart';

// Utils
import '../../utils/utils.dart';

// Widgets
import '../../widgets/errors_w.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Models
import '../../models/my_response_m.dart';

class RegisterPage extends StatefulWidget {
  final MainModel model;
  RegisterPage({@required this.model});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _registerData = {
    'name': '',
    'email': '',
    'password': '',
    'password_confirmation': '',
    'active': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                    Image.asset(
                      ImagesPath.logoPath,
                      height: 80,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter name',
                            ),
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter name';
                              return null;
                            },
                            onSaved: (value) {
                              _registerData['name'] = value;
                            },
                          ),
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter phone',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter phone';
                              return null;
                            },
                            onSaved: (value) {
                              _registerData['phone'] = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter password';
                              return null;
                            },
                            onSaved: (value) {
                              _registerData['password'] = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please confirm the password';
                              return null;
                            },
                            onSaved: (value) {
                              _registerData['password_confirmation'] = value;
                            },
                          ),
                          ErrorsWidget(
                            model: widget.model,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.model.isLoading
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    'Register',
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
                                      MyResponse _response =
                                          await widget.model.register(
                                        registerData: _registerData,
                                      );
                                      if (_response.success)
                                        showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            title: Text(
                                                'Thank you for your registration. Your account will be active shortly.'),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator
                                                      .pushReplacementNamed(
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
