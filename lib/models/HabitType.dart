class HabitType{
  final int id;
  final String type;

  const HabitType({
    required this.id,
    required this.type,
  });

  factory HabitType.fromJson(Map<String, dynamic> json){
    return switch(json){{
      'id': int id,
      'type': String type,
    }=> 
    HabitType(
      id: id,
      type: type,
    ),
    _=> throw const FormatException('Fallo al cargar modelo'),
    };
  }

}
