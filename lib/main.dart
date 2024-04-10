import 'dart:async';

import 'package:flutter/material.dart';
import 'src/core/data/db/db.dart';
import 'src/core/widgets/app.dart';
import 'src/features/home_screen/screen.dart';
import 'src/features/editor_screen/screen.dart';

void main() => runZonedGuarded(
      initializeApp,
      (error, stack) {
        print('runZonedGuarded: Caught error: $error, \n$stack');
      },
    );

Future<void> initializeApp() async {
  runApp(
    const MaterialApp(
      home: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );

  final db = await rootInitialization();

  //runApp(SandBoxApp(db: db));
  runApp(
    MaterialApp(
      home: SandBoxApp(db: db),
    ),
  );
}

Future<IDatabase> rootInitialization() async {
  final db = IDatabase.sharedPreferences();
  await db.init();

  await Future.delayed(const Duration(seconds: 2));

  return db;
}
