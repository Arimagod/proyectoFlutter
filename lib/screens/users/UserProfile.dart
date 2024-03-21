import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/HomePage.dart';
import 'package:proyecto/LoginPage.dart';
import 'package:proyecto/screens/habits/CreateHabit.dart';
import 'package:proyecto/screens/habits/CreateHabitPage.dart';
import 'package:proyecto/screens/habits/CreateHabitType.dart';
import 'package:proyecto/screens/habits/HabitDetail.dart';
import 'package:proyecto/screens/habits/UpdateHabitTypeForm.dart';
import 'package:proyecto/screens/login/AuthService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _getUserData(); // Obtener datos del usuario al inicio
  }

  Future<void> _getUserData() async {
    final response = await http.get(
      Uri.parse('https://marin.terrabyteco.com/api/users/${AuthService.userId.toString()}'),
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      setState(() {
        AuthService.userName = userData['name'];
        AuthService.userEmail = userData['email'];
        _nameController.text = AuthService.userName;
        _emailController.text = AuthService.userEmail;
      });
    } else {
      // Muestra un Snackbar en caso de error al obtener los datos del usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch user data.'),
        ),
      );
    }
  }

  Future<void> _updateUser() async {
    final response = await http.post(
      Uri.parse('https://marin.terrabyteco.com/api/users/update'),
      body: {
        'id': AuthService.userId.toString(),
        'name': _nameController.text,
        'email': _emailController.text,
      },
    );

    if (response.statusCode == 200) {
      // Muestra un Snackbar para indicar que el usuario se ha actualizado correctamente
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User updated successfully.'),
        ),
      );
      // Obtener los datos actualizados después de actualizar el usuario
      _getUserData();
    } else {
      // Muestra un Snackbar en caso de error al actualizar el usuario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update user.'),
        ),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar sesión'),
          content: Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sí'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(title: '',)),
                );
                // AuthService.logout(); // Descomenta esta línea si tienes un método de cierre de sesión en AuthService.
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          'Perfil de Usuario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Nombre:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _nameController,
                enabled: _isEditing,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Correo electrónico:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _emailController,
                enabled: _isEditing,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              if (_isEditing) SizedBox(height: 20),
              if (_isEditing) SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(_isEditing ? 'Cancelar' : 'Editar'),
              ),
              if (_isEditing) SizedBox(height: 10),
              if (_isEditing)
                ElevatedButton(
                  onPressed: _updateUser,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Guardar cambios',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              if (_isEditing)
                Text(
                  'Token de acceso: ${AuthService.token}',
                  style: TextStyle(fontSize: 16),
                ),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cerrar sesión',
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
                Icons.edit_attributes_sharp,
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
                Icons.edit_document,
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
