import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notif.dart';

/// maps, notifications, other data
class Data with ChangeNotifier {
  int activeTab = 0;
  void setActiveTab(int tabNum) {
    activeTab = tabNum;
    notifyListeners();
  }

  String _mapUrl =
      'https://www.meteoblue.com/ar/weather/maps/widget/oman?windAnimation=1#coords=4.33/25.78/53.29&map=windAnimation~rainbow~auto~10%20m%20above%20gnd~none';
  List<Notif> _notifs = [];

  String get mapUrl => _mapUrl; //return a copy
  List<Notif> get notifs => [..._notifs]; //return a copy

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

  Future<void> getNotifications() async {
    var url = Uri.parse('https://admin.rain-app.com/api/all-notifications');

    try {
      final response = await http.get(url);
      final List<dynamic> extractedData =
          json.decode(response.body) as List<dynamic>;
      final List<Notif> loadedNotifs = [];

      if (extractedData.isNotEmpty) {
        for (var media in extractedData) {
          print('Notif: ${media['content']}');
          loadedNotifs.add(Notif(
            id: media['id'] ?? 0,
            subject: media['subject'] ?? '',
            content: media['content'] ?? '',
            date: media['date'] ?? '',
            country: media['country'] ?? '',
            appearanceFor: media['appearance_for'] ?? '',
            appearanceAs: media['appearance_as'] ?? '',
            redirect: media['redirect'] ?? '',
            schedule: media['schedule'] ?? '',
            media: media['media'] ?? '',
          ));
        }
      }

      _notifs = loadedNotifs;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
