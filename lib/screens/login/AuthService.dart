import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static int userId = 0;
  static String token = '';
  static String userEmail = '';
  static String userName = '';
  static String password = '';

  static Future<void> login(
      BuildContext context, String email, String password) async {
    final url = Uri.parse('https://marin.terrabyteco.com/api/auth/login');

    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Por favor, rellene todos los campos.';
      }

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final userProfile = responseData['profile'];
        userId = userProfile['id'];
        token = responseData['access_token'];
        userEmail = userProfile['email'];
        userName = userProfile['name'];

        // Guardar el token de acceso en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false, // Remove all routes from stack
        );
      } else {
        final errorMessage = responseData['response'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Recuperar el token de acceso de SharedPreferences
  static Future<void> checkToken(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');
    if (savedToken != null && savedToken.isNotEmpty) {
      // Si hay un token guardado, establecerlo como el token actual
      token = savedToken;
      // Redirigir a la página principal
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false, // Remove all routes from stack
      );
    }
  }
}
