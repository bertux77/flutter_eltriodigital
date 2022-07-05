// To parse this JSON data, do
//
//     final productoCarrito = productoCarritoFromJson(jsonString);

import 'dart:convert';

ProductoCarrito productoCarritoFromJson(String str) => ProductoCarrito.fromJson(json.decode(str));

String productoCarritoToJson(ProductoCarrito data) => json.encode(data.toJson());

class ProductoCarrito {
    ProductoCarrito({
        this.id,
        this.name,
        this.type,
        this.status,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.onSale,
        this.stockQuantity,
        this.parentId,
        this.quantity,
        this.image,
        this.variacion,
    });

    int? id;
    String? name;
    String? type;
    String? status;
    String? sku;
    String? price;
    String? regularPrice;
    String? salePrice;
    bool? onSale;
    int? stockQuantity;
    int? parentId;
    int? quantity;
    String? image;
    Variacion? variacion;

    factory ProductoCarrito.fromJson(Map<String, dynamic> json) => ProductoCarrito(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        status: json["status"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regularPrice"],
        salePrice: json["salePrice"],
        onSale: json["onSale"],
        stockQuantity: json["stockQuantity"],
        parentId: json["parentId"],
        quantity: json["quantity"],
        image: json["image"],
        variacion: Variacion.fromJson(json["variacion"]),
    );

    static List<ProductoCarrito> fromJsonList(List<dynamic> jsonList) {
      List<ProductoCarrito> toList = [];
      jsonList.forEach((item) {
        ProductoCarrito product = ProductoCarrito.fromJson(item);
        toList.add(product);
      });

      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "status": status,
        "sku": sku,
        "price": price,
        "regularPrice": regularPrice,
        "salePrice": salePrice,
        "onSale": onSale,
        "stockQuantity": stockQuantity,
        "parentId": parentId,
        "quantity": quantity,
        "image": image,
        "variacion": variacion?.toJson(),
    };
}

class Image {
    Image({
        this.id,
        this.src,
        this.name,
        this.alt,
    });

    int? id;
    String? src;
    String? name;
    String? alt;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "name": name,
        "alt": alt,
    };
}

class Variacion {
    Variacion({
        this.id,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.name,
        this.quantity,
        this.onSale,
    });

    int? id;
    String? sku;
    String? price;
    String? regularPrice;
    String? salePrice;
    String? name;
    int? quantity;
    bool? onSale;

    factory Variacion.fromJson(Map<String, dynamic> json) => Variacion(
        id: json["id"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regularPrice"],
        salePrice: json["salePrice"],
        name: json["name"],
        quantity: json["quantity"],
        onSale: json["onSale"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "price": price,
        "regularPrice": regularPrice,
        "salePrice": salePrice,
        "name": name,
        "quantity": quantity,
        "onSale": onSale,
    };
}
