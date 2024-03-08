class Habit {
  final int id;
  final String name;
  final String description;
  final int userId;
  final int statusId;
  final int frequencyId;
  final int habitTypeId;

  const Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.statusId,
    required this.frequencyId,
    required this.habitTypeId,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      userId: json['user_id'] as int,
      statusId: json['status_id'] as int,
      frequencyId: json['frequency_id'] as int,
      habitTypeId: json['habit_type_id'] as int,
    );
  }
}
