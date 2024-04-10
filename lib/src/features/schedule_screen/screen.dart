import 'dart:async';

import 'package:flutter/material.dart';
import '../dependencies/scope.dart';
import '../editor_screen/add_screen.dart';

const List<String> listOfValues = <String>[
  'Понедельник',
  'Вторник',
  'Среда',
  'Четверг',
  'Пятница',
  'Суббота',
];

typedef LessonData = ({String lessonName, String startTime, String endTime});

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String dropdownValue = listOfValues.first;
  List<LessonData> data = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadSavedData(index: 0);
    });
  }

  Future<void> loadSavedData({required int index}) async {
    data = [];
    final db = Dependencies.dbOf(context);
    final String keyOfMaxLessons = '${dayOfWeek[index]}_maxLessons';
    final int? value = await db.get(key: keyOfMaxLessons);
    for (var i = 0; i < value!; ++i) {
      //Читаю данные по каждому уроку
      final String lessonName =
          await db.get(key: '${dayOfWeek[index]}_$i') ?? '';
      final String startTime =
          await db.get(key: '${dayOfWeek[index]}_${i}_startTime') ?? '';
      final String endTime =
          await db.get(key: '${dayOfWeek[index]}_${i}_endTime') ?? '';

      data.add(
          (lessonName: lessonName, startTime: startTime, endTime: endTime));
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                  final index = listOfValues.indexOf(value);
                  loadSavedData(index: index);
                });
              },
              items: listOfValues.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              dropdownColor: Colors.cyan,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx, index) {
          return LessonItem(
            data: data[index],
          );
        },
      ),
    );
  }
}

class LessonItem extends StatelessWidget {
  const LessonItem({super.key, required this.data});

  final LessonData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(data.lessonName),
        const SizedBox(width: 5,),
        Text(data.startTime),
        const SizedBox(width: 5,),
        Text(data.endTime),
      ],
    );
  }
}
