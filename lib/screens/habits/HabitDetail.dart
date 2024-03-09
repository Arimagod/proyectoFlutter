import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/Habit.dart';
import 'dart:convert';

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
      backgroundColor: Colors.blueGrey[50], // Color de fondo gris azulado claro
      appBar: AppBar(
        backgroundColor: Colors.blue, // Color de la barra de título azul
        title: const Text(
          'Hábitos',
          style: TextStyle(
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
              return SingleChildScrollView(
                child:  DataTable(
                  columnSpacing: 20, // Espacio entre columnas
                  dataRowHeight: 60, // Altura de cada fila de datos
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
                      DataCell( Text(
                        habit.user.name,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      )),
                      DataCell( Text(
                        habit.habitType.type,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      )),
                      DataCell(Text(
                        habit.frequency.frequency,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      )),
                      DataCell(Text(
                        habit.status.status,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      )),
                    ]);
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
