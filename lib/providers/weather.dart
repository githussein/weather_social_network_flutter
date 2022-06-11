import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// The authentication provider
class Auth with ChangeNotifier {
  /// The locally stored data
  var backendUrl = '';
  var authHeader = {'authorization': ''};
  String username = '';

  Future<int> getCountryWeather(
      String name, String email, String password, country) async {
    var authUrl = Uri.parse('https://admin.rain-app.com/api/auth/signup');

    //Send data to the server
    try {
      final response = await http.post(
        authUrl,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'country': country,
        }),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }

    try {
      //@TODO save data
      // saveAuthData(baseUrl, username, password);

      final response = await http.get(
        authUrl,
        headers: authHeader,
      );

      this.username = username;
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
