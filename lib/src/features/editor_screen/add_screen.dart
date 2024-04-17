import 'dart:async';

import 'package:flutter/material.dart';
import '../dependencies/scope.dart';

OutlineInputBorder borderStyled = const OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
);

List<String> dayOfWeek = [
  'Понедельник',
  'Вторник',
  'Среда',
  'Четверг',
  'Пятница',
  'Суббота',
];

typedef ControllerContainer = ({
  TextEditingController lessonNameController,
  TextEditingController startTimeController,
  TextEditingController endTimeController
});

class AddLessonsScreen extends StatefulWidget {
  const AddLessonsScreen({super.key});

  @override
  State<AddLessonsScreen> createState() => _AddLessonsScreenState();
}

class _AddLessonsScreenState extends State<AddLessonsScreen> {
  int currentDay = 0;
  late List<ControllerContainer> controllerList = List.generate(
    maxWidgets,
    (index) => (
      lessonNameController: TextEditingController(),
      startTimeController: TextEditingController(),
      endTimeController: TextEditingController()
    ),
  );

  int maxWidgets = 1;

  Timer? debouncer;

  void addElement() {
    maxWidgets++;
    controllerList.add(
      (
        lessonNameController: TextEditingController(),
        startTimeController: TextEditingController(),
        endTimeController: TextEditingController()
      ),
    );
    listenData();
  }

  void deleteElement() {
    maxWidgets--;
    controllerList.removeLast();
    listenData();
  }

  void saveAllText() {
    final db = Dependencies.dbOf(context);
    for (var i = 0; i < maxWidgets; ++i) {
      if (maxWidgets == 1) {
        if (controllerList[i].lessonNameController.text == '' &&
            controllerList[i].startTimeController.text == '' &&
            controllerList[i].endTimeController.text == '') {
          db.save(key: '${dayOfWeek[currentDay]}_$i', value: 'Выходной');
        }
      } else {
        db
          ..save(
            key: '${dayOfWeek[currentDay]}_$i',
            value: controllerList[i].lessonNameController.text,
          )
          ..save(
            key: '${dayOfWeek[currentDay]}_${i}_startTime',
            value: controllerList[i].startTimeController.text,
          )
          ..save(
            key: '${dayOfWeek[currentDay]}_${i}_endTime',
            value: controllerList[i].endTimeController.text,
          )
          ..save(
            key: '${dayOfWeek[currentDay]}_maxLessons',
            value: maxWidgets,
          );
      }
    }
  }

  void listenData() {
    for (final element in controllerList) {
      element.lessonNameController.addListener(debounceSaveText);
      element.startTimeController.addListener(debounceSaveText);
      element.endTimeController.addListener(debounceSaveText);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listenData();
    });
  }

  @override
  void dispose() {
    for (final element in controllerList) {
      element.lessonNameController.removeListener(debounceSaveText);
      element.startTimeController.removeListener(debounceSaveText);
      element.endTimeController.removeListener(debounceSaveText);
    }
    super.dispose();
  }

  void debounceSaveText() {
    debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 500), (saveAllText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Редактируем: ${dayOfWeek[currentDay]}'),
      ),
      body: ListView.builder(
        itemCount: maxWidgets,
        padding: const EdgeInsets.only(top: 26, bottom: 26),
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: AddLessonFields(
              lessonNameController: controllerList[index].lessonNameController,
              startTimeController: controllerList[index].startTimeController,
              endTimeController: controllerList[index].endTimeController,
            ),
          );
        },
      ),
      bottomNavigationBar: FractionallySizedBox(
        heightFactor: 0.2,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(addElement);
                },
                child: const Text('Добавить'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (maxWidgets == 1) {
                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Ошибка удаления'),
                        content: const Text(
                          'Удаление единственного элемента с экрана '
                          'невозможно, если вы хотите сделать выходной день, '
                          'просто оставьте поля ввода пустыми.',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Понял'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    setState(deleteElement);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0000),
                ),
                child: const Text('Удалить'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF008000),
                ),
                onPressed: () {
                  setState(() {
                    saveAllText();
                    if (currentDay == 5) {
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Последний день недели'),
                          content: const Text(
                              'Это последний день недели, после его редактирования '
                              'приложение будет пиздить ваши данные'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Понял'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      maxWidgets = 1;
                      currentDay += 1;
                    }
                  });
                },
                child: const Text('Закончил'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddLessonFields extends StatelessWidget {
  const AddLessonFields({
    super.key,
    required this.lessonNameController,
    required this.startTimeController,
    required this.endTimeController,
  });

  final TextEditingController lessonNameController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Column(
        children: [
          TextField(
            controller: lessonNameController,
            decoration: InputDecoration(
              hintText: 'Математика',
              label: const Text('Название занятия'),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: borderStyled,
              focusedBorder: borderStyled,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: startTimeController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Начало..',
                      label: const Text('Начало занятия'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: borderStyled,
                      focusedBorder: borderStyled,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '—',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: endTimeController,
                    decoration: InputDecoration(
                      hintText: 'Конец...',
                      label: const Text('Конец занятия'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: borderStyled,
                      focusedBorder: borderStyled,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
