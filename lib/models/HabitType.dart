class HabitType{
  final int id;
  final String type;
  final int user_id;

  const HabitType({
    required this.id,
    required this.type,
    required this.user_id,
  });

  factory HabitType.fromJson(Map<String, dynamic> json){
    return switch(json){{
      'id': int id,
      'type': String type,
      'user_id': int user_id,
    }=> 
    HabitType(
      id: id,
      type: type,
      user_id: user_id,
    ),
    _=> throw const FormatException('Fallo al cargar modelo'),
    };
  }

}
