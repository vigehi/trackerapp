import 'package:activity_tracker/screens/activity_screen.dart';
import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:activity_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Activity Tracker',
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: false,
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        path: '/add-activity',
        pageBuilder: (context, state) =>
            MaterialPage(child: AddActivityScreen()),
      ),
      GoRoute(
        path: '/activity/:id',
        pageBuilder: (context, state) {
          final id = state.params['id'] ?? '';
          return MaterialPage(child: ActivityScreen(activityId: id, activity: null,));
        },
      ),
    ],
  );
}
