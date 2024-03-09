import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/Habit.dart';
import 'dart:convert';




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
      Uri.parse('http://127.0.0.1:8000/api/habits/${widget.id}'),
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
        )
        );
      


    
  }

}