import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/Status.dart';
import 'package:proyecto/screens/statuses/StatusItem.dart';
import 'dart:convert';


Future<List<Status>> fetchStatus() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/statuses'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((status) => Status.fromJson(status)).toList();
  } else {
    throw Exception('Failed to load statuses');
  }
}

class StatusList extends StatefulWidget {
  const StatusList({Key? key}) : super(key: key);

  @override
  State<StatusList> createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  late Future<List<Status>> futureStatus;

  @override
  void initState() {
    super.initState();
    futureStatus = fetchStatus();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Obtener datos'),
    ),
    body: Center(
      child: FutureBuilder<List<Status>>(
        future: futureStatus,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Status status = snapshot.data![index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatusItem(id:status.id),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      color: Colors.blue[20],
                      child: Center(child: 
                      Text(status.status),
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
