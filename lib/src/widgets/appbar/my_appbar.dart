import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget{
  
  MyAppBarController con = Get.put(MyAppBarController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
    centerTitle: true,
    title: const Text('Nutrición Canarias', style: TextStyle(color: Colors.white),),
    leading: IconButton(
      onPressed: () => con.goToHomePage(),
      icon: const Icon(Icons.home, color: Colors.white,),
    ),
    actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white,),
        ),
        IconButton(
          onPressed: () => con.signOut(),
          icon: const Icon(Icons.logout, color: Colors.white,),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}