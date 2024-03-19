import 'package:flutter/material.dart';
import 'package:proyecto/LoginPage.dart';
import 'package:proyecto/screens/habit_types/HabitTypeList.dart';
import 'package:proyecto/screens/habits/CreateHabitPage.dart';
import 'package:proyecto/screens/habits/CreateHabitType.dart';
import 'package:proyecto/screens/habits/UpdateHabitTypeForm.dart';
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
      body: HabitTypeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CreateHabitPage()),
              );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
            label: "Cerrar Sesión",
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
              Icons.edit_attributes,
              size: 30,
              color: Colors.white,
            ),
            label: "Editar Tipo/Hábito",
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage(title: "",)),
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
                MaterialPageRoute(builder: (context) =>  UpdateHabitTypePage()),
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
