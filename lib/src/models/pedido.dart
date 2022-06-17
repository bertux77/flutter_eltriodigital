// To parse this JSON data, do
//
//     final pedido = pedidosFromJson(jsonString);

import 'dart:convert';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido({
    this.id,
    this.tipo,
    this.totalCoste,
    this.canjeoWallet,
    this.totalVenta,
    this.ganancia,
    this.clienteId,
    this.userId,
    this.proyectoId,
    this.createdAt,
    this.productosVendidos,
  });

  int? id;
  int? tipo;
  double? totalCoste;
  double? canjeoWallet;
  double? totalVenta;
  double? ganancia;
  int? clienteId;
  int? userId;
  int? proyectoId;
  DateTime? createdAt;
  List<ProductosVendido>? productosVendidos;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        id: json["id"],
        tipo: json["tipo"],
        totalCoste: json["total_coste"].toDouble(),
        canjeoWallet: json["canjeo_wallet"].toDouble(),
        totalVenta: json["total_venta"].toDouble(),
        ganancia: json["ganancia"].toDouble(),
        clienteId: json["cliente_id"],
        userId: json["user_id"],
        proyectoId: json["proyecto_id"],
        createdAt: DateTime.parse(json["created_at"]),
        productosVendidos: List<ProductosVendido>.from(
            json["productos_vendidos"]
                .map((x) => ProductosVendido.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "total_coste": totalCoste,
        "canjeo_wallet": canjeoWallet,
        "total_venta": totalVenta,
        "ganancia": ganancia,
        "cliente_id": clienteId,
        "user_id": userId,
        "proyecto_id": proyectoId,
        "created_at": createdAt?.toIso8601String(),
        "productos_vendidos":
            List<dynamic>.from(productosVendidos!.map((x) => x.toJson())),
      };
}

class ProductosVendido {
  ProductosVendido({
    this.id,
    this.ud,
    this.sku,
    this.idWoocommerce,
    this.parentId,
    this.nombre,
    this.url,
    this.coste,
    this.venta,
    this.ventaId,
    this.userId,
    this.createdAt,
  });

  int? id;
  int? ud;
  int? sku;
  int? idWoocommerce;
  int? parentId;
  String? nombre;
  String? url;
  double? coste;
  double? venta;
  int? ventaId;
  int? userId;
  DateTime? createdAt;

  factory ProductosVendido.fromJson(Map<String, dynamic> json) =>
      ProductosVendido(
        id: json["id"],
        ud: json["ud"],
        sku: json["SKU"],
        idWoocommerce: json["id_woocommerce"],
        parentId: json["parent_id"],
        nombre: json["nombre"],
        url: json["url"],
        coste: json["coste"].toDouble(),
        venta: json["venta"].toDouble(),
        ventaId: json["venta_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ud": ud,
        "SKU": sku,
        "id_woocommerce": idWoocommerce,
        "parent_id": parentId,
        "nombre": nombre,
        "url": url,
        "coste": coste,
        "venta": venta,
        "venta_id": ventaId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
      };
}
