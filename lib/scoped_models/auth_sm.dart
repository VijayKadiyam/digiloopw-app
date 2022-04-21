import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Scoped Model
import 'connected_sm.dart';

// Models
import '../models/my_response_m.dart';
import '../models/user_m.dart';

// Utils
import '../utils/network.dart';
import '../utils/utils.dart';

mixin AuthModel on ConnectedModel {
  bool _success;
  String _message;

  Future<MyResponse> login({@required loginData}) async {
    setLoading();

    final Map<String, dynamic> _responseData = await Network().post(
      url: 'login',
      body: loginData,
    );

    _success = false;
    _message = Messages.httpError;

    if (_responseData['success'] == null) {
      errors = _responseData['errors'];
    } else if (_responseData['success']) {
      _success = true;
      _message = 'Logged in successfully';
      Map<String, dynamic> _userData = _responseData['data'];
      assignAuthenticatedUser(_userData);
      Network().setToken(authenticatedUser);
      await getCompanyDetails();
    }

    isAuthChecked = true;
    unSetLoading();

    return MyResponse(
      success: _success,
      message: _message,
    );
  }

  Future<MyResponse> register(
      {@required Map<String, dynamic> registerData}) async {
    setLoading();

    Map<String, dynamic> _responseData = await Network().post(
      url: 'register',
      body: registerData,
    );

    if (_responseData['success'] == null) {
      errors = _responseData['errors'];
      _success = false;
      _message = "Something went wrong";
    } else if (_responseData['success']) {
      _success = true;
      _message = 'Registered successfully';
      Map<String, dynamic> _userData = _responseData['data'];
      // Role User
      Map<String, dynamic> _roleUserData = {
        'user_id': _userData['id'],
        'role_id': 3
      };
      await Network().post(
        url: 'role_user',
        body: _roleUserData,
      );
      // Company User
      Map<String, dynamic> _companyUserData = {
        'user_id': _userData['id'],
        'company_id': 1
      };
      await Network().post(
        url: 'company_user',
        body: _companyUserData,
      );
      // assignAuthenticatedUser(_userData);
      // Network().setToken(authenticatedUser);
    }

    unSetLoading();

    return MyResponse(
      success: _success,
      message: _message,
    );
  }

  void sendPasswordResetEmail({@required authData}) {
    setLoading();

    Network().post(
      url: 'forgot_password',
      body: authData,
    );

    unSetLoading();
  }

  void autoAuthenticate() async {
    setLoading();

    final Map<String, dynamic> _responseData = await Network().get(
      url: 'me',
    );

    _success = false;
    _message = Messages.httpError;

    if (_responseData['success'] == null) {
      errors = _responseData['errors'];
    } else if (_responseData['success']) {
      _success = true;
      _message = 'Logged in successfully';
      Map<String, dynamic> _userData = _responseData['data'];
      assignAuthenticatedUser(_userData);
      await getCompanyDetails();
    }

    isAuthChecked = true;
    unSetLoading();
  }

  void logout() {
    setLoading();

    Network().unSetToken();
    authenticatedUser = null;

    unSetLoading();
  }

  void assignAuthenticatedUser(Map<String, dynamic> _userData) {
    authenticatedUser = User(
      id: _userData['id'] ?? null,
      name: _userData['name'] ?? '',
      apiToken: _userData['api_token'] ?? '',
      email: _userData['email'] ?? '',
      phone: int.parse(_userData['phone'].toString()) ?? null,
      canSendEmail: _userData['can_send_email'] ?? null,
      organizationName: _userData['organization_name'] ?? '',
      address1: _userData['address_1'] ?? '',
      address2: _userData['address_2'] ?? '',
      state: _userData['state'] ?? '',
      stateCode: _userData['state_code'] ?? '',
      gstRegistered: _userData['gst_registered'] ?? '',
      gstin: _userData['gstin'] ?? '',
      pan: _userData['pan_no'] ?? '',
      companies: _userData['companies'] ?? [],
      logins: _userData['logins'] ?? [],
    );
  }

  void getCompanyDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String details = _prefs.getString('companyDetails');
    companyDetails = details;
  }

  Future<MyResponse> updateUser(
      {@required Map<String, dynamic> userData}) async {
    setLoading();
    final Map<String, dynamic> _responseData = await Network().patch(
      url: 'users/${authenticatedUser.id}',
      body: userData,
    );

    if (_responseData['success'] == null) {
      _success = false;
      _message = 'Something went wrong';
      errors = _responseData['errors'];
    } else if (_responseData['success']) {
      _success = true;
      _message = 'Updated Successfully';
      Map<String, dynamic> _userData = _responseData['data'];
      assignAuthenticatedUser(_userData);
      await getCompanyDetails();
    }

    unSetLoading();

    return MyResponse(
      success: _success,
      message: _message,
    );
  }
}
