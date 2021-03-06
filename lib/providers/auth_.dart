import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Auth_data with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  // ignore: unused_field
  String _userId;
  Auth_data();
  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    // https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=[key]';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      //Shared preferences should be used to share the token to the whole accepters 
      //shared prederences should be used inside a setstate so that the app state refresh and token 
      //can be accepted by others widgets; 
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (e) {
      throw e;
    }

    //print(json.decode(response.body));
    //print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }
}
