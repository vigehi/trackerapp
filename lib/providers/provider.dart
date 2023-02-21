import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityProvider with ChangeNotifier {
  List<Map<String, dynamic>> _activities = [];

  List<Map<String, dynamic>> get activities => _activities;

  Future<void> fetchActivities() async {
    final response = await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _activities.add(data);
      notifyListeners();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void addActivity(Map<String, dynamic> activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void editActivity(int index, Map<String, dynamic> activity) {
    _activities[index] = activity;
    notifyListeners();
  }

  void deleteActivity(int index) {
    _activities.removeAt(index);
    notifyListeners();
  }
}
