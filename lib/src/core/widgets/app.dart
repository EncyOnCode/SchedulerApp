import 'package:flutter/material.dart';
import '../../features/dependencies/scope.dart';

import '../data/db/db.dart';
import '../utils/router.dart';

class SandBoxApp extends StatefulWidget {
  const SandBoxApp({
    super.key,
    required this.db,
  });

  final IDatabase db;

  @override
  State<SandBoxApp> createState() => _SandBoxAppState();
}

class _SandBoxAppState extends State<SandBoxApp> {
  @override
  Widget build(BuildContext context) {
    return Dependencies(
      db: widget.db,
      child: MaterialApp(
        routes: AppRouter.routes,
      ),
    );
  }
}