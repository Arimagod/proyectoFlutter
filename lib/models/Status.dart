class Status{
  final int id;
  final String status;

  const Status({
    required this.id,
    required this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json){
    return switch(json){{
      'id': int id,
      'status': String status,
    }=> 
    Status(
      id: id,
      status: status,
    ),
    _=> throw const FormatException('Fallo al cargar modelo'),
    };
  }

}