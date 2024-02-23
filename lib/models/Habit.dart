class Habit{
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

  factory Habit.fromJson(Map<String, dynamic> json){
    return switch(json){{
      'id': int id,
      'name ': String name,
      'description': String description,
      'user_id': int userId,
      'status_id': int statusId,
      'frequency_id': int frequencyId,
      'habit_type_id': int habitTypeId,
      
    }=> 
    Habit(
      id: id,
      name: name,
      description: description,
      userId: userId,
      statusId: statusId,
      frequencyId: frequencyId,
      habitTypeId: habitTypeId,
      
    ),
    _=> throw const FormatException('Fallo al cargar modelo'),
    };
  }
}
