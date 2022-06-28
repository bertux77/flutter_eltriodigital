import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MetodosDePago{
    int? id;
    String? name;
    
      
    MetodosDePago({this.id, this.name});
      // can also add 'required' keyword
}

class TiendaCheckoutController extends GetxController {
  List<Producto> selectedProducts = <Producto>[].obs;
  var total = 0.0.obs;
  User userSession = User();
  bool tieneDireccion = false;
  var radioValue = 0.obs;

  List<MetodosDePago> metodosDePago = [
    MetodosDePago(id: 1, name: "Tarjeta"), // MUESTRA FORMULARIO Y CONFIRMAR VENTA
    MetodosDePago(id: 2, name: "Pagar al recoger en tienda"), // CONFIRMAR VENTA
    MetodosDePago(id: 3, name: "Transferencia Bancaria"), // MUESTRA DATOS Y CONFIRMAR VENTA
    MetodosDePago(id: 4, name: "Contrarembolso"), // CONFIRMAR VENTA
  ];


  TiendaCheckoutController() {
    //OBTENEMOS EL USUARIO DEL ESTORAGE
    userSession = User.fromJson(GetStorage().read('user') ?? {});
    _comprobarDireccion(userSession);
    //print('user session: ${userSession.toJson()}');

    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Producto>) {
        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
        // result.forEach(
        //     (element) => print('if: ${element.name} - ${element.quantity} '));
      } else {
        var result = Producto.fromJsonList(GetStorage().read('shopping_bag'));
        // result.forEach(
        //     (element) => print('else: ${element.name} - ${element.quantity} '));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      getTotal();
    }
  }

  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('Valor seleccionado ${value}');
    //GetStorage().write('address', address[value].toJson());
    update();
  }

  void _comprobarDireccion(User user) {
    if (user.cp != null &&
        user.direccion != null &&
        user.poblacion != null &&
        user.provincia != null &&
        user.telefono != null) {
      tieneDireccion = true;
    }
  }

  void getTotal() {
    total.value = 0.0;
    selectedProducts.forEach((product) {
      total.value = (total.value +
          (product.quantity! * double.parse(product.price ?? '')));
    });
  }

  void goToEditarPerfil() {
    Get.toNamed('perfil/editar');
  }
}
