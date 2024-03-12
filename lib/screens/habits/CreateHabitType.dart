import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateHabitTypeForm extends StatefulWidget {
  @override
  _CreateHabitTypeFormState createState() => _CreateHabitTypeFormState();
}

class _CreateHabitTypeFormState extends State<CreateHabitTypeForm> {
  final TextEditingController _typeController = TextEditingController();

  Future<void> _createHabitType() async {
    final String type = _typeController.text.trim();
    if (type.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/habit_types/create'),
        body: {'type': type},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tipo de hábito creado correctamente')),
        );
        _typeController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el tipo de hábito')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, introduce un tipo de hábito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear Tipo de Hábito',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tipo de Hábito',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                hintText: 'Introduce el tipo de hábito',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createHabitType,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Crear Tipo de Hábito',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
