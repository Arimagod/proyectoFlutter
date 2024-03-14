import 'package:flutter/material.dart';
// import 'package:proyecto/MyHomePage.dart';
import 'package:proyecto/LoginPage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 54, 244, 101)),
        useMaterial3: true,
      ),
      home: const LoginPage(title:  "",),
    );
  }
}


