import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto/models/User.dart';
import 'dart:convert';

import 'package:proyecto/screens/users/UserItem.dart';

Future<List<User>> fetchUser() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8001/api/users'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserPageState();
}

class _UserPageState extends State<UserList> {
  late Future<List<User>> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Obtener datos'),
    ),
    body: Center(
      child: FutureBuilder<List<User>>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserItem(id:user.id),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      color: Colors.blue[20],
                      child: Center(child: 
                      Text(user.name),
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
