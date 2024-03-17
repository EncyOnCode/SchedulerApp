import 'package:control/control.dart';
import '../../core/data/db/db.dart';

import '../../core/data/models/lesson.dart';

sealed class LessonState {
  const LessonState();
}

class LessonLoading extends LessonState {
  const LessonLoading();
}

class LessonLoaded extends LessonState {
  const LessonLoaded(this.lessons);

  final List<Lesson> lessons;
}

class LessonError extends LessonState {
  const LessonError(this.error);

  final Object error;
}

base class LessonsStateController extends StateController<LessonState> with SequentialControllerHandler {
  LessonsStateController({
    required IDatabase db,
  })  : _db = db,
        super(initialState: const LessonLoading());

  final IDatabase _db;

  void clear() => handle(
        () {
      throw UnimplementedError();
    },
        (error, stackTrace) => setState(LessonError(error)),
  );

  void loadLessons() => handle(
        () async {
      setState(const LessonLoading());

      await Future.delayed(const Duration(seconds: 2));

      setState(const LessonLoaded(<Lesson>[
        Lesson(
          name: 'Lesson 1',
          endTime: Duration(hours: 8, minutes: 30),
          startTime: Duration(hours: 7, minutes: 30),
        ),
        Lesson(
          name: 'Lesson 2',
          endTime: Duration(hours: 9, minutes: 30),
          startTime: Duration(hours: 8, minutes: 30),
        ),
      ]));
    },
        (error, stackTrace) {
      setState(LessonError(error));
    },
  );
}