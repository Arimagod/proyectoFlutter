import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/HabitType.dart'; // Asegúrate de importar el modelo correcto para HabitTypes
import 'dart:convert';

import 'package:proyecto/screens/login/AuthService.dart';


Future<List<HabitType>> fetchHabitTypes() async {
  final response = await http.get(
    Uri.parse('https://marin.terrabyteco.com/api/habit_type/habitTypeUser/${AuthService.userId}'), // Cambia la URL según la ruta correcta para obtener los tipos de hábitos
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((habitType) => HabitType.fromJson(habitType)).toList();
  } else {
    throw Exception('Failed to load habit types');
  }
}

class HabitTypeList extends StatefulWidget {
  const HabitTypeList({Key? key}) : super(key: key);

  @override
  State<HabitTypeList> createState() => _HabitTypeListState();
}

class _HabitTypeListState extends State<HabitTypeList> {
  late Future<List<HabitType>> futureHabitTypes;

  @override
  void initState() {
    super.initState();
    futureHabitTypes = fetchHabitTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Obtener datos'),
      ),
      body: Center(
        child: FutureBuilder<List<HabitType>>(
          future: futureHabitTypes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  HabitType habitType = snapshot.data![index];
                  return InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HabitTypeItem(id: habitType.id), // Asegúrate de pasar el ID del tipo de hábito correcto
                    //     ),
                    //   );
                    // },
                    child: Container(
                      height: 50,
                      color: Colors.blue[20],
                      child: Center(
                        child: Text(habitType.type), // Asegúrate de mostrar el nombre del tipo de hábito correctamente
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
