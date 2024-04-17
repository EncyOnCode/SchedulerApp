import 'package:flutter/material.dart';
import '../dependencies/scope.dart';
import '../editor_screen/screen.dart';
import '../home_screen/screen.dart';
import 'inh_model.dart';
import 'scope.dart';
import '../editor_screen/screen.dart';

import '../../core/data/models/lesson.dart';
import 'state_controller.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonScope(
      controller: LessonsStateController(
        db: Dependencies.dbOf(context),
      ),
      child: const _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EditorScreen(),
    );
  }
}
