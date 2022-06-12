import 'dart:async';

import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page_controller.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            Divider(
              thickness: 2,
            ),
            _tituloUltimosPedidos(),
            _ultimosPedidos(context),
          ],
        ));
  }

  Widget _nombreUsuario() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
          return const Text(
            '0€',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          );
        } else {
          print(snapshot.data.data);
          return Text('${snapshot.data.data} €',
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold));
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
            return Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //itemCount: con.wallets.length,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (_, index) {
                    //final item = con.wallets[index];
                    final item = snapshot.data.data[index];

                    //FORMATEAMOS CADA FECHA
                    final dataBD = DateTime.parse(item['created_at']).toLocal();
                    var formatter = DateFormat('dd-MM-yyyy');
                    String data = formatter.format(dataBD);

                    return Card(
                      key: PageStorageKey(item['id']),
                      color: item['tipo'] == '1'
                          ? Colors.green[300]
                          : Colors.red[300],
                      elevation: 4,
                      child: ExpansionTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        maintainState: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(data.toString()),
                            const SizedBox(
                              width: 10,
                            ),
                            item['tipo'] == '1'
                                ? const Icon(Icons.add)
                                : const Icon(Icons.remove),
                            const SizedBox(
                              width: 10,
                            ),
                            item['tipo'] == '1'
                                ? Text(
                                    '${item['beneficio_compra'].toString()}'
                                    '€',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    '${item['canjeo_compra'].toString()}'
                                    '€',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('mandanga!');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('# ${item['id']}'),
                                Text(
                                  'Total: ${item['compra']['total_venta']} €',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: const [
                                    Text('ver pedido '),
                                    Icon(
                                      Icons.arrow_forward_sharp,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }
}
