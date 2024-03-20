import 'package:proyecto/models/User.dart';

class HabitType {
  final int id;
  final String type;
  final User user;

  HabitType({
    required this.id, 
    required this.type, 
    required this.user,
  });

  factory HabitType.fromJson(Map<String, dynamic> json) {
    return HabitType(
      id: json['id'],
      type: json['type'],
      user: User.fromJson(json['user']),
    );
  }

}
