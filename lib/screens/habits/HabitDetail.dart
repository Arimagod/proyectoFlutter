import 'package:flutter/material.dart';
import 'package:proyecto/HomePage.dart';
import 'package:proyecto/models/Habit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/screens/login/AuthService.dart';
import 'package:proyecto/screens/users/UserProfile.dart';

Future<List<Habit>> fetchHabit() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/habit/user/${AuthService.userId.toString()}'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((habit) => Habit.fromJson(habit)).toList();
  } else {
    throw Exception('Falló al cargar los datos');
  }
}

class HabitDetail extends StatefulWidget {
  const HabitDetail({Key? key}) : super(key: key);

  @override
  State<HabitDetail> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetail> {
  late Future<List<Habit>> futureHabit;

  @override
  void initState() {
    super.initState();
    futureHabit = fetchHabit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          'Hábitos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<List<Habit>>(
          future: futureHabit,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    dataRowHeight: 60,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Usuario',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tipo del Hábito',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Descripción',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Frecuencia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Estado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                    rows: snapshot.data!.map((habit) {
                      return DataRow(cells: [
                        DataCell(
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 150, // Define your maximum width here
                            ),
                            child: Text(
                              habit.user.name,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 150, // Define your maximum width here
                            ),
                            child: Text(
                              habit.habitType.type,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 100, // Define your maximum width here
                              ),
                              child: Text(
                                habit.description,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        DataCell(
                          Text(
                            habit.frequency.frequency,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            habit.status.status,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomePage()),
              // );
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