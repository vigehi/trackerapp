import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity_tracker/providers/activities_provider.dart';
import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:activity_tracker/screens/activity_screen.dart';
import 'package:activity_tracker/models/activity.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    final activities = activitiesProvider.activities;

    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: FutureBuilder<void>(
        future: activitiesProvider.fetchActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to fetch activities'));
          } else {
            final allActivities = [
              ...activities,
              ...activitiesProvider.activitiesFromApi
            ];
            return ListView.builder(
              itemCount: allActivities.length,
              itemBuilder: (context, index) {
                final activity = allActivities[index];
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
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddActivityScreen(),
        )),
        child: Icon(Icons.add),
      ),
    );
  }
}
