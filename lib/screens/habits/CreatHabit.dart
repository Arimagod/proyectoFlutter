import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateHabit extends StatefulWidget {
  @override
  _CreateHabitState createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  late Future<List<dynamic>> futureHabitTypes;
  late Future<List<dynamic>> futureFrequencies;
  late Future<List<dynamic>> futureStatuses;
  late Future<List<dynamic>> futureUsers;

  String? _selectedHabitType;
  String? _selectedFrequency;
  String? _selectedStatus;
  String? _selectedUser;

  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureHabitTypes = fetchHabitTypes();
    futureFrequencies = fetchFrequencies();
    futureStatuses = fetchStatuses();
    futureUsers = fetchUsers();
  }

  Future<List<dynamic>> fetchHabitTypes() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/habit_types'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load habit types');
    }
  }

  Future<List<dynamic>> fetchFrequencies() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/frequencies'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load frequencies');
    }
  }

  Future<List<dynamic>> fetchStatuses() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/statuses'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load statuses');
    }
  }

  Future<List<dynamic>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/users'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createHabit() async {
    if (_selectedHabitType != null &&
        _selectedFrequency != null &&
        _selectedStatus != null &&
        _selectedUser != null &&
        _descriptionController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/habits/create'),
        body: {
          "description": _descriptionController.text,
          "user_id": _selectedUser!,
          "habit_type_id": _selectedHabitType!,
          "frequency_id": _selectedFrequency!,
          "status_id": _selectedStatus!,
        },
      );

      if (response.statusCode == 200) {
        // Hábito creado exitosamente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hábito creado exitosamente')),
        );
      } else {
        // Error al crear el hábito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el hábito')),
        );
      }
    } else {
      // Mostrar un mensaje si no se seleccionan todos los campos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Definir Hábito',
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
            FutureBuilder<List<dynamic>>(
              future: futureHabitTypes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<String>(
                    value: _selectedHabitType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedHabitType = value!;
                      });
                    },
                    items: snapshot.data!.map<DropdownMenuItem<String>>((dynamic habitType) {
                      return DropdownMenuItem<String>(
                        value: habitType['id'].toString(),
                        child: Text(
                          habitType['type'],
                          style: TextStyle(color: Colors.blue), // Cambia el color del texto
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Selecciona el Tipo de Hábito',
                      style: TextStyle(color: Colors.blue), // Cambia el color del texto de sugerencia
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red), // Cambia el color del texto de error
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 16.0),
            FutureBuilder<List<dynamic>>(
              future: futureFrequencies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<String>(
                    value: _selectedFrequency,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedFrequency = value!;
                      });
                    },
                    items: snapshot.data!.map<DropdownMenuItem<String>>((dynamic frequency) {
                      return DropdownMenuItem<String>(
                        value: frequency['id'].toString(),
                        child: Text(
                          frequency['frequency'],
                          style: TextStyle(color: Colors.blue), // Cambia el color del texto
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Selecciona la Frecuencia',
                      style: TextStyle(color: Colors.blue), // Cambia el color del texto de sugerencia
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red), // Cambia el color del texto de error
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 16.0),
            FutureBuilder<List<dynamic>>(
              future: futureStatuses,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                    items: snapshot.data!.map<DropdownMenuItem<String>>((dynamic status) {
                      return DropdownMenuItem<String>(
                        value: status['id'].toString(),
                        child: Text(
                          status['status'],
                          style: TextStyle(color: Colors.blue), // Cambia el color del texto
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Selecciona el Estado',
                      style: TextStyle(color: Colors.blue), // Cambia el color del texto de sugerencia
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red), // Cambia el color del texto de error
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 16.0),
            FutureBuilder<List<dynamic>>(
              future: futureUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<String>(
                    value: _selectedUser,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedUser = value!;
                      });
                    },
                    items: snapshot.data!.map<DropdownMenuItem<String>>((dynamic user) {
                      return DropdownMenuItem<String>(
                        value: user['id'].toString(),
                        child: Text(
                          user['name'],
                          style: TextStyle(color: Colors.blue), // Cambia el color del texto
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Selecciona el Usuario',
                      style: TextStyle(color: Colors.blue), // Cambia el color del texto de sugerencia
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red), // Cambia el color del texto de error
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                fillColor: Colors.white,
                filled: true,
                labelStyle: TextStyle(color: Colors.blue), // Cambia el color del texto de la etiqueta
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), // Cambia el color del borde
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), // Cambia el color del borde al enfocar
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createHabit,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Crear Hábito',
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
    );
  }
}
