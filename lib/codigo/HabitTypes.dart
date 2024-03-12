import 'package:flutter/material.dart';

class HabitTypes extends StatefulWidget {
  const HabitTypes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HabitTypes> createState() => _HabitTypesState();
}

class _HabitTypesState extends State<HabitTypes> {
  

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
              'Tipos de habitos',
            ),
            
            
            
          ],
        ),
      ),
    );
  }
}

