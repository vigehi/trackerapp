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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://www.boredapi.com/api/activity');
    final response = await http.post(url, body: {
      'accessibility': _accessibilityController.text,
      'type': _typeController.text,
      'participants': _participantsController.text,
      'price': _priceController.text,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Provider.of<ActivitiesProvider>(context, listen: false)
          .addActivity(responseData);
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
