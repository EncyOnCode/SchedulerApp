import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'inh_model.dart';
import 'state_controller.dart';

import '../../core/data/models/lesson.dart';

abstract interface class LessonController {
  void refreshLessons();

  void addLesson(Lesson lesson);
}

class LessonScope extends StatefulWidget {
  const LessonScope({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;

  final LessonsStateController controller;


  @override
  State<LessonScope> createState() => _LessonScopeState();
}

class _LessonScopeState extends State<LessonScope> implements LessonController {
  @override
  void addLesson(Lesson lesson) {
    widget.controller.clear();
  }

  @override
  void refreshLessons() {
    widget.controller.loadLessons();
  }

  @override
  Widget build(BuildContext context) {
    return StateConsumer<LessonsStateController, LessonState>(
      controller: widget.controller,
      builder: (context, state, child) {
        return LessonsDependencies(
          controller: this,
          state: state,
          child: widget.child,
        );
      },
    );
  }
}