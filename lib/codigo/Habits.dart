import 'package:flutter/material.dart';

class Habits extends StatefulWidget {
  const Habits({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Habitos',
            ),
          ],
        ),
      ),
    );
  }
}

