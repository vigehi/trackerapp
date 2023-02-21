import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activities_provider.dart';

class ActivityScreen extends StatefulWidget {
  final String activityId;

  const ActivityScreen({super.key, required this.activityId, required  activity});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late Activity _activity;

  @override
  void initState() {
    super.initState();
    final activitiesProvider = Provider.of<ActivitiesProvider>(context, listen: false);
    _activity = activitiesProvider.getActivityById(widget.activityId);
  }

  void _editActivity() {
    // Navigate to the edit activity screen
    Navigator.pushNamed(context, '/activity/${_activity.id}/edit');
  }

  void _deleteActivity() {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context, listen: false);
    activitiesProvider.deleteActivityById(widget.activityId);

    // Navigate back to the home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _activity.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Type: ${_activity.type}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Participants: ${_activity.participants}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Price: ${_activity.price}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _activity.description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _editActivity,
            child: Icon(Icons.edit),
            tooltip: 'Edit Activity',
          ),
          SizedBox(width: 16.0),
          FloatingActionButton(
            onPressed: _deleteActivity,
            child: Icon(Icons.delete),
            tooltip: 'Delete Activity',
          ),
        ],
      ),
    );
  }
}
