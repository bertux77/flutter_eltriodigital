import 'package:eltriodigital_flutter/main.dart';
import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/checkout/tienda_checkout_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/metodos_pago.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaCheckoutPage extends StatelessWidget {
  TiendaCheckoutController con = Get.put(TiendaCheckoutController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiendaCheckoutController>(
        init: TiendaCheckoutController(), // intialize with the Controller
        builder: (value) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Column(
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      '${value.total} €',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _txtResumenPedido(),
                  // _listadoPedido(
                  //   value: value,
                  // ),
                  Text(
                    'TOTAL: ${value.total}€',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    indent: 15, // donde empieza la linea
                    endIndent: 15, // donde acaba la linea
                    thickness: 2.0, // Grosor de la linea
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MetodosPago(),
                  _txtDireccionDeEntrega(),
                  _direccionEntrega(con),
                  const SizedBox(
                    height: 10,
                  ),
                  con.tieneDireccion == true
                      ? _btnConfirmarCompra(context)
                      : _btnEditarPerfil(context)
                ],
              ),
            ));
  }
}

Widget _txtResumenPedido() {
  return const Text(
    'Resumen Pedido',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );
}

Widget _txtDireccionDeEntrega() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: const [
        Icon(Icons.add_location_alt),
        Text(
          ' Direccion de entrega',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _direccionEntrega(TiendaCheckoutController con) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          con.userSession.name ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      ListTile(
        //leading: Icon(Icons.map),
        title: Text(con.userSession.direccion ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            "${con.userSession.cp} - ${con.userSession.poblacion} - ${con.userSession.provincia} "
            "\n"
            "Télefono: ${con.userSession.telefono}"),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: Column(
                children: const [
                  Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  Text('editar')
                ],
              ),
              onTap: () => con.goToEditarPerfil(),
            ),
          ],
        ),
        onTap: () {},
      ),
    ],
  );
}

class _listadoPedido extends StatelessWidget {
  final TiendaCheckoutController value;
  const _listadoPedido({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: value.selectedProducts.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(value.selectedProducts[i].name!),
            subtitle: Text(
                '${value.selectedProducts[i].quantity} x ${value.selectedProducts[i].price} €'),
            trailing: Text(
                '${(double.parse(value.selectedProducts[i].price!) * value.selectedProducts[i].quantity!).toStringAsFixed(2)}€'),
          ),
        );
      },
    );
  }
}

Widget _btnEditarPerfil(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width * 0.60,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
      child: const Text(
        'Editar perfil',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget _btnConfirmarCompra(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width * 0.60,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
      child: const Text(
        'REALIZAR COMPRA',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
