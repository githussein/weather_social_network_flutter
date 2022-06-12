import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

/// The authentication provider
class Auth with ChangeNotifier {
  /// The locally stored data
  var backendUrl = '';
  var authHeader = {'authorization': ''};
  String username = '';

  Future<int> getAllPosts() async {
    var url = Uri.parse('https://admin.rain-app.com/api/outlooks');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Post> loadedPostsList = [];

      print(extractedData);

      notifyListeners();
    } catch (error) {
      rethrow;
    }

    try {
      //@TODO save data
      // saveAuthData(baseUrl, username, password);

      final response = await http.get(
        url,
        headers: authHeader,
      );

      this.username = username;
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
