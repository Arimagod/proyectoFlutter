import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateHabitTypePage extends StatefulWidget {
  @override
  _UpdateHabitTypePageState createState() => _UpdateHabitTypePageState();
}

class _UpdateHabitTypePageState extends State<UpdateHabitTypePage> {
  final TextEditingController _newTypeController = TextEditingController();
  String? _selectedHabitType;
  late List<dynamic> _habitTypes = [];

  @override
  void initState() {
    super.initState();
    _fetchHabitTypes();
  }

  Future<void> _fetchHabitTypes() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/habit_types'));
    if (response.statusCode == 200) {
      setState(() {
        _habitTypes = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los tipos de hábito')),
      );
    }
  }

  Future<void> _updateHabitType() async {
    final String newType = _newTypeController.text.trim();
    if (_selectedHabitType != null && newType.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/habit_types/update'),
        body: {
          'id': _selectedHabitType!,
          'type': newType,
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tipo de hábito actualizado correctamente')),
        );
        _newTypeController.clear();
        _selectedHabitType = null;
        _fetchHabitTypes();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el tipo de hábito')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona un tipo de hábito y proporciona un nuevo valor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Tipo de Hábito'),
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
            DropdownButtonFormField<String>(
              value: _selectedHabitType,
              onChanged: (String? value) {
                setState(() {
                  _selectedHabitType = value!;
                });
              },
              items: _habitTypes.map<DropdownMenuItem<String>>((dynamic habitType) {
                return DropdownMenuItem<String>(
                  value: habitType['id'].toString(),
                  child: Text(habitType['type']),
                );
              }).toList(),
              hint: Text('Selecciona el Tipo de Hábito'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _newTypeController,
              decoration: InputDecoration(
                labelText: 'Nuevo Nombre del Tipo de Hábito',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateHabitType,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Actualizar Tipo de Hábito',
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
