import 'package:eltriodigital_flutter/src/models/producto_carrito.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/carrito/tienda_carrito_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaCarritoPage extends StatelessWidget {
  TiendaCarritoController con = Get.put(TiendaCarritoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: 100,
          child: _totalToPay(context),
        ),
        appBar: MyAppBar(title: 'Carrito'),
        body: con.selectedProducts.isNotEmpty
            ? ListView(
                children: con.selectedProducts.map((ProductoCarrito product) {
                  if (product.quantity == null) {
                    product.quantity == 1;
                  }
                  return _cardProduct(context, product);
                }).toList(),
              )
            : Center(
                child: NoDataWidget(
                  text: 'Carrito vacio',
                ),
              )));
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'TOTAL:',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text('${con.total.value.toStringAsFixed(2)} €',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.60,
                child: ElevatedButton(
                  onPressed: () => con.goToCheckout(),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15)),
                  child: const Text(
                    'CONFIRMAR PEDIDO',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardProduct(BuildContext context, ProductoCarrito product) {
    String variacion = product.variacion?.name ?? '';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                    ),
                    Text(
                      variacion,
                      style: const TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _buttonsAddOrRemove(product)
            ],
          ),
          const Spacer(),
          Column(
            children: [
              _unidadesXPrecio(product),
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }

  Widget _unidadesXPrecio(ProductoCarrito product) {
    return Container(
        child: Text(
      '${product.quantity} x ${product.price}',
      style: const TextStyle(
          fontSize: 10, color: Colors.grey, fontWeight: FontWeight.normal),
    ));
  }

  Widget _iconDelete(ProductoCarrito product) {
    return IconButton(
      onPressed: () => con.deleteItem(product),
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }

  Widget _textPrice(ProductoCarrito product) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Text(
        '${(double.parse(product.price!) * product.quantity!).toStringAsFixed(2)}€',
        style: const TextStyle(
            fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buttonsAddOrRemove(ProductoCarrito product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => con.removeItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: const Text(
              '-',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child:
              Text('${product.quantity ?? 0}', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () => con.addItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: const Text('+', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _imageProduct(ProductoCarrito product) {
    return Container(
      height: 70,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FadeInImage(
          image: product.image != null
              ? NetworkImage(product.image!)
              : AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }
}
