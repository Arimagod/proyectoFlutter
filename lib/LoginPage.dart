import 'package:flutter/material.dart';
import 'package:proyecto/screens/login/loginRegister.dart';
import 'package:proyecto/HomePage.dart';
import 'package:proyecto/screens/login/AuthService.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20), // Ajuste del padding
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.withOpacity(0.7), Colors.blue.withOpacity(0.2)], // Fondo azul desvanecido
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 40), // Espaciado
              Text(
                'Bienvenido',
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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // Label transparente
                  prefixIcon: Icon(Icons.email, color: Colors.white.withOpacity(0.7)), // Icono transparente
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // Borde transparente
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaciado
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // Label transparente
                  prefixIcon: Icon(Icons.lock, color: Colors.white.withOpacity(0.7)), // Icono transparente
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)), // Borde transparente
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 40), // Espaciado
              ElevatedButton(
                onPressed: () {
                  AuthService.login(context, _emailController.text, _passwordController.text);
                  // Lógica para el inicio de sesión
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9), // Botón blanco semi-transparente
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 1.5, // Espaciado entre letras
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaciado
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginRegister(title: '')),
                  );
                  // Lógica para ir a la página de registro
                },
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5, // Espaciado entre letras
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaciado
              Column( // Nueva Columna para el texto y los iconos
                children: <Widget>[
                  const Text(
                    '¿Necesitas ayuda? Contáctanos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2, // Espaciado entre letras
                    ),
                  ),
                  SizedBox(height: 10), // Espaciado entre el texto y los iconos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          // Lógica para manejar el tap en Instagram
                        },
                        icon: Icon(Icons.whatshot, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          // Lógica para manejar el tap en Twitter
                        },
                        icon: Icon(Icons.email, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          // Lógica para manejar el tap en Facebook
                        },
                        icon: Icon(Icons.facebook, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
