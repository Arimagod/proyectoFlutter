import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/HabitType.dart'; // Importa tu modelo de tipo de hábito
import 'package:proyecto/screens/habits/HabitItem.dart';
import 'package:proyecto/screens/habits/UpdateHabitPage.dart';
import 'package:proyecto/screens/login/AuthService.dart';

class HabitTypeList extends StatefulWidget {
  const HabitTypeList({Key? key}) : super(key: key);
  

  @override
  _HabitTypeListState createState() => _HabitTypeListState();
}

class _HabitTypeListState extends State<HabitTypeList> {
  late Future<List<HabitType>> futureHabitTypes;
  List<HabitType> displayedHabitTypes = [];

  @override
  void initState() {
    super.initState();
    futureHabitTypes = fetchHabitTypes();
  }

  void filterHabitTypes(String text, List<HabitType> habitTypes) {
    setState(() {
      displayedHabitTypes = habitTypes
          .where((habitType) => habitType.type.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  Future<List<HabitType>> fetchHabitTypes() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/habit_type/habitTypeUser/${AuthService.userId.toString()}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((habitType) => HabitType.fromJson(habitType)).toList();
    } else {
      throw Exception('Failed to load habit types');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HabitType>>(
      future: futureHabitTypes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los tipos de hábitos'));
        } else if (snapshot.hasData) {
          if (displayedHabitTypes.isEmpty) {
            displayedHabitTypes = snapshot.data!;
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (text) {
                    filterHabitTypes(text, snapshot.data!);
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
                  itemCount: displayedHabitTypes.length,
                  itemBuilder: (context, index) {
                    HabitType habitType = displayedHabitTypes[index];
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => HabitItem(id: habit.id)),
                        //   );
                        // Aquí puedes agregar la navegación para ver los detalles del tipo de hábito si lo deseas
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
                              habitType.type,
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(builder: (context) => UpdateHabitPage(habitTypeList: habitTypeList)),
                                    //   );
                                  },
                                ),
                              ],
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
          return Center(child: Text('No hay tipos de hábitos disponibles'));
        }
      },
    );
  }
}
