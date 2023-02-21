import 'package:activity_tracker/providers/activities_provider.dart';
import 'package:activity_tracker/screens/activity_screen.dart';
import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:activity_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

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
        home: HomeScreen(),
        onGenerateRoute: GoRouter(
          debugLogDiagnostics: false,
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => HomeScreen(),
            ),
            GoRoute(
              path: '/activity/new',
              pageBuilder: (context, state) => const AddActivityScreen(),
            ),
            GoRoute(
              path: '/activity/:id',
              pageBuilder: (context, state) {
                final id = state.params['id'];
                return ActivityScreen(activityId: id, activity: id,);
              },
            ),
          ],
        ).onGenerateRoute,
      ),
    );
  }
}
