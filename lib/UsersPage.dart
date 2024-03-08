import 'package:flutter/material.dart';
import 'package:proyecto/screens/users/UserList.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.title),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Usuarios',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserList()));
                    },
                    child: const Text("Ver Usuarios")),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
                    
