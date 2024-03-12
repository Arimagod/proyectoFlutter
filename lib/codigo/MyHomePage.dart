import 'package:flutter/material.dart';
import 'package:proyecto/codigo/Frequencies.dart';
import 'package:proyecto/codigo/HabitTypes.dart';
import 'package:proyecto/codigo/Habits.dart';
import 'package:proyecto/screens/users/UserList.dart';
import 'package:proyecto/screens/statuses/StatusList.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Habits(title: 'Habitos')),
                );
              },
                child:Container(
                  height: 50,
                  color: Colors.blue[500],
                  child: const Center(child: Text('Habitos')),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HabitTypes(title: 'Tipos de habitos')),
                );
              },
                child:Container(
                  height: 50,
                  color: Colors.blue[500],
                  child: const Center(child: Text('Tipos de habitos')),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Frequencies(title: 'Frecuencia de seguimiento')),
                );
              },
                child:Container(
                  height: 50,
                  color: Colors.blue[500],
                  child: const Center(child: Text('seguimiento')),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StatusList()),
                );
              },
                child:Container(
                  height: 50,
                  color: Colors.blue[500],
                  child: const Center(child: Text('Estado del habito')),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserList()),
                );
              },
                child:Container(
                  height: 50,
                  color: Colors.blue[500],
                  child: const Center(child: Text('Usuarios')),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

