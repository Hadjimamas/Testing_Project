class Squad {
  int id;
  String name;
  int age;
  int number;
  String position;
  String photo;

  Squad(this.id, this.name, this.age, this.number, this.position, this.photo);

  factory Squad.fromJson(Map<String, dynamic> json) {
    return Squad(json['id'], json['name'], json['age'], json['number'],
        json['position'], json['photo']);
  }

  @override
  String toString() {
    return "{id: $id, name: $name, age: $age, number: $number, position: $position,photo: $photo}";
  }
}
