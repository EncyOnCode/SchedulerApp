import 'package:flutter/material.dart';

import '../../features/lessons/screen.dart';
import '../../features/home_screen/screen.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const LessonScreen(),
    '/newScreen': (context) => const PlaceholderScreen(),
  };
}