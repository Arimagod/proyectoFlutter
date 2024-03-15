import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/screens/login/AuthService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Llenar automáticamente los campos con los datos actuales del usuario
    _nameController.text = AuthService.userName;
    _emailController.text = AuthService.userEmail;
  }

  Future<void> _updateProfile() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/users/update/${AuthService.userId}');

    try {
      final response = await http.put(
        url,
        headers: {'Authorization': 'Bearer ${AuthService.token}'},
        body: {
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Mostrar mensaje de éxito al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Perfil modificado con éxito'),
          ),
        );
      } else {
        // Manejar errores de actualización del perfil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar el perfil'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      // Manejar errores de conexión o excepciones
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error de conexión'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.withOpacity(0.7), Colors.blue.withOpacity(0.2)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Nombre:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: _nameController,
                  enabled: _isEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Correo electrónico:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: _emailController,
                  enabled: _isEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_isEditing)
                  SizedBox(height: 20),
                if (_isEditing)
                  Text(
                    'Contraseña:',
                    style: TextStyle(fontSize: 18),
                  ),
                if (_isEditing)
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Cancelar' : 'Editar'),
                ),
                if (_isEditing)
                  SizedBox(height: 10),
                if (_isEditing)
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text('Guardar cambios'),
                  ),
                SizedBox(height: 20),
                if (_isEditing)
                  Text(
                    'Token de acceso: ${AuthService.token}',
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
