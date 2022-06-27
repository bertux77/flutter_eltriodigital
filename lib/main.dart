import 'package:eltriodigital_flutter/src/pages/perfil/editar/perfil_editar_page.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/info/perfil_info_page.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/pedidos/perfil_pedidos_page.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/showqr/perfil_showqr_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/carrito/tienda_carrito_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/checkout/tienda_checkout_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/producto/tienda_producto_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eltriodigital_flutter/src/pages/home/home_page.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page.dart';
import 'package:eltriodigital_flutter/src/pages/register/register_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/canjeo/tienda_pedidos_canjeo_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/detalle/tienda_pedidos_detalle_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/tienda_page.dart';
import 'package:eltriodigital_flutter/src/pages/utils/utils_page.dart';

import 'src/models/user.dart';
import 'src/pages/login/login_page.dart';

//OBTENEMOS EL USUARIO DEL ESTORAGE
User userSession = User.fromJson(GetStorage().read('user') ?? {});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    print('main user: ${userSession.id}');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El trio digital',
      initialRoute: userSession.id != null ? '/tienda' : '/',
      //home: LoginPage(),
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/utils', page: () => const UtilsPage()),
        GetPage(name: '/perfil', page: () => PerfilPage()),
        GetPage(name: '/perfil/pedidos', page: () => PerfilPedidosPage()),
        GetPage(name: '/perfil/info', page: () => PerfilInfoPage()),
        GetPage(name: '/perfil/editar', page: () => PerfilEditarPage()),
        GetPage(name: '/perfil/showqr', page: () => PerfilShowQrPage()),
        GetPage(name: '/tienda', page: () => TiendaPage()),
        GetPage(name: '/tienda/carrito', page: () => TiendaCarritoPage()),
        GetPage(name: '/tienda/checkout', page: () => TiendaCheckoutPage()),
        GetPage(name: '/producto', page: () => TiendaProductoPage()),
        GetPage(name: '/canjeo', page: () => TiendaPedidosCanjeoPage()),
        GetPage(
            name: '/tienda/pedidos/detalle',
            page: () => TiendaPedidosDetallePage()),
      ],
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(23, 30, 77, 1),
          colorScheme: const ColorScheme(
              primary: Color.fromRGBO(23, 30, 77, 1),
              onPrimary: Color.fromRGBO(23, 30, 77, 1),
              secondary: Color.fromRGBO(29, 147, 209, 1),
              brightness: Brightness.light,
              onBackground: Colors.grey,
              surface: Colors.grey,
              onSurface: Colors.grey,
              error: Colors.grey,
              onError: Colors.grey,
              background: Colors.grey,
              onSecondary: Colors.grey)),
      navigatorKey: Get.key,
    );
  }
}
