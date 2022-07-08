import 'package:get/get.dart';


class TiendaPedidosConfirmacionController extends GetxController{
  int ventaId = 0;
  int formaPago = 1;
  String messageConfirmacion = "En breve recibirá su pedido";
  //RespuestaPedido respuestaPedido = RespuestaPedido();
  Map<dynamic, dynamic> respuestaPedido = {};
  TiendaPedidosConfirmacionController(){
    //ventaId = Get.arguments['pedido'];
    respuestaPedido = Get.arguments['pedido'];
    ventaId = respuestaPedido['venta_id'];
    formaPago = respuestaPedido['forma_pago'];
   switch (formaPago) {
     case 1:  // Tarjeta
       messageConfirmacion = "En breve recibirá su pedido";
       break;
    case 2:  // Recoger en tienda
       messageConfirmacion = "Ya puede pasar a recoger su pedido por la tienda";
       break;
    case 3:  // Transferencia
       messageConfirmacion = "Tiene un plazo de 72 h para realizar el pago en el nº de cuenta: ES66 0081 0541 7900 0150 6160";
       break;
    case 4:  // ContraRembolso
       messageConfirmacion = "En breve recibirá su pedido y lo pagará cuando lo reciba";
       break;
     default:

      break;
   }
    
  }
}