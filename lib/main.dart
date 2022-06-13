import 'package:eltriodigital_flutter/src/pages/home/home_page.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page.dart';
import 'package:eltriodigital_flutter/src/pages/register/register_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/detalle/tienda_pedidos_controller_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/tienda_page.dart';
import 'package:eltriodigital_flutter/src/pages/utils/utils_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/models/user.dart';
import 'src/pages/login/login_page.dart';

//OBTENEMOS EL USUARIO DEL ESTORAGE
User userSession = User.fromJson(GetStorage().read('user') ?? {});
void main() async {
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
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El trio digital',
      initialRoute: userSession.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/utils', page: () => UtilsPage()),
        GetPage(name: '/perfil', page: () => PerfilPage()),
        GetPage(name: '/tienda', page: () => TiendaPage()),
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
