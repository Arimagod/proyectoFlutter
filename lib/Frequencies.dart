import 'package:flutter/material.dart';

class Frequencies extends StatefulWidget {
  const Frequencies({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Frequencies> createState() => _FrequenciesState();
}

class _FrequenciesState extends State<Frequencies> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Registo de seguimiento',
            ),
            
            
            
          ],
        ),
      ),
    );
  }
}

