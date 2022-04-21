import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Models
import '../models/user_m.dart';

// Scoped Models
import '../scoped_models/connected_sm.dart';

class Network extends Model with ConnectedModel {
  int _id;
  String _apiToken;
  int _companyId;

  Map<String, dynamic> _responseData;

  _getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _id = _prefs.getInt('id');
    _apiToken = _prefs.getString('apiToken');
    _companyId = _prefs.getInt('companyId');
  }

  setToken(User _userData) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('id', _userData.id);
    _prefs.setString('apiToken', _userData.apiToken);
    _prefs.setInt(
      'companyId',
      _userData.companies.length > 0 ? _userData.companies[0]['id'] : '',
    );
    _prefs.setString(
      'companyDetails',
      _userData.companies.length > 0
          ? _userData.companies[0]['other_details']
          : '-',
    );
  }

  unSetToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('id');
    _prefs.remove('apiToken');
    _prefs.remove('companyId');
    _prefs.remove('companyDetails');
  }

  _headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_apiToken',
      'company-id': '$_companyId',
    };
  }

  // Get Data
  Future get({@required url}) async {
    await _getToken();

    final http.Response _response = await http.get(
      '$baseUrl$url',
      headers: _headers(),
    );

    try {
      _responseData = json.decode(_response.body);
    } catch (Exception) {
      print(Exception);
    }

    return _responseData;
  }

  // Post Data
  Future post({@required url, @required body}) async {
    await _getToken();

    final http.Response _response = await http.post(
      '$baseUrl$url',
      body: json.encode(body),
      headers: _headers(),
    );

    try {
      _responseData = json.decode(_response.body);
    } catch (Exception) {
      print(Exception);
    }

    return _responseData;
  }

  // Multi part post data
  Future postMultiPartPayment({@required url, @required body}) async {
    await _getToken();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl$url'),
    )
      ..fields['ref_no'] = body['ref_no'].toString()
      ..fields['date'] = body['date'].toString()
      ..fields['bank'] = body['bank'].toString()
      ..fields['amount'] = body['amount'].toString()
      ..fields['status'] = body['status'].toString()
      ..fields['fileName'] = body['fileName'].toString()
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          body['file'],
        ),
      )
      ..headers.addAll(
        {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $_apiToken',
          'company-id': '$_companyId',
        },
      );
    http.StreamedResponse _response = await request.send();
    var response = await http.Response.fromStream(_response);
    debugPrint(response.body);
  }

  // Patch Data
  Future patch({@required url, @required body}) async {
    await _getToken();

    final http.Response _response = await http.patch(
      '$baseUrl$url',
      body: json.encode(body),
      headers: _headers(),
    );

    try {
      _responseData = json.decode(_response.body);
    } catch (Exception) {
      debugPrint(Exception.toString());
    }

    return _responseData;
  }
}
