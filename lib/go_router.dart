
import 'package:activity_tracker/screens/activity_screen.dart';
import 'package:activity_tracker/screens/add_activity_screen.dart';
import 'package:activity_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: false,
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/activity/new',
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
