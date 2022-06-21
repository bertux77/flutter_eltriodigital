// To parse this JSON data, do
//
//     final categoria = categoriaFromJson(jsonString);

import 'dart:convert';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
    Categoria({
        this.id,
        this.name,
        this.slug,
        this.parent,
        this.display,
        this.menuOrder,
        this.count,
    });

    int? id;
    String? name;
    String? slug;
    int? parent;
    String? display;
    int? menuOrder;
    int? count;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parent: json["parent"],
        display: json["display"],
        menuOrder: json["menu_order"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent": parent,
        "display": display,
        "menu_order": menuOrder,
        "count": count,
    };
}
