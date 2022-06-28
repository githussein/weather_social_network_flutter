import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/media.dart';

/// The weather predictions and posts provider
class Posts with ChangeNotifier {
  List<Post> _posts = [];
  List<Media> _media = [];

  List<Post> get posts => [..._posts]; //return a copy
  List<Media> get media => [..._media]; //return a copy

  Future<void> getAllPosts() async {
    var url = Uri.parse('https://admin.rain-app.com/api/outlooks');

    try {
      final response = await http.get(url);
      final List<dynamic> extractedData =
          json.decode(response.body) as List<dynamic>;
      final List<Post> loadedPosts = [];

      for (var post in extractedData) {
        var files = post['files'];
        var comments = post['comments'];

        loadedPosts.add(Post(
          id: post['id'] ?? 0,
          title: post['title'] ?? '',
          date: post['date'] ?? '',
          details: post['details'] ?? '',
          files: files,
          comments: comments,
        ));
      }

      _posts = loadedPosts;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getAllMedia() async {
    var url = Uri.parse('https://admin.rain-app.com/api/weatherShots');

    try {
      final response = await http.get(url);
      final List<dynamic> extractedData =
          json.decode(response.body) as List<dynamic>;
      final List<Media> loadedMedia = [];

      for (var media in extractedData) {
        loadedMedia.add(Media(
          id: media['id'] ?? 0,
          photographer: media['photographer'] ?? '',
          location: media['location'] ?? '',
          date: media['date'] ?? '',
          schedule: media['schedule'] ?? '',
          hide: media['hide'] ?? '',
          shares: media['shares'] ?? 0,
          media: media['media'] ?? '',
        ));
      }

      _media = loadedMedia;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
