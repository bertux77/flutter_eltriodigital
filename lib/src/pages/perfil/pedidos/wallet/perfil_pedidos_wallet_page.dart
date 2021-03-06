import 'package:eltriodigital_flutter/src/models/wallet.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/pedidos/wallet/perfil_pedidos_wallet_controller.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/fecha_formateada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPedidosWalletPage extends StatelessWidget {
  PerfilPedidosWalletController con = Get.put(PerfilPedidosWalletController());
  UsersProvider usersProvider = UsersProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi Wallet',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => con.goToPerfilPage(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
        body: Column(
          children: [
            // _nombreUsuario(),
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
    return GestureDetector(
      onTap: () => con.goToPerfilInfoPage(),
      child: Container(
        padding: const EdgeInsets.only(top: 25, bottom: 0),
        child: const ListTile(
          leading: Icon(Icons.person),
          title: Text('Alberto Carrion'),
          trailing: Icon(Icons.edit),
        ),
      ),
    );
  }

  Widget _totalWallet(BuildContext context) {
    return FutureBuilder(
      future: usersProvider.totalWallet(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              '0???',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          //print(snapshot.data.data);
          return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text('${snapshot.data.data} ???',
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold)),
                Text('Totems')
              ],
            ),
          );
        }
      },
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
            return snapshot.data.data != null
                ? Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (_, index) {
                          final item = snapshot.data.data[index];

                          return GestureDetector(
                            onTap: () =>
                                con.goToPedidosPage(item['compra']['id']),
                            child: Card(
                              key: PageStorageKey(item['id']),
                              color: item['tipo'] == '1'
                                  ? Colors.green[300]
                                  : Colors.red[300],
                              elevation: 4,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      '???',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    item['tipo'] == '2'
                                        ? Text(
                                            'En esta compra has canjeado ${item['canjeo_compra'].toString()} ??? de tu wallet',
                                            style: TextStyle(fontSize: 12),
                                          )
                                        : Text(
                                            'En este pedido has acumulado ${item['beneficio_compra'].toString()} ??? en tu wallet',
                                            style: TextStyle(fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Container();
          }
        });
  }
}
