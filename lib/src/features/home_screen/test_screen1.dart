import 'package:flutter/material.dart';

class ColorBoxPage extends StatelessWidget {
  const ColorBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (BuildContext context, int index) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          color: index.isEven ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}