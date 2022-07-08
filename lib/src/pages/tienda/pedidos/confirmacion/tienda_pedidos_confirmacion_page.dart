// ignore_for_file: unnecessary_string_escapes

import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TiendaPedidosConfirmacionPage extends StatelessWidget {
  const TiendaPedidosConfirmacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  '¡ENHORABUNEA!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const Text('Tu compra se ha realizado correctamente'),
              Center(
                child: Lottie.network(
                    'https://assets9.lottiefiles.com/packages/lf20_qckmbbyi.json',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
