class Frequency{
  final int id;
  final String frequency;

  const Frequency({
    required this.id,
    required this.frequency,
  });

  factory Frequency.fromJson(Map<String, dynamic> json){
    return switch(json){{
      'id': int id,
      'frequency': String frequency,
    }=> 
    Frequency(
      id: id,
      frequency: frequency,
    ),
    _=> throw const FormatException('Fallo al cargar modelo'),
    };
  }
}