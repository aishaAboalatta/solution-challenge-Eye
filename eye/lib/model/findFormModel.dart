class findFormModel {
  String id;
  String userId;
  String name;
  String photo;
  num age;
  String date;
  String time;
  String location;
  String description;
  String state;
  List predectedArray;

  findFormModel(
      {required this.id,
      required this.userId,
      required this.name,
      required this.photo,
      required this.age,
      required this.date,
      required this.time,
      required this.location,
      required this.description,
      required this.state,
      required this.predectedArray});

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "photo": photo,
        "age": age,
        "date": date,
        "time": time,
        "location": location,
        "description": description,
        "state": state,
        "predectedArray": predectedArray
      };

  static findFormModel fromJson(Map<String, dynamic> json) => findFormModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      photo: json['photo'],
      age: json['age'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      description: json['description'],
      state: json['state'],
      predectedArray: json['predectedArray']);
}
