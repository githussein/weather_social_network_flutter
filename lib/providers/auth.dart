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
  Future<int> register(
      String name, String email, String password, country) async {
    try {
      final response = await http.post(
        Uri.parse('https://admin.rain-app.com/api/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'country': country
        }),
      );

      notifyListeners();
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://admin.rain-app.com/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'email': email, 'password': password}),
      );

      notifyListeners();
      return response.body;
    } catch (error) {
      rethrow;
    }
  }
}
