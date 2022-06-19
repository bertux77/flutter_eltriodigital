// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? name;
  String? telefono;
  String? direccion;
  String? poblacion;
  String? cp;
  String? provincia;
  String? image;
  String? email;
  String? password;
  String? sessionToken;

  User(
      {this.id,
      this.name,
      this.image,
      this.telefono,
      this.direccion,
      this.poblacion,
      this.cp,
      this.provincia,
      this.email,
      this.password,
      this.sessionToken});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        name: json["name"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        poblacion: json["poblacion"],
        cp: json["cp"],
        provincia: json["provincia"],
        image: json["image"],
        email: json["email"],
        password: json["password"],
        sessionToken: json["session_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "telefono": telefono,
        "direccion": direccion,
        "poblacion": poblacion,
        "cp": cp,
        "provincia": provincia,
        "email": email,
        "password": password,
        "session_token": sessionToken
      };
}
