import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// The authentication provider
class Auth with ChangeNotifier {
  /// The locally stored data
  var backendUrl = '';
  var authHeader = {'authorization': ''};
  String username = '';

  Future<int> validateTargetBackend(String targetBackendUrl) async {
    var targetUrl = Uri.parse('$targetBackendUrl/riot-api/config');

    try {
      final response = await http.get(targetUrl);

      backendUrl = targetBackendUrl;

      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  void saveAuthData(String baseUrl, String username, String password) {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    this.username = username;
    authHeader = {'authorization': basicAuth};
    backendUrl = baseUrl;
  }

  /// Signs a user in using basic authentication.
  ///
  /// Takes the [baseUrl] as the target url. Takes [username] and [password]
  /// to generate a header for basic authentication.
  Future<int> signIn(
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
