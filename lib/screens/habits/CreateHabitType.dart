import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/HomePage.dart';
import 'package:proyecto/screens/habit_types/HabitTypeList.dart';
import 'package:proyecto/screens/habits/CreateHabit.dart';
import 'package:proyecto/screens/habits/HabitDetail.dart';
import 'package:proyecto/screens/habits/UpdateHabitTypeForm.dart';
import 'package:proyecto/screens/login/AuthService.dart';
import 'package:proyecto/screens/users/UserProfile.dart';

class CreateHabitTypePage extends StatefulWidget {
  @override
  _CreateHabitTypePageState createState() => _CreateHabitTypePageState();
}

class _CreateHabitTypePageState extends State<CreateHabitTypePage> {
  final TextEditingController _typeController = TextEditingController();

  Future<void> _createHabitType() async {
    final String type = _typeController.text.trim();
    if (type.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://marin.terrabyteco.com/api/habit_types/create'),
        body: {
          'type': type,
          'user_id': AuthService.userId.toString(),
        },
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
        automaticallyImplyLeading: false,
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
            Center(
              child: Text(
                'Tipo de Hábito',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _typeController,
              decoration: InputDecoration(
                hintText: 'Introduce el tipo de hábito',
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
              onPressed: _createHabitType,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Crear',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio adicional
            Expanded(
              child: HabitTypeList(), // Aquí se llama al widget HabitTypeList
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
            label: "Crear",
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
            label: "Definir",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Ajusta la separación vertical
              child: Icon(
                Icons.edit_attributes_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "Editar Tipo",
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
                MaterialPageRoute(builder: (context) => CreateHabitTypePage()),
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
                MaterialPageRoute(builder: (context) => CreateHabit()),
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
                MaterialPageRoute(builder: (context) =>  UpdateHabitTypePage()),
              ).then((_) {
                // Refresh the page when returning from CreateHabitPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              });
              break;
            case 5:
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
