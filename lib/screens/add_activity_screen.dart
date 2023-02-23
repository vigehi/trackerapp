import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/activities_provider.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accessibilityController = TextEditingController();
  final _typeController = TextEditingController();
  final _participantsController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isLoading = false;
  
  var _activityType;
  
  var _participants;
  
  var _price;
  
  get _accessibility => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _accessibilityController,
                decoration: InputDecoration(labelText: 'Accessibility'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an accessibility value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _participantsController,
                decoration: InputDecoration(labelText: 'Participants'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of participants';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price value';
                  }
                  return null;
                },
              ),
              _isLoading ? CircularProgressIndicator() : SizedBox(),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: Text('Add Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _submitForm() async {
  final form = _formKey.currentState;

  if (form!.validate()) {
    form.save();
    final activity = Activity(
      accessibility: _accessibility,
      type: _activityType,
      participants: _participants,
      price: _price, description: '', id: '', name: '',
    );

    try {
      final newActivity = await createActivity(activity);
      Navigator.of(context).pop(newActivity);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create activity')),
      );
    }
  }
}

Future<Activity> createActivity(Activity activity) async {
  final url = 'https://www.boredapi.com/api/activity';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'accessibility': activity.accessibility,
      'type': activity.type,
      'participants': activity.participants,
      'price': activity.price,
    }),
  );

  if (response.statusCode == 201) {
    final responseData = json.decode(response.body);
    final newActivity = Activity.fromJson(responseData);
    return newActivity;
  } else {
    throw Exception('Failed to create activity');
  }
}


}
