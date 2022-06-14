import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

/// The weather predictions and posts provider
class Posts with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => [..._posts]; //return a copy

  Future<void> getAllPosts() async {
    var url = Uri.parse('https://admin.rain-app.com/api/outlooks');

    try {
      final response = await http.get(url);
      final List<dynamic> extractedData =
          json.decode(response.body) as List<dynamic>;
      final List<Post> loadedPosts = [];

      for (var post in extractedData) {
        var files = post['files'];

        loadedPosts.add(Post(
          id: post['id'] ?? 0,
          title: post['title'] ?? '',
          date: post['date'] ?? '',
          details: post['details'] ?? '',
          files: files,
        ));
      }

      _posts = loadedPosts;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
