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
    'organization_name': '',
    'state': 'Maharashtra',
    'state_code': '',
  };

  List<Map<String, dynamic>> _states = [
    {'name': 'Select State', 'code': ''},
    {'name': 'Jammu & Kashmir', 'code': '1'},
    {'name': 'Himachal Pradesh', 'code': '2'},
    {'name': 'Punjab', 'code': '3'},
    {'name': 'Chandigarh', 'code': '4'},
    {'name': 'Uttarakhand', 'code': '5'},
    {'name': 'Haryana', 'code': '6'},
    {'name': 'Delhi', 'code': '7'},
    {'name': 'Rajasthan', 'code': '8'},
    {'name': 'Uttar Pradesh', 'code': '9'},
    {'name': 'Bihar', 'code': '10'},
    {'name': 'Sikkim', 'code': '11'},
    {'name': 'Arunachal Pradesh', 'code': '12'},
    {'name': 'Nagaland', 'code': '13'},
    {'name': 'Manipur', 'code': '14'},
    {'name': 'Mizoram', 'code': '15'},
    {'name': 'Tripura', 'code': '16'},
    {'name': 'Meghalaya', 'code': '17'},
    {'name': 'Assam', 'code': '18'},
    {'name': 'West Bengal', 'code': '19'},
    {'name': 'Jharkhand', 'code': '20'},
    {'name': 'Orissa', 'code': '21'},
    {'name': 'Chattisgarh', 'code': '22'},
    {'name': 'Madhya Pradesh', 'code': '23'},
    {'name': 'Gujarat', 'code': '24'},
    {'name': 'Daman & Diu', 'code': '25'},
    {'name': 'Dadra * Nagar Haveli', 'code': '26'},
    {'name': 'Maharashtra', 'code': '27'},
    {'name': 'Andhra Pradesh', 'code': '28'},
    {'name': 'Karnataka', 'code': '29'},
    {'name': 'Goa', 'code': '30'},
    {'name': 'Lakshadweep', 'code': '31'},
    {'name': 'Kerala', 'code': '32'},
    {'name': 'Tamil Nadu', 'code': '33'},
    {'name': 'Puducherry', 'code': '34'},
    {'name': 'Andaman & Nicobar Island', 'code': '35'},
    {'name': 'Telangana', 'code': '36'},
    {'name': 'Andhra Pradesh (New)', 'code': '37'},
  ];

  @override
  void initState() {
    List<Map<String, dynamic>> selectedStates = _states
        .where((_state) => _state['name'] == _registerData['state'])
        .toList();
    Map<String, dynamic> _selectedState;
    if (selectedStates.length > 0) {
      _selectedState = selectedStates[0];
      _registerData['state_code'] = _selectedState['code'];
    }
    super.initState();
  }

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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter organization name',
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please organization name';
                              return null;
                            },
                            onSaved: (value) {
                              _registerData['organization_name'] = value;
                            },
                          ),
                          DropdownButtonFormField(
                            value: _registerData['state'],
                            items: _states.map((_state) {
                              return DropdownMenuItem(
                                value: _state['name'],
                                child: Text(_state['name']),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter state';
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _registerData['state'] = value;
                                List<Map<String, dynamic>> selectedStates =
                                    _states
                                        .where(
                                            (_state) => _state['name'] == value)
                                        .toList();
                                Map<String, dynamic> _selectedState;
                                if (selectedStates.length > 0) {
                                  _selectedState = selectedStates[0];
                                  _registerData['state_code'] =
                                      _selectedState['code'];
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('State Code: ' + _registerData['state_code']),
                          SizedBox(
                            height: 10,
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
