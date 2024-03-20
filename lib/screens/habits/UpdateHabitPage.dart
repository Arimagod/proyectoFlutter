import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/HomePage.dart';
import 'package:proyecto/models/Habit.dart';
import 'package:proyecto/screens/habits/HabitDetail.dart';
import 'package:proyecto/screens/login/AuthService.dart';
import 'package:proyecto/screens/users/UserProfile.dart';

class UpdateHabitPage extends StatefulWidget {
  final Habit habit;

  const UpdateHabitPage({Key? key, required this.habit}) : super(key: key);

  @override
  _UpdateHabitPageState createState() => _UpdateHabitPageState();
}

class _UpdateHabitPageState extends State<UpdateHabitPage> {
  late String _newStatusId;
  late String _newFrequencyId;
  TextEditingController _newDescriptionController = TextEditingController();
  List<dynamic>? _statusOptions;
  List<dynamic>? _frequencyOptions;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _newStatusId = widget.habit.status.id.toString();
    _newFrequencyId = widget.habit.frequency.id.toString();
    _getStatusOptions();
    _getFrequencyOptions();
    _newDescriptionController.text = widget.habit.description;
  }

  Future<void> _getStatusOptions() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/statuses'));
    if (response.statusCode == 200) {
      setState(() {
        _statusOptions = jsonDecode(response.body);
      });
    }
  }

  Future<void> _getFrequencyOptions() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/frequencies'));
    if (response.statusCode == 200) {
      setState(() {
        _frequencyOptions = jsonDecode(response.body);
      });
    }
  }

  Future<void> updateHabit() async {
    if (_formKey.currentState!.validate()) {
      String userId = AuthService.userId.toString();
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/habits/update'),
        body: {
          "id": widget.habit.id.toString(),
          "description": _newDescriptionController.text,
          "user_id": userId,
          "habit_type_id": widget.habit.habitType.id.toString(),
          "frequency_id": _newFrequencyId.toString(),
          "status_id": _newStatusId.toString(),
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hábito actualizado exitosamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el hábito')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          'Actualizar Hábito',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nombre del Hábito: ${widget.habit.habitType.type}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Estado actual: ${widget.habit.status.status}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Frecuencia actual: ${widget.habit.frequency.frequency}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _newDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Nueva descripción',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa una descripción';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    value: _newStatusId,
                    onChanged: (String? newValue) {
                      setState(() {
                        _newStatusId = newValue!;
                      });
                    },
                    items: _statusOptions?.map<DropdownMenuItem<String>>((dynamic status) {
                          return DropdownMenuItem<String>(
                            value: status['id'].toString(),
                            child: Text(status['status']),
                          );
                        }).toList() ??
                        [],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor selecciona un estado';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    value: _newFrequencyId,
                    onChanged: (String? newValue) {
                      setState(() {
                        _newFrequencyId = newValue!;
                      });
                    },
                    items: _frequencyOptions?.map<DropdownMenuItem<String>>((dynamic frequency) {
                          return DropdownMenuItem<String>(
                            value: frequency['id'].toString(),
                            child: Text(frequency['frequency']),
                          );
                        }).toList() ??
                        [],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor selecciona una frecuencia';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: updateHabit,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.withOpacity(0.6),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Actualizar Hábito',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.white,
            ),
            label: "Principal",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_added_outlined,
              size: 30,
              color: Colors.white,
            ),
            label: "Historial",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
              color: Colors.white,
            ),
            label: "Cuenta",
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HabitDetail()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
        elevation: 0.0,
      ),
    );
  }
}
