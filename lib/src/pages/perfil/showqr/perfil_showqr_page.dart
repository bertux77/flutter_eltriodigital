import 'package:eltriodigital_flutter/src/pages/perfil/showqr/perfil_showqr_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PerfilShowQrPage extends StatelessWidget {
  PerfilShowQrController con = Get.put(PerfilShowQrController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi QR',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mi Código QR',
              style: TextStyle(fontSize: 40),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: Text(
                  'Utiliza este codigo para obtener los descuentos y las ganancias en la tienda'),
            ),
            QrImage(
              data: con.user.id!,
              version: QrVersions.auto,
              size: 200.0,
            ),
            Text(con.user.id!)
          ],
        ),
      ),
    );
  }
}
