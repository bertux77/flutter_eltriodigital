// To parse this JSON data, do
//
//     final wallet = walletFromJson(jsonString);

import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    Wallet({
        this.id,
        this.ventaId,
        this.tipo,
        this.beneficioCompra,
        this.totalActual,
        this.canjeoCompra,
        this.createdAt,
        this.compra,
    });

    int? id;
    int? ventaId;
    String? tipo;
    double? beneficioCompra;
    double? totalActual;
    double? canjeoCompra;
    DateTime? createdAt;
    Compra? compra;

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        ventaId: json["venta_id"],
        tipo: json["tipo"],
        beneficioCompra: json["beneficio_compra"].toDouble(),
        totalActual: json["total_actual"].toDouble(),
        canjeoCompra: json["canjeo_compra"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        compra: Compra.fromJson(json["compra"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "venta_id": ventaId,
        "tipo": tipo,
        "beneficio_compra": beneficioCompra,
        "total_actual": totalActual,
        "canjeo_compra": canjeoCompra,
        "created_at": createdAt?.toIso8601String(),
        "compra": compra?.toJson(),
    };
}

class Compra {
    Compra({
        this.id,
        this.canjeoWallet,
        this.totalVenta,
    });

    int? id;
    int? canjeoWallet;
    double? totalVenta;

    factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        id: json["id"],
        canjeoWallet: json["canjeo_wallet"],
        totalVenta: json["total_venta"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "canjeo_wallet": canjeoWallet,
        "total_venta": totalVenta,
    };
}
