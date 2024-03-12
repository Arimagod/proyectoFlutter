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
        // El tipo de hábito se creó correctamente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tipo de hábito creado correctamente')),
        );
        // Limpiar el campo después de crear el tipo de hábito
        _typeController.clear();
      } else {
        // Ocurrió un error al crear el tipo de hábito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el tipo de hábito')),
        );
      }
    } else {
      // No se permite crear un tipo de hábito vacío
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, introduce un tipo de hábito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Tipo de Hábito'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Tipo de Hábito'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createHabitType,
              child: Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}
