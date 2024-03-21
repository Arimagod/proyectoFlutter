import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/HomePage.dart';
import 'package:proyecto/models/Habit.dart';
import 'package:proyecto/screens/habits/CreateHabit.dart';
import 'package:proyecto/screens/habits/CreateHabitPage.dart';
import 'package:proyecto/screens/habits/CreateHabitType.dart';
import 'dart:convert';

import 'package:proyecto/screens/habits/HabitDetail.dart';
import 'package:proyecto/screens/habits/UpdateHabitTypeForm.dart';
import 'package:proyecto/screens/users/UserProfile.dart';




class HabitItem extends StatefulWidget {
  const HabitItem({super.key,required this.id});
  final int id;
  @override
  State<HabitItem> createState() => _HabitItemState();
}


class _HabitItemState extends State<HabitItem> {
  late Future<Habit> futureHabit;

  @override
  void initState() {
    super.initState();
    futureHabit = fetchUser();
  }
  Future<Habit> fetchUser() async {
  final response = await http.get(
      Uri.parse('https://marin.terrabyteco.com/api/habits/${widget.id}'),
    );


  if (response.statusCode == 200) {
    return Habit.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fallo en cargar los datos');
  }
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white, // Color de fondo blanco
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue, // Color de la barra de título
            title: const Text(
              'Habitos',
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color del texto blanco
              ),
            ),
            centerTitle: true,
      ),
        body: Center(
          child: FutureBuilder<Habit>(
            future: futureHabit,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   // Text(snapshot.data!.name),
                    Text(snapshot.data!.description),

                   // Text(snapshot.data!.id.toString()),


                  ],
                );
                
              }else if (snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          )
          
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