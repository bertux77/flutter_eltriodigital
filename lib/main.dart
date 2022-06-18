import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eltriodigital_flutter/src/pages/home/home_page.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page.dart';
import 'package:eltriodigital_flutter/src/pages/register/register_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/canjeo/tienda_pedidos_canjeo_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/detalle/tienda_pedidos_detalle_page.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/tienda_page.dart';
import 'package:eltriodigital_flutter/src/pages/utils/utils_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'src/models/user.dart';
import 'src/pages/login/login_page.dart';

// CONFIGURACION FIREBASE
class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        appId: '1:757087496576:android:1950b0686eb4a8351af965',
        apiKey: 'AIzaSyCJt2xNxd_lzGmsvD-SfbgQ8pO2pXzhxgA',
        projectId: 'com.example.eltriodigitalFlutter',
        messagingSenderId: '757087496576',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:757087496576:ios:5272ea9ef34d2f8f1af965',
        apiKey: 'AIzaSyCuBNxsnjJtbVntk7RmFegF1NSGEHxRgrs',
        projectId: 'com.example.eltriodigitalFlutter',
        messagingSenderId: '448618578101',
        iosBundleId: 'io.flutter.plugins.firebasecoreexample',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:757087496576:android:1950b0686eb4a8351af965',
        apiKey: 'AIzaSyDLAePXaHID0QfqtPsUVT6kP3YuryUESBs',
        projectId: 'com.example.eltriodigitalFlutter',
        messagingSenderId: '448618578101',
      );
    }
  }
}

//OBTENEMOS EL USUARIO DEL ESTORAGE
User userSession = User.fromJson(GetStorage().read('user') ?? {});

PendingDynamicLinkData? initialLink = null;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);

  // Get any initial links
  initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

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
    if (initialLink != null) {
      final Uri deepLink = initialLink!.link;
      // Example of using the dynamic link to push the user to a different screen
      Get.toNamed('/home');
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El trio digital',
      initialRoute: userSession.id != null ? '/home' : '/',
      //initialRoute: initialLink != null ? '/home' : '/scan',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/utils', page: () => const UtilsPage()),
        GetPage(name: '/perfil', page: () => PerfilPage()),
        GetPage(name: '/tienda', page: () => const TiendaPage()),
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
