import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/hola.jpeg'),
            ),
            SizedBox(height: 20.0),
            ProfileDetail(label: 'Nombre', value: 'Juan Pérez'),
            ProfileDetail(label: 'Correo electrónico', value: 'juan.perez@example.com'),
            ProfileDetail(label: 'Teléfono', value: '+1234567890'),
            ProfileDetail(label: 'Fecha de nacimiento', value: '01/01/1990'),
            ProfileDetail(label: 'Género', value: 'Masculino'),
            ProfileDetail(label: 'Dirección', value: 'Calle Principal, Ciudad, País'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Mostrar ventana emergente para editar perfil
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditProfileDialog();
                  },
                );
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetail({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

class EditProfileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Perfil'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Acción para guardar los cambios en el perfil
            Navigator.of(context).pop();
          },
          child: Text('Guardar Cambios'),
        ),
      ],
    );
  }
}
