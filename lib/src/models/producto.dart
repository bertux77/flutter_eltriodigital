// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  Producto({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.type,
    this.status,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.manageStock,
    this.stockQuantity,
    this.parentId,
    this.quantity,
    this.description,
    this.shortDescription,
    this.categories,
    this.images,
    this.attributes,
    this.relatedIds,
  });

  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  String? type;
  String? status;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? manageStock;
  int? stockQuantity;
  int? parentId;
  int? quantity;
  String? description;
  String? shortDescription;
  List<Category>? categories;
  List<Image>? images;
  List<Attribute>? attributes;
  List<int>? relatedIds;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: DateTime.parse(json["date_created"]),
        type: json["type"],
        status: json["status"],
        description: Bidi.stripHtmlIfNeeded(json["description"]),
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        parentId: json["parent_id"],
        quantity: json["quantity"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
      );

  static List<Producto> fromJsonList(List<dynamic> jsonList) {
    List<Producto> toList = [];
    jsonList.forEach((item) {
      Producto product = Producto.fromJson(item);
      toList.add(product);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated!.toIso8601String(),
        "type": type,
        "status": status,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "quantity": quantity,
        "parent_id": parentId,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "related_ids": List<dynamic>.from(relatedIds!.map((x) => x)),
      };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
    this.optionIds,
  });

  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;
  List<int>? optionIds;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: List<String>.from(json["options"].map((x) => x)),
        optionIds: List<int>.from(json["option_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": List<dynamic>.from(options!.map((x) => x)),
        "option_ids": List<dynamic>.from(optionIds!.map((x) => x)),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Image {
  Image({
    this.id,
    this.src,
  });

  int? id;
  String? src;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}
