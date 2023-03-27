class UserModel {
  String name;
  String email;
  String location;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.location,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      location: map['bio'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "bio": location,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "bio": location,
        "profilePic": profilePic,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        uid: json['uid'],
        location: json['bio'],
        profilePic: json['profilePic'],
        phoneNumber: json['phoneNumber'],
        createdAt: json['createdAt'],
      );
}
