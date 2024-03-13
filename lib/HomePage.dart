import 'package:flutter/material.dart';
import 'package:proyecto/screens/habits/CreateHabitPage.dart';
import 'package:proyecto/screens/habits/HabitList.dart';
import 'package:proyecto/screens/users/UserProfile.dart';
import 'package:proyecto/screens/habits/HabitDetail.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          'Gestión de hábitos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: HabitList(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.white,
            ),
            label: "Principal",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_added_outlined,
              size: 30,
              color: Colors.white,
            ),
            label: "Historial",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 30,
              color: Colors.white,
            ),
            label: "Crear Hábito",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
              color: Colors.white,
            ),
            label: "Cuenta",
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        onTap: (int index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HabitDetail()),
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
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              });
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
              break;
          }
        },
        elevation: 0.0,
      ),
    );
  }
}
