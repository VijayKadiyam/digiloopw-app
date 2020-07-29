import 'package:flutter/foundation.dart';

// Scoped Models
import 'connected_sm.dart';

// Models
import '../models/my_response_m.dart';

// Utils
import '../utils/network.dart';

mixin LoginModel on ConnectedModel {
  Future<MyResponse> saveLogin({@required loginData}) async {
    final Map<String, dynamic> _responseData = await Network().post(
      url: 'users/${authenticatedUser.id}/logins',
      body: loginData,
    );

    bool _success = false;
    String _message = 'Something went wrong';
    if (_responseData['success'] == null) {
      errors = _responseData['errors'];
    }
    else if(_responseData['success']){
      _success = true;
      _message = 'Saved Successfully';
    }

    return MyResponse(
      success: _success,
      message: _message,
    );
  }

  Future<MyResponse> updateLogin({@required loginData}) async {
    final Map<String, dynamic> _responseData = await Network().patch(
      url: 'users/${authenticatedUser.id}/logins/${loginData['id']}',
      body: loginData,
    );

    bool _success = false;
    String _message = 'Something went wrong';
    if (_responseData['success'] == null) {
      errors = _responseData['errors'];
    }
    else if(_responseData['success']){
      _success = true;
      _message = 'Updated Successfully';
    }

    return MyResponse(
      success: _success,
      message: _message,
    );
  }
}
