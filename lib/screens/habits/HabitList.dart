import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/Habit.dart';
import 'dart:convert';
import 'package:proyecto/screens/habits/HabitItem.dart';

Future<List<Habit>> fetchHabit() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/habit'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((habit) => Habit.fromJson(habit)).toList();
  } else {
    throw Exception('Falló al cargar los datos');
  }
}

class HabitList extends StatefulWidget {
  const HabitList({Key? key}) : super(key: key);

  @override
  State<HabitList> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitList> {
  late Future<List<Habit>> futureHabit;

  @override
  void initState() {
    super.initState();
    futureHabit = fetchHabit();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white, // Color de fondo blanco
          appBar: AppBar(
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
      child: FutureBuilder<List<Habit>>(
        future: futureHabit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Habit habit = snapshot.data![index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HabitItem(id:habit.id),
                        ),
                      );
                    },
                      child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                      ),
                      child: Center(child:
                      Text(habit.habitType.type,
                      ),
                      ),
                    ),
                  );
                },
              ); 
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
