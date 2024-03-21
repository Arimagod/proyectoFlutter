
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/Habit.dart';
import 'package:proyecto/screens/habits/HabitItem.dart';
import 'package:proyecto/screens/habits/UpdateHabitPage.dart';
import 'package:proyecto/screens/login/AuthService.dart';


class HabitList extends StatefulWidget {
  const HabitList({Key? key}) : super(key: key);

  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  late Future<List<Habit>> futureHabits;
  List<Habit> displayedHabits = [];

  @override
  void initState() {
    super.initState();
    futureHabits = fetchHabits();
  }

  void filterHabits(String text, List<Habit> habits) {
    setState(() {
      displayedHabits = habits
          .where((habit) => habit.habitType.type.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  Future<List<Habit>> fetchHabits() async {
    final response = await http.get(Uri.parse('https://marin.terrabyteco.com/api/habit/user/${AuthService.userId.toString()}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((habit) => Habit.fromJson(habit)).toList();
    } else {
      throw Exception('Failed to load habits');
    }
  }

  @override
Widget build(BuildContext context) {
  return FutureBuilder<List<Habit>>(
    future: futureHabits,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No tienes hábitos creados. ¿Por qué no?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Cambia el color a rojo para que sea más llamativo
                ),
              ),
              SizedBox(height: 10), // Espaciado adicional
              Text(
                '¡empieza a crear uno!.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      } else if (snapshot.hasData) {
        if (displayedHabits.isEmpty) {
          displayedHabits = snapshot.data!;
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (text) {
                  filterHabits(text, snapshot.data!);
                },
                decoration: InputDecoration(
                  hintText: 'Buscar tipo de hábito',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedHabits.length,
                itemBuilder: (context, index) {
                  Habit habit = displayedHabits[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HabitItem(id: habit.id)),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            habit.habitType.type,
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UpdateHabitPage(habit: habit)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      } else {
        return Center(child: Text('No hay hábitos disponibles'));
      }
    },
  );
}
    
 }

