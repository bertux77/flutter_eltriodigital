import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBarController con = Get.put(MyBottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        backgroundColor:Theme.of(context).colorScheme.primary, 
        items: const [
          TabItem(icon: Icons.tips_and_updates, title: 'Utils'),
         
          TabItem(icon: Icons.store, title: 'Tienda'),
         
          TabItem(icon: Icons.people, title: 'Perfil'),
        ],
        initialActiveIndex: con.indexTabAppBar.value,//optional, default as 0
        onTap: (int i) => con.changeTab(i),
        );
  }
}