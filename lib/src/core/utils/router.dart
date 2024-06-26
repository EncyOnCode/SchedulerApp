import 'package:flutter/material.dart';

import '../../features/editor_screen/add_screen.dart';
import '../../features/editor_screen/screen.dart';
import '../../features/lessons/screen.dart';
import '../../features/home_screen/screen.dart';
import '../../features/schedule_screen/screen.dart';
import '../../features/schedule_screen/weekly_screen.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const LessonScreen(),
    '/homeScreen': (context) => const PlaceholderScreen(),
    '/editorScreen': (context) => const EditorScreen(),
    '/addLessonScreen': (context) => const AddLessonsScreen(),
    '/scheduleScreen': (context) => const ScheduleScreen(),
    '/weeklyScreen': (context) => const WeeklyScheduleScreen()
  };
}