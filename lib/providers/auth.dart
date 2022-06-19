import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

/// The authentication provider
class Auth with ChangeNotifier {
  /// The locally stored data
  int userId = -1;
  var username = '';
  var userToken = '';
  var authHeader = {'Authorization': ''};
  late User currentUser;
  // User(id: -1, name: '', email: '', country: '', token: '', date: '');

  Future<void> saveUserData(Map<String, dynamic> user) async {
    currentUser = User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      country: user['country'],
      token: user['token'],
      date: user['date'],
    );
    // currentUser.id = user['id'] ?? -1;
    // currentUser.name = user['name'] ?? '';
    // currentUser.email = user['email'] ?? '';
    // currentUser.password = user['password'] ?? '';
    // currentUser.country = user['country'] ?? '';
    // currentUser.phone = user['phone'] ?? '';
    // currentUser.facebookToken = user['facebook_token'] ?? '';
    // currentUser.googleToken = user['google_token'] ?? '';

    print(
        'UserInfo: \n${currentUser.id}\n${currentUser.name}\n${currentUser.email}\n${currentUser.password}\n${currentUser.country}\n${currentUser.token}\n${currentUser.date}\n${currentUser.phone}\n');
    userToken = user['token'];
    username = user['name'];
    userId = user['id'];
    authHeader = {'Authorization': user['token']};

    //Save in device storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user['id']);
    await prefs.setString('name', user['name']);
    await prefs.setString('email', user['email']);
    await prefs.setString('country', user['country']);
    await prefs.setString('token', user['token']);
    await prefs.setString('date', user['date']);
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

      saveUserData(jsonDecode(response.body));

      notifyListeners();
      return response.body;
    } catch (error) {
      print('problem signing in');
      rethrow;
    }
  }
}
