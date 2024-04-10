import 'package:flutter/material.dart';
import '../../core/widgets/app.dart';
import 'test_screen1.dart';
import '../editor_screen/screen.dart';
import '../schedule_screen/screen.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const <Widget>[
    ColorBoxPage(
      key: PageStorageKey<String>('firstPage'),
    ),
    ColorBoxPage(
      key: PageStorageKey<String>('secondPage'),
    ),
    ScheduleScreen(),
    ColorBoxPage(
      key: PageStorageKey<String>('fourthPage'),
    ),
    EditorScreen(),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: screens[currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            label: 'События',
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm),
            label: 'Уведомления',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            label: 'Расписание',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            label: 'Карта',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: 'Другое',
          ),
        ],
      ),
    );
  }
}
