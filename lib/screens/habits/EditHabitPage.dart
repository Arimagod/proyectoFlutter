import 'package:flutter/material.dart';
import 'package:proyecto/models/Habit.dart';

class EditHabitPage extends StatefulWidget {
  final Habit habit;

  const EditHabitPage({Key? key, required this.habit}) : super(key: key);

  @override
  _EditHabitPageState createState() => _EditHabitPageState();
}

class _EditHabitPageState extends State<EditHabitPage> {
  late TextEditingController _frequencyController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    // Convertir a String si es necesario
    String frequency = widget.habit.frequency.toString();
    String status = widget.habit.status.toString();
    _frequencyController = TextEditingController(text: frequency);
    _statusController = TextEditingController(text: status);
  }

  @override
  void dispose() {
    _frequencyController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Hábito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Frecuencia:'),
            TextField(
              controller: _frequencyController,
              decoration: InputDecoration(hintText: 'Ingrese la nueva frecuencia'),
            ),
            SizedBox(height: 20),
            Text('Estado:'),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(hintText: 'Ingrese el nuevo estado'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar los cambios y volver a la pantalla anterior
                Navigator.pop(context);
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
