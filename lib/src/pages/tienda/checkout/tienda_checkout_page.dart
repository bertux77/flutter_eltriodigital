import 'package:eltriodigital_flutter/src/pages/tienda/checkout/tienda_checkout_controller.dart';
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
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _resumenPedidoTotal(value),
                    _metodosDePago(),
                    con.radioValue.value != 1
                        ? _direccionEntrega()
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    con.tieneDireccion == true
                        ? _btnConfirmarCompra(context)
                        : _btnEditarPerfil(context)
                  ],
                ),
              ),
            ));
            
  }
Widget _btnConfirmarCompra(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width * 0.60,
    child: ElevatedButton(
      onPressed: () => con.confirmarCompra(),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
      child: const Text(
        'REALIZAR COMPRA',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
  Widget _resumenPedidoTotal(TiendaCheckoutController value) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Resumen Pedido',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'TOTAL: ${value.total}€',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Divider(
          indent: 15, // donde empieza la linea
          endIndent: 15, // donde acaba la linea
          thickness: 2.0, // Grosor de la linea
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _metodosDePago() {
    return Column(
      children: [
        const Text('Elegir metodo de pago'),
        //SizedBox(height: 10,),
        ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          itemBuilder: (_, index) {
            return _radioSelectorAddress(con.metodosDePago[index], index);
            //return Text('mandanga');
          },
        ),
        _txtCondicionalMetodosPago(),
        Divider(
          color: Colors.grey[400],
        )
      ],
    );
  }

  Widget _txtCondicionalMetodosPago() {
    switch (con.radioValue.value) {
      case 0:
        return const Text('Insertamos el plugin para la tarjeta');
      case 1:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Una vez completado el pedido podras pasar a recogerlo por la tienda',
            style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
          ),
        );
      case 2:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Haz el pago directamente a nuestra cuenta bancaria. Indica tu nombre y apellidos en las observaciones de la transferencia: ES66 0081 0541 7900 0150 6160',
            style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
          ),
        );
      case 3:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Realizar el pago directamente al transportista cuando te entreguen el pedido',
            style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
          ),
        );
      default:
        return const Text('');
    }
  }

  Widget _radioSelectorAddress(MetodosDePago metodo, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio<int>(
                value: index,
                groupValue: con.radioValue.value,
                onChanged: con.handleRadioValueChange,
              ),
              Text(
                metodo.name ?? '',
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // Divider(
          //   color: Colors.grey[400],
          // )
        ],
      ),
    );
  }

  Widget _direccionEntrega() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
        ),
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


