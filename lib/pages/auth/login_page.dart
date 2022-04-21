import 'package:flutter/material.dart';

// Utils
import '../../utils/utils.dart';

// Models
import '../../models/my_response_m.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

// Widgets
import '../../widgets/errors_w.dart';

class LoginPage extends StatefulWidget {
  final MainModel model;

  LoginPage({@required this.model});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  Map<String, dynamic> _loginData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesPath.backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        height: Dimensions().getHeight(context),
        width: Dimensions().getWidth(context),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Form(
                  key: _loginKey,
                  child: Card(
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            ImagesPath.logoPath,
                            height: 80,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter email/phone...',
                            ),
                            initialValue: '',
                            // initialValue: 'email10@gmail.com',
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter email';
                              return null;
                            },
                            onSaved: (value) {
                              _loginData['email'] = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter password...',
                            ),
                            obscureText: true,
                            initialValue: '',
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter password';
                              return null;
                            },
                            onSaved: (value) {
                              _loginData['password'] = value;
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
                                    'Login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  onPressed: () async {
                                    if (_loginKey.currentState.validate()) {
                                      _loginKey.currentState.save();

                                      MyResponse _response =
                                          await widget.model.login(
                                        loginData: _loginData,
                                      );

                                      // if (!_response.success) {
                                      //   showDialog(
                                      //     context: context,
                                      //     child: AlertDialog(
                                      //       title: Text(_response.message),
                                      //       actions: <Widget>[
                                      //         FlatButton(
                                      //           child: Text('Ok'),
                                      //           onPressed: () {
                                      //             Navigator.pop(context);
                                      //           },
                                      //         )
                                      //       ],
                                      //     ),
                                      //   );
                                      // }
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: Text(
                                      'Register',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/forgot-password');
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '© HYPERXSERVE SOLUTIONS LLP',
                            style: Theme.of(context).textTheme.headline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   'Powered By: AAIBUZZ',
                          //   style: Theme.of(context).textTheme.headline,
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
