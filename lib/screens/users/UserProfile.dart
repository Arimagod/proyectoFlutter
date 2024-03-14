import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Simulando datos del usuario
  String _name = "Juan Pérez";
  String _email = "juan@example.com";

  // Controladores de texto para los campos editables
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Asignar los valores iniciales a los controladores de texto
    _nameController.text = _name;
    _emailController.text = _email;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Esto elimina el banner de debug
      theme: ThemeData( // Configurar el tema de la aplicación
        scaffoldBackgroundColor: Colors.white, // Establecer el color de fondo del Scaffold
      ),
      home: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Nombre:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  enabled: false, // Desactivar edición del campo de texto
                ),
                SizedBox(height: 20),
                Text(
                  'Correo electrónico:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  enabled: false, // Desactivar edición del campo de texto
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para guardar los cambios
                        setState(() {
                          _name = _nameController.text;
                          _email = _emailController.text;
                        });
                        // Mostrar un mensaje de éxito o realizar otras acciones necesarias
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Cambios guardados'),
                          ),
                        );
                      },
                      child: Text('Guardar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para cancelar los cambios
                        _nameController.text = _name;
                        _emailController.text = _email;
                        // Mostrar un mensaje o realizar otras acciones necesarias
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Cambios cancelados'),
                          ),
                        );
                      },
                      child: Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
