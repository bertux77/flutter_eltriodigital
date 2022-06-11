// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? sessionToken; 

  User({
      this.id,
      this.name,
      this.email,
      this.password,
      this.sessionToken
  });

    

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      sessionToken: json["session_token"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "session_token": sessionToken
  };
}
