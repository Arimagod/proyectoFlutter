import 'package:flutter/material.dart';
import 'package:proyecto/screens/habits/HabitList.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color de fondo blanco
      appBar: AppBar(
        backgroundColor: Colors.blue, // Color de la barra de título
        title: const Text(
          'Gestion de habitos',
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del texto blanco
          ),
        ),
        centerTitle: true,
       actions: [
          IconButton(
            onPressed: () {
              // Lógica de búsqueda
            },
            icon: const Icon(Icons.search),
          ),
        ],

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
                // Logica para iniciar un nuevo hábito
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color del botón
              ),
              child: const Text(
                'Iniciar un nuevo hábito',
                style: TextStyle(color: Colors.white), // Color del texto blanco
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HabitList()),
                );
                // Logica para ver los hábitos existentes
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color del botón
              ),
              child: const Text(
                'Ver Habitos existentes',
                style: TextStyle(color: Colors.white), // Color del texto blanco
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black.withOpacity(0.03),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.blue,
            ),
            label: "Principal",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_added_outlined,
              size: 30,
              color: Colors.blue,
            ),
            label: "VEREMOS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
              color: Colors.blue,
            ),
            label: "Cuenta",
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          //fontFamily: ("ltsaeada-light"),
          color: Colors.black,
        ),
        unselectedLabelStyle:
            const TextStyle(fontSize: 14, fontFamily: "ltsaeada-light"),
        selectedItemColor:  Colors.black,
        unselectedItemColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        elevation: 0.0,
      ),
    );
  }
} 
