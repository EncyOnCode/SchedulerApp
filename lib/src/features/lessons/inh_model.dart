import 'package:flutter/material.dart';
import 'scope.dart';
import 'state_controller.dart';

/// Аспекты, на которые можно подписаться
enum _DependenciesAspect {
  state,

  controller
}

/// Виджет, который хранит данные и предоставляет их потомкам
///
/// Позволяет подписываться на определенные аспекты с помощью самописных статик методов.
class LessonsDependencies extends InheritedModel<_DependenciesAspect> {
  const LessonsDependencies({
    super.key,
    required super.child,
    required this.controller,
    required this.state,
  });

  final LessonController controller;

  final LessonState state;

  /// Подписаться на все изменения виджета.
  ///
  /// Это возможно, потому что не указан аспект.
  static LessonsDependencies of(BuildContext context) {
    final model = InheritedModel.inheritFrom<LessonsDependencies>(context); // аспект тут
    return model!;
  }

  /// Получить базу данных.
  ///
  /// Подписывает на изменения только для аспекта базы данных.
  static LessonController controllerOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<LessonsDependencies>(context, aspect: _DependenciesAspect.controller);
    return model!.controller;
  }

  static LessonState stateOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<LessonsDependencies>(context, aspect: _DependenciesAspect.state);
    return model!.state;
  }

  /// Используется для определения, нужно ли уведомлять потомков об изменениях в целом виджете.
  @override
  bool updateShouldNotify(LessonsDependencies oldWidget) {
    return controller != oldWidget.controller || state != oldWidget.state;
  }

  /// Используется для определения, нужно ли уведомлять потомков об изменениях в определенных аспектах.
  @override
  bool updateShouldNotifyDependent(
      LessonsDependencies oldWidget,
      Set<_DependenciesAspect> dependencies,
      ) {
    bool shouldNotify = false;

    if (dependencies.contains(_DependenciesAspect.controller)) {
      shouldNotify = shouldNotify || controller != oldWidget.controller;
    }

    if (dependencies.contains(_DependenciesAspect.state)) {
      shouldNotify = shouldNotify || state != oldWidget.state;
    }

    return shouldNotify;
  }
}