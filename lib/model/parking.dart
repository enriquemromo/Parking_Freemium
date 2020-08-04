class Parking {
  int id;
  String name;
  String adress;

  Parking();

  Parking.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        adress = json['adress'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'adress': adress};
}
