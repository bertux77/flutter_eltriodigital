import 'package:eltriodigital_flutter/src/pages/tienda/tienda_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaPage extends StatelessWidget {
  TiendaPageController con = Get.put(TiendaPageController());
  
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Tienda NC'),
      ),
      body: FutureBuilder(
        future: con.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // Create a list of products
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child:
                        Image.network(snapshot.data[index]["images"][0]["src"]),
                  ),
                  title: Text(snapshot.data[index]["name"]),
                  subtitle:
                      Text("Buy now for \$ " + snapshot.data[index]["price"]),
                );
              },
            );
          }

          // Show a circular progress indicator while loading products
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  
  }
}