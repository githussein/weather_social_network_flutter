import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

/// maps, notifications, other data
class Data with ChangeNotifier {
  String _mapUrl =
      'https://www.meteoblue.com/ar/weather/maps/widget/oman?windAnimation=1#coords=4.33/25.78/53.29&map=windAnimation~rainbow~auto~10%20m%20above%20gnd~none';

  String get mapUrl => _mapUrl; //return a copy

  Future<void> getMapUrl() async {
    var url = Uri.parse('https://admin.rain-app.com/api/sattelite-link');

    try {
      final response = await http.get(url);
      final extractedObject = json.decode(response.body);
      _mapUrl = extractedObject['satellite_link'];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
