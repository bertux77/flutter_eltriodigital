import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page_controller.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/fecha_formateada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/wallet.dart';

class PerfilPage extends StatelessWidget {
  PerfilPageController con = Get.put(PerfilPageController());
  UsersProvider usersProvider = UsersProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        bottomNavigationBar: MyBottomNavigationBar(),
        body: Column(
          children: [
            _nombreUsuario(),
            _totalWallet(context),
            const Divider(
              thickness: 2,
            ),
            _tituloUltimosPedidos(),
            _ultimosPedidos(context),
          ],
        ));
  }

  Widget _nombreUsuario() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: const ListTile(
        leading: Icon(Icons.person),
        title: Text('Alberto Carrion'),
        trailing: Icon(Icons.edit),
      ),
    );
  }

  Widget _totalWallet(BuildContext context) {
    return FutureBuilder(
      future: usersProvider.totalWallet(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                '0€',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              _btnScanCompra()
            ],
          );
        } else {
          //print(snapshot.data.data);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('${snapshot.data.data} €',
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  Text('Totems')
                ],
              ),
              _btnScanCompra()
            ],
          );
        }
      },
    );
  }

  Widget _btnScanCompra() {
    return Container(
      height: 50,
      padding: EdgeInsets.all(0),
      child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
          label: const Text(
            'Scan compra',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _tituloUltimosPedidos() {
    return Text('Ultimos movimientos');
  }

  Widget _ultimosPedidos(BuildContext context) {
    final List<Wallet> wallets;
    return FutureBuilder(
        future: usersProvider.cargarWallet(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.only(top: 20),
              child: const Center(child: CircularProgressIndicator()),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data.data[index];

                    return GestureDetector(
                      onTap: () => con.goToPedidosPage(item['compra']['id']),
                      child: Card(
                        key: PageStorageKey(item['id']),
                        color: item['tipo'] == '1'
                            ? Colors.green[300]
                            : Colors.red[300],
                        elevation: 4,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('#${item['compra']['id']} - '),
                                  FechaFormateada(
                                    fecha: item['created_at'],
                                    textStyle: TextStyle(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.add),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${item['beneficio_compra'].toString()}'
                                '€',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              item['tipo'] == '2'
                                  ? Text(
                                      'En esta compra has canjeado ${item['canjeo_compra'].toString()} € de tu wallet',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : Text(
                                      'En este pedido has acumulado ${item['beneficio_compra'].toString()} € en tu wallet',
                                      style: TextStyle(fontSize: 12))
                            ],
                          ),
                          // children: [
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('# ${item['id']}'),
                          //       Text(
                          //         'Total: ${item['compra']['total_venta']} €',
                          //         style: const TextStyle(
                          //             fontSize: 16, fontWeight: FontWeight.bold),
                          //       ),
                          //       GestureDetector(
                          //         onTap: () =>
                          //             con.goToPedidosPage(item['compra']['id']),
                          //         child: Row(
                          //           children: [
                          //             Text(item['compra']['id'].toString()),
                          //             Icon(
                          //               Icons.arrow_forward_sharp,
                          //               size: 14,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}
