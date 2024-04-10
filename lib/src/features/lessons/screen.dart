import 'package:flutter/material.dart';
import '../dependencies/scope.dart';
import '../editor_screen/screen.dart';
import '../home_screen/screen.dart';
import 'inh_model.dart';
import 'scope.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              LessonsDependencies.stateOf(context).runtimeType.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                LessonsDependencies.controllerOf(context).refreshLessons();
              },
              child: const Text('Refresh'),
            ),

            ElevatedButton(
              onPressed: () {
                LessonsDependencies.controllerOf(context).addLesson(
                  const Lesson(
                    name: 'Lesson',
                    startTime: Duration.zero,
                    endTime: Duration.zero,
                  ),
                );
              },
              child: const Text('Add'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlaceholderScreen(),
                  ),
                );
              },
              child: const Text('Go to placeholder'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditorScreen(),
                  ),
                );
              },
              child: const Text('Go to editor screen'),
            )
          ],
        ),
      ),
    );
  }
}
