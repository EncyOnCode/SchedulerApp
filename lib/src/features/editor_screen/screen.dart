import 'package:flutter/material.dart';
import 'add_screen.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Добро пожаловать!',
            style: TextStyle(fontSize: 25),
          ),
        ),
        const Center(
          child: Text(
            'Чтобы продолжить, выберите действие',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          height: 30,
        ),
        FractionallySizedBox(
          widthFactor: 0.2,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const AddLessonsScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Создать расписание',
            ),
          ),
        ),
        Container(
          height: 30,
        ),
        FractionallySizedBox(
          widthFactor: 0.2,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Импортировать расписание',
            ),
          ),
        ),
      ],
    );
  }
}
