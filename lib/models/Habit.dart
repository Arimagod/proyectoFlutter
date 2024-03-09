import 'package:flutter/material.dart';
import 'package:proyecto/models/Frequency.dart';
import 'package:proyecto/models/HabitType.dart';
import 'package:proyecto/models/Status.dart';
import 'package:proyecto/models/User.dart';

class Habit {
   final int id;
  final String name;
  final String description;
  final User user;
  final Status status;
  final Frequency frequency;
  final HabitType habitType;

  const Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.user,
    required this.status,
    required this.frequency,
    required this.habitType,
  });

  factory Habit.fromJson(Map<String, dynamic> json){
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      user: User.fromJson(json['user']),
      status: Status.fromJson(json['status']),
      frequency: Frequency.fromJson(json['frequency']),
      habitType: HabitType.fromJson(json['habit_type']),
    );
  }
}

