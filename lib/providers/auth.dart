import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// The authentication provider
class Auth with ChangeNotifier {
  /// The locally stored data
  var userToken = '';
  var authHeader = {'Authorization': ''};

  Future<void> saveUserData(String token) async {
    userToken = token;
    authHeader = {'Authorization': token};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
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

      Map<String, dynamic> user = jsonDecode(response.body);
      saveUserData(user['token']);

      notifyListeners();
      return response.body;
    } catch (error) {
      print('problem signing in');
      rethrow;
    }
  }
}
