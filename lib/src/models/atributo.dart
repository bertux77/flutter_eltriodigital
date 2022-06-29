// To parse this JSON data, do
//
//     final atributo = atributoFromJson(jsonString);

import 'dart:convert';

Atributo atributoFromJson(String str) => Atributo.fromJson(json.decode(str));

String atributoToJson(Atributo data) => json.encode(data.toJson());

class Atributo {
    Atributo({
        this.id,
        this.name,
        this.option,
    });

    int? id;
    String? name;
    String? option;

    factory Atributo.fromJson(Map<String, dynamic> json) => Atributo(
        id: json["id"],
        name: json["name"],
        option: json["option"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "option": option,
    };
}
