import 'package:flutter/material.dart';
import '../../core/data/db/db.dart';

/// Аспекты, на которые можно подписаться
enum _DependenciesAspect {
  db,
}

/// Виджет, который хранит данные и предоставляет их потомкам
///
/// Позволяет подписываться на определенные аспекты с помощью самописных статик методов.
class Dependencies extends InheritedModel<_DependenciesAspect> {
  const Dependencies({
    super.key,
    required super.child,
    required this.db,
  });

  /// База данных
  final IDatabase db;

  /// Подписаться на все изменения виджета.
  ///
  /// Это возможно, потому что не указан аспект.
  static Dependencies of(BuildContext context) {
    final model = InheritedModel.inheritFrom<Dependencies>(context); // аспект тут
    return model!;
  }

  /// Получить базу данных.
  ///
  /// Подписывает на изменения только для аспекта базы данных.
  static IDatabase dbOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<Dependencies>(context, aspect: _DependenciesAspect.db);
    return model!.db;
  }

  /// Используется для определения, нужно ли уведомлять потомков об изменениях в целом виджете.
  @override
  bool updateShouldNotify(Dependencies oldWidget) {
    return db != oldWidget.db;
  }

  /// Используется для определения, нужно ли уведомлять потомков об изменениях в определенных аспектах.
  @override
  bool updateShouldNotifyDependent(
      Dependencies oldWidget,
      Set<_DependenciesAspect> dependencies,
      ) {
    bool shouldNotify = false;

    if (dependencies.contains(_DependenciesAspect.db)) {
      shouldNotify = shouldNotify || db != oldWidget.db;
    }

    return shouldNotify;
  }
}