import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TiendaPedidosConfirmacionPage extends StatelessWidget {
   
  const TiendaPedidosConfirmacionPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Text('¡ENHORABUNEA!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                  ),
                  const Text('Tu compra se ha realizado correctamente'),
                  Lottie.asset(
                      'lotties/order-completed.json',
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover),
                ],
              ),
            ),
      ),
    );
  }
}