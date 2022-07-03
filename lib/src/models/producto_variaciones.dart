// To parse this JSON data, do
//
//     final productoVariaciones = productoVariacionesFromJson(jsonString);

import 'dart:convert';

ProductoVariaciones productoVariacionesFromJson(String str) =>
    ProductoVariaciones.fromJson(json.decode(str));

String productoVariacionesToJson(ProductoVariaciones data) =>
    json.encode(data.toJson());

class ProductoVariaciones {
  ProductoVariaciones({
    this.id,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.attributes,
  });

  int? id;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  bool? manageStock;
  int? stockQuantity;
  String? stockStatus;
  List<Attribute>? attributes;

  factory ProductoVariaciones.fromJson(Map<String, dynamic> json) =>
      ProductoVariaciones(
        id: json["id"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        //manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        stockStatus: json["stock_status"],
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "on_sale": onSale,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "stock_status": stockStatus,
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.option,
  });

  int? id;
  String? name;
  String? option;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
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
