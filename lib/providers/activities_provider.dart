import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Activity {
  final String id;
  final String name;
  final String type;
  final int participants;
  final double price;
  final double accessibility;

   final String description;

  Activity({
    required this.id,
    required this.name,
    required this.type,
    required this.participants,
    required this.price,
    required this.accessibility,
    required this.description,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['key'],
      name: json['activity'],
      type: json['type'],
      participants: json['participants'],
      price: json['price'].toDouble(),
      accessibility: json['accessibility'].toDouble(),
      description: json['description'],
    );
  }
}

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  Future<void> fetchActivities() async {
    final response = await http.get(Uri.parse('https://www.boredapi.com/api/activity'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Activity activity = Activity.fromJson(data);
      _activities.add(activity);
      notifyListeners();
    } else {
      throw Exception('Failed to load activity');
    }
  }

  Future<void> addActivity(Activity activity) async {
    _activities.add(activity);
    notifyListeners();
  }

  Future<void> deleteActivity(Activity activity) async {
    _activities.remove(activity);
    notifyListeners();
  }

  Future<void> updateActivity(Activity activity) async {
    final index = _activities.indexWhere((a) => a.id == activity.id);
    if (index != -1) {
      _activities[index] = activity;
      notifyListeners();
    }
  }

  getActivityById(String activityId) {}

  void deleteActivityById(String activityId) {}
}
