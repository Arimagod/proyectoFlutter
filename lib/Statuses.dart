import 'package:flutter/material.dart';

class Statuses extends StatefulWidget {
  const Statuses({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Statuses> createState() => _StatusesState();
}

class _StatusesState extends State<Statuses> {
  
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
              'Estadisticas  progreso',
            ),
          ],
        ),
      ),
    );
  }
}

