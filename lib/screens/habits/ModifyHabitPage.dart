import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/models/Habit.dart';

class ModifyHabitPage extends StatefulWidget {
  final Habit habit;

  const ModifyHabitPage({Key? key, required this.habit}) : super(key: key);

  @override
  _ModifyHabitPageState createState() => _ModifyHabitPageState();
}

class _ModifyHabitPageState extends State<ModifyHabitPage> {
  late String newDescription;

  @override
  void initState() {
    super.initState();
    newDescription = widget.habit.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Hábito'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descripción:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: widget.habit.description,
              onChanged: (value) {
                setState(() {
                  newDescription = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para enviar una solicitud HTTP
                // a la API para modificar el hábito con los nuevos datos
                // newDescription contiene la nueva descripción del hábito
                // widget.habit contiene el hábito original
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
