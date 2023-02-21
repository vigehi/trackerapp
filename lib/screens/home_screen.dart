import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import 'activity_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activity>>(context);

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
                builder: (context) => ActivityScreen(activity: activity, activityId: '',),
              ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-activity');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
