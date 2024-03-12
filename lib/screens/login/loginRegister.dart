import 'package:flutter/material.dart';
import 'package:proyecto/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}
class _LoginRegisterState extends State<LoginRegister> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    final String apiUrl = 'http://127.0.0.1:8000/api/users/create';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{
        'name': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Éxito'),
            content: const Text('Usuario creado exitosamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      throw Exception('Error al registrar usuario');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extiende el fondo detrás del AppBar
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20), // Ajuste del padding horizontal
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.withOpacity(0.7), Colors.blue.withOpacity(0.2)], // Fondo azul desvanecido
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 50), // Espaciado desde arriba
              Text(
                'Gestiona tu vida', // Texto agregado
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Espaciado
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 90), // Ajuste del margen superior
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 30), // Ajuste del padding del contenedor blanco
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Bordes redondeados solo en la parte superior
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Regístrate', // Texto agregado
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                           color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20), // Espaciado
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Espaciado
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Espaciado
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 40), // Espaciado
                       ElevatedButton(
                        onPressed: _registerUser,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.9),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 40), // Espaciado
                      Text(
                        '¿Quieres iniciar sesión?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10), // Espaciado
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage(title: '',)),
                          );
                        },
                        child: const Text(
                          'Iniciar sesión',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
