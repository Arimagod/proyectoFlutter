import 'package:flutter/material.dart';
import 'package:proyecto/LoginPage.dart';
import 'package:proyecto/HomePage.dart'; // Importa la página principal
import 'package:proyecto/screens/login/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userData = await AuthService.checkToken();

  runApp(MyApp(userData: userData));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> userData;

  const MyApp({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 54, 244, 101)),
        useMaterial3: true,
      ),
      home: userData['isLoggedIn'] == true
          ? HomePage() // Redirige al homepage si el usuario estaba autenticado previamente
          : LoginPage(title: ''),
    );
  }
}
