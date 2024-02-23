import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/User.dart';
import 'dart:convert';




class UserItem extends StatefulWidget {
  const UserItem({super.key,required this.id});
  final int id;
  @override
  State<UserItem> createState() => _UserItemState();
}


class _UserItemState extends State<UserItem> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }
  Future<User> fetchUser() async {
  final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/users/${widget.id}'),
    );


  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
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
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.name),
                    Text(snapshot.data!.email),
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