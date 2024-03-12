import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/LoginPage.dart';
import 'package:proyecto/screens/habits/CreatHabit.dart';
import 'package:proyecto/screens/habits/CreateHabitType.dart';
import 'dart:convert';
import 'package:proyecto/screens/habits/HabitDetail.dart';
import 'package:proyecto/screens/habits/HabitItem.dart';
import 'package:proyecto/screens/habits/HabitList.dart';
import 'package:proyecto/screens/users/UserProfile.dart';

    class HomePage extends StatefulWidget {
      const HomePage({Key? key}) : super(key: key);

      @override
      _HomePageState createState() => _HomePageState();
    }

    class _HomePageState extends State<HomePage> {
      final TextEditingController _searchController = TextEditingController();
      List<dynamic> _habitTypes = [];

      Future<void> searchHabitTypes(String letter) async {
        if (letter.isEmpty) {
          setState(() {
            _habitTypes.clear();
          });
          return;
        }
        var url = Uri.parse('http://127.0.0.1:8000/api/search/$letter');
        var response = await http.get(url);
        if (response.statusCode == 200) {
          setState(() {
            _habitTypes = json.decode(response.body);
          });
        } else {
          throw Exception('Failed to load habit types');
        }
      }

      Future<void> goToHabitItem(int habitId) async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HabitItem(id: habitId)),
        );
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.7),
        title: const Text(
          'Gestión de hábitos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6),
                ),
                child: const Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Crear hábito'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateHabitTypeForm()),
                    );
                  
                  },
               ),
               ListTile(
                title: const Text('Definir hábito'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateHabit()),
                    );
                  },
               ),
              ListTile(
                title: const Text('Ver hábitos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HabitList()),
                  );
                },
              ),
              ListTile(
                title: const Text('Detalles de hábitos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HabitDetail()),
                  );
                },
              ),
              ListTile(
                title: const Text('Cerrar Sesion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage(title: '')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        searchHabitTypes(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Buscar',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _habitTypes.isEmpty
                  ? Container() // Si la lista está vacía, no mostrar nada
                  : ListView.builder(
                itemCount: _habitTypes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _habitTypes[index]['type'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: null, // Esto elimina el icono de búsqueda
                    onTap: () {
                      var habitId = _habitTypes[index]['id'];
                      goToHabitItem(habitId);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica para la acción del botón flotante
        },
        label: const Row(
          children: [
            Text('Crear hábito'),
            SizedBox(width: 5),
            Icon(Icons.add),
          ],
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  backgroundColor: Colors.blue.withOpacity(0.6),
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
  
    if (index == 2) { // Verifica si el índice seleccionado es para "Cuenta"
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()), // Navega a la página UserProfile
      );
    }
  },
  elevation: 0.0,
),
    );

    }
 }
