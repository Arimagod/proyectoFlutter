import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/Status.dart';
import 'dart:convert';



class StatusItem extends StatefulWidget {
  const StatusItem({super.key,required this.id});
  final int id;
  @override
  State<StatusItem> createState() => _StatusItemState();
}


class _StatusItemState extends State<StatusItem> {
  late Future<Status> futureStatus;

  @override
  void initState() {
    super.initState();
    futureStatus = fetchStatus();
  }
  Future<Status> fetchStatus() async {
  final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/statuses/${widget.id}'),
    );


  if (response.statusCode == 200) {
    return Status.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Obtener datos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      ),
      home:(Scaffold(
        appBar: AppBar(
          title: const Text('Obtener datos'),
        ),
        body: Center(
          child: FutureBuilder<Status>(
            future: futureStatus,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.status),
                    Text(snapshot.data!.id.toString()),

                  ],
                );
                
              }else if (snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          )
        )
        )
      )

    );

    
  }

}