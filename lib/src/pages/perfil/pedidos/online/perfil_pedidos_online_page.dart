import 'package:eltriodigital_flutter/src/models/pedido.dart';
import 'package:eltriodigital_flutter/src/models/wallet.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/pedidos/online/perfil_pedidos_online_controller.dart';

import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/fecha_formateada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPedidosOnlinePage extends StatelessWidget {
  PerfilPedidosOnlineController con = Get.put(PerfilPedidosOnlineController());
  UsersProvider usersProvider = UsersProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mis pedidos',
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
            _ultimosPedidos(context),
          ],
        ));
  }

  Widget _ultimosPedidos(BuildContext context) {
    // final List<Pedido> pedidos;
    return FutureBuilder(
        future: usersProvider.listarPedidos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: const EdgeInsets.only(top: 20),
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
                            onTap: () => con.goToPedidosPage(item['id']),
                            child: Card(
                              key: PageStorageKey(item['id']),
                              color: Colors.green[300],
                              elevation: 4,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text('#${item['id']} - '),
                                        FechaFormateada(
                                          fecha: item['created_at'],
                                          textStyle: TextStyle(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Total: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${item['total_venta'].toString()}'
                                      '€',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Icon(Icons.navigate_next))
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
