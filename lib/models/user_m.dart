import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String name;
  final String email;
  int phone;
  final int canSendEmail;
  final String apiToken;
  final String organizationName;
  final String address1;
  final String address2;
  final String state;
  final String gstRegistered;
  final String gstin;
  final String pan;
  final List<dynamic> companies;
  final List<dynamic> logins;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.canSendEmail,
    @required this.apiToken,
    @required this.companies,
    this.organizationName,
    this.address1,
    this.address2,
    this.state,
    this.gstRegistered,
    this.gstin,
    this.pan,
    @required this.logins,
  });
}
