import 'package:activity_tracker/providers/activities_provider.dart';
import 'package:activity_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'go_router.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultRouteParser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
      ],
      child: MaterialApp.router(
        title: 'Activity Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
      ),
    );
  }
}
