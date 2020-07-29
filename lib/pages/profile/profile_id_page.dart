import 'package:flutter/material.dart';

// Models
import '../../models/my_response_m.dart';

// Scoped Models
import '../../scoped_models/main_sm.dart';

class ProfileIdPage extends StatefulWidget {
  final MainModel model;
  ProfileIdPage({@required this.model});

  @override
  _ProfileIdPageState createState() => _ProfileIdPageState();
}

class _ProfileIdPageState extends State<ProfileIdPage> {
  GlobalKey<FormState> _profileKey = GlobalKey<FormState>();

  Map<String, dynamic> _profileData = {
    'name': '',
    'email': '',
    'phone': '',
    'organization_name': '',
    'address_1': '',
    'address_2': '',
    'state': '',
    'gst_registered': '',
    'gstin': '',
    'pan_no': '',
  };

  List<Map<String, dynamic>> _states = [
    {'name': 'Select State', 'value': ''},
    {'name': 'Maharashtra', 'value': 'MH'},
  ];

  List<Map<String, dynamic>> _gstRegistered = [
    {'name': 'Select GST Status', 'value': ''},
    {'name': 'YES', 'value': 'YES'},
    {'name': 'NO', 'value': 'NO'},
  ];

  @override
  void initState() {
    _profileData['state'] = widget.model.authenticatedUser.state;
    _profileData['gst_registered'] =
        widget.model.authenticatedUser.gstRegistered;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Edit Profile'),
      ),
      body: Container(
        // color: Colors.green[100],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _profileKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter name...',
                            ),
                            initialValue: widget.model.authenticatedUser.name,
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter name';
                              return null;
                            },
                            onSaved: (value) {
                              _profileData['name'] = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter email...',
                    ),
                    initialValue: widget.model.authenticatedUser.email,
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter email';
                      return null;
                    },
                    onSaved: (value) {
                      _profileData['email'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter phone...',
                    ),
                    keyboardType: TextInputType.number,
                    initialValue:
                        widget.model.authenticatedUser.phone.toString(),
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter phone';
                      return null;
                    },
                    onSaved: (value) {
                      _profileData['phone'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter organization name',
                    ),
                    initialValue:
                        widget.model.authenticatedUser.organizationName,
                    onSaved: (value) {
                      _profileData['organization_name'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter address 1',
                    ),
                    initialValue: widget.model.authenticatedUser.address1,
                    onSaved: (value) {
                      _profileData['address_1'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter address 2',
                    ),
                    initialValue: widget.model.authenticatedUser.address2,
                    onSaved: (value) {
                      _profileData['address_2'] = value;
                    },
                  ),
                  DropdownButtonFormField(
                    value: _profileData['state'],
                    items: _states.map((_state) {
                      return DropdownMenuItem(
                        value: _state['value'],
                        child: Text(_state['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _profileData['state'] = value;
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    value: _profileData['gst_registered'],
                    items: _gstRegistered.map((_gst) {
                      return DropdownMenuItem(
                        value: _gst['value'],
                        child: Text(_gst['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _profileData['gst_registered'] = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'GSTIN',
                    ),
                    initialValue: widget.model.authenticatedUser.gstin,
                    onSaved: (value) {
                      _profileData['gstin'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Organization PAN',
                    ),
                    initialValue: widget.model.authenticatedUser.pan,
                    onSaved: (value) {
                      _profileData['pan_no'] = value;
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
                            'Update Profile',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          onPressed: () async {
                            if (_profileKey.currentState.validate()) {
                              _profileKey.currentState.save();
                              MyResponse _response =
                                  await widget.model.updateUser(
                                userData: _profileData,
                              );
                              widget.model.autoAuthenticate();

                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    _response.message,
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              );
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
