import 'dart:async';

import 'package:flutter/material.dart';
import '../dependencies/scope.dart';
import '../editor_screen/add_screen.dart';
import 'weekly_screen.dart';

const List<String> listOfValues = <String>[
  'Понедельник',
  'Вторник',
  'Среда',
  'Четверг',
  'Пятница',
  'Суббота',
];

typedef DailyLessonData = ({
  String lessonName,
  String startTime,
  String endTime
});

class WeeklyScheduleScreen extends StatefulWidget {
  const WeeklyScheduleScreen({super.key});

  @override
  State<WeeklyScheduleScreen> createState() => _WeeklyScheduleScreenState();
}

class _WeeklyScheduleScreenState extends State<WeeklyScheduleScreen> {
  List<List<DailyLessonData>> weeklyData = List.filled(listOfValues.length, []);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadSavedData();
    });
  }

  Future<void> loadSavedData() async {
    final db = Dependencies.dbOf(context);

    for (int i = 0; i < listOfValues.length; i++) {
      final String keyOfMaxLessons = '${dayOfWeek[i]}_maxLessons';
      final int? value = await db.get(key: keyOfMaxLessons);
      final List<DailyLessonData> data = [];

      for (int j = 0; j < value!; ++j) {
        final String lessonName = await db.get(key: '${dayOfWeek[i]}_$j') ?? '';
        final String startTime =
            await db.get(key: '${dayOfWeek[i]}_${j}_startTime') ?? '';
        final String endTime =
            await db.get(key: '${dayOfWeek[i]}_${j}_endTime') ?? '';

        data.add(
          (lessonName: lessonName, startTime: startTime, endTime: endTime),
        );
      }
      weeklyData[i] = data;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание на неделю'),
      ),
      body: ListView.builder(
        itemCount: listOfValues.length,
        itemBuilder: (ctx, dayIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  listOfValues[dayIndex],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: weeklyData[dayIndex].length,
                itemBuilder: (ctx, index) {
                  return LessonItem(
                    data: weeklyData[dayIndex][index],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class LessonItem extends StatelessWidget {
  const LessonItem({super.key, required this.data});

  final DailyLessonData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.lessonName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Начало: ${data.startTime}',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              'Окончание: ${data.endTime}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
