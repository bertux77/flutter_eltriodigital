import 'package:eltriodigital_flutter/src/pages/utils/utils_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilsPage extends StatelessWidget {
  UtilsController con = Get.put(UtilsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Utils',
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
        body: FutureBuilder(
            future: con.mandarFuture(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              // if (!snapshot.hasData) {
              //   return Text("No data from future");
              // }
              final data = snapshot.data;
              return Center(
                child: ElevatedButton(
                  onPressed: () => con.mandarFuture(),
                  child: Text('mandale'),
                ),
              );
            }));
  }
}
