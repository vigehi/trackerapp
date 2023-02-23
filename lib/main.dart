import 'package:activity_tracker/screens/activity_screen.dart';
import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart' as models;
import '../providers/activities_provider.dart';
import 'go_router.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
      ],
      child: MaterialApp(
        title: 'Activity Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => HomeScreen(),
          '/add-activity': (context) => AddActivityScreen(),
        },
      ),
    );
  }
}



class HomeScreen extends StatelessWidget {
 void _addActivity(BuildContext context) async {
  final activity =
      await Navigator.of(context).pushNamed('/add-activity') as models.Activity;

  if (activity != null) {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context, listen: false);

    // Send POST request to the board API with the activity data
   // final url = 'https://example.com/api/activities';
    final url = ('https://www.boredapi.com/api/activity');
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
         'accessibility': activity.accessibility,
         'type': activity.type,
      'participants': activity.participants,
      'price': activity.price,
          // Add any other properties required by the board API
        }));

    if (response.statusCode == 201) {
      // Activity created successfully, add it to the local list of activities
      final newActivity = models.Activity.fromJson(jsonDecode(response.body));
      activitiesProvider.addActivity(newActivity as Activity);
    } else {
      // Error occurred, display message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create activity')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<ActivitiesProvider>(context).activities;

    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return ListTile(
            title: Text(activity.name),
            subtitle: Text(activity.type),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ActivityScreen(activity: activity, activityId: ''),
              ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addActivity(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
