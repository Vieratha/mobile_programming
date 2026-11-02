import 'package:flutter/material.dart';
import 'package:pertemuan_7/main.dart';

class WorkoutPage extends StatelessWidget{
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout')),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.pop(context,
            );
          },
          child: const Text('Home'),
        ),
      ),
    );
  }
}