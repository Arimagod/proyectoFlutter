import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proyecto/HomePage.dart';
import 'package:proyecto/screens/habits/HabitDetail.dart';
import 'package:proyecto/screens/habits/UpdateHabitTypeForm.dart';
import 'package:proyecto/screens/login/AuthService.dart';
import 'package:proyecto/screens/users/UserProfile.dart';

class CreateHabitPage extends StatefulWidget {
  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _habitTypeCreated = false;

  late Future<List<dynamic>> futureHabitTypes;
  late Future<List<dynamic>> futureFrequencies;
  late Future<List<dynamic>> futureStatuses;
  late Future<List<dynamic>> futureUsers;

  String? _selectedHabitType;
  String? _selectedFrequency;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    futureHabitTypes = fetchHabitTypes();
    futureFrequencies = fetchFrequencies();
    futureStatuses = fetchStatuses();
    futureUsers = fetchUsers();
  }

  Future<List<dynamic>> fetchHabitTypes() async {
    final response = await http.get(Uri.parse('https://marin.terrabyteco.com/api/habit_type/habitTypeUser/${AuthService.userId.toString()}'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load habit types');
    }
  }

  Future<List<dynamic>> fetchFrequencies() async {
    final response = await http.get(Uri.parse('https://marin.terrabyteco.com/api/frequencies'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load frequencies');
    }
  }

  Future<List<dynamic>> fetchStatuses() async {
    final response = await http.get(Uri.parse('https://marin.terrabyteco.com/api/statuses'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load statuses');
    }
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://marin.terrabyteco.com/api/users'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _createHabitType() async {
  final String type = _typeController.text.trim();
  if (type.isNotEmpty) {
    final response = await http.post(
      Uri.parse('https://marin.terrabyteco.com/api/habit_types/create'),
      body: {
        'type': type,
        'user_id': AuthService.userId.toString(), // Incluir el user_id aquí
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tipo de hábito creado correctamente')),
      );
      setState(() {
        _habitTypeCreated = true;
      });
      _typeController.clear();
      futureHabitTypes = fetchHabitTypes();
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

  Future<void> _createHabit() async {
    if (_selectedHabitType != null &&
        _selectedFrequency != null &&
        _selectedStatus != null &&
        _descriptionController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://marin.terrabyteco.com/api/habits/create'),
        body: {
          "description": _descriptionController.text,
          "user_id": AuthService.userId.toString(),
          "habit_type_id": _selectedHabitType!,
          "frequency_id": _selectedFrequency!,
          "status_id": _selectedStatus!,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hábito creado exitosamente')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el hábito')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _habitTypeCreated ? 'Definir Hábito' : 'Crear Tipo de Hábito',
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
            if (!_habitTypeCreated)
              Column(
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
            if (_habitTypeCreated)
              Column(
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
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            'Selecciona el Tipo de Hábito',
                            style: TextStyle(color: Colors.blue),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red),
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
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            'Selecciona la Frecuencia',
                            style: TextStyle(color: Colors.blue),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red),
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
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            'Selecciona el Estado',
                            style: TextStyle(color: Colors.blue),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  SizedBox(height: 16.0),
                  
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _createHabit,
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
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Ajusta la separación vertical
              child: Icon(
                Icons.home_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "Principal",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Ajusta la separación vertical
              child: Icon(
                Icons.bookmark_added_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "Historial",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Ajusta la separación vertical
              child: Icon(
                Icons.add_circle_outline,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "Crear Hábito",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Ajusta la separación vertical
              child: Icon(
                Icons.edit_document,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "Editar nombre de hábito",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Ajusta la separación vertical
              child: Icon(
                Icons.person_outline,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "Cuenta",
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 12, // Tamaño de fuente más pequeño para texto seleccionado
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12, // Tamaño de fuente más pequeño para texto no seleccionado
          color: Colors.white.withOpacity(0.7),
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HabitDetail()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateHabitPage()),
              ).then((_) {
                // Refresh the page when returning from CreateHabitPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              });
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UpdateHabitTypePage()),
              ).then((_) {
                // Refresh the page when returning from CreateHabitPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              });
              break;
            case 4:
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