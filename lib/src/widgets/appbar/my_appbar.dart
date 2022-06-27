import 'package:badges/badges.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  MyAppBarController con = Get.put(MyAppBarController());

  MyAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //con.selectedProducts.isNotEmpty ? showBadge = true : showBadge = false;
    //print('Selected productos en page: ${con.selectedProducts.length}');
    return FutureBuilder(
        future: con.cargarCarrito(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppBar(
              centerTitle: true,
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () => con.goToTiendaPage(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => con.goToCarritoPage(),
                  icon: const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => con.signOut(),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          } else {
            return AppBar(
              centerTitle: true,
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () => con.goToTiendaPage(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: [
                Badge(
                  showBadge: con.selectedProducts.isEmpty ? false : true,
                  toAnimate: true,
                  position: BadgePosition.topEnd(end: 1, top: 2),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text('${con.items}'),
                  child: IconButton(
                    onPressed: () => con.goToCarritoPage(),
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => con.signOut(),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }
        });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
