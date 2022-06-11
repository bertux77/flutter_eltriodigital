import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:eltriodigital_flutter/src/pages/home/home_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
   
  HomeController con = Get.put(HomeController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: const Center(
         child: Text('Home Page')
      ),
    );
  }
}