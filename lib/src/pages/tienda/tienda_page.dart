import 'package:animate_icons/animate_icons.dart';
import 'package:eltriodigital_flutter/src/models/categoria.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/tienda_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

class TiendaPage extends StatelessWidget {
  TiendaPageController con = Get.put(TiendaPageController());
  MyAppBarController conAppBar = Get.put(MyAppBarController());
  late AnimateIconController controller;

  @override
  Widget build(BuildContext context) {
    controller = AnimateIconController();
    return FutureBuilder(
      future: con.obtenerCategorias(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: MyAppBar(title: 'Tienda'),
            bottomNavigationBar: MyBottomNavigationBar(),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          //print(con.listaCategorias.length);
          return Scaffold(
            appBar: MyAppBar(title: 'Tienda'),
            bottomNavigationBar: MyBottomNavigationBar(),
            body: DefaultTabController(
              length: con.listaCategorias.length,
              child: Scaffold(
                body: Column(
                  children: [
                    SafeArea(
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.green,
                        tabs: List.generate(
                            con.listaCategorias.length,
                            (index) => Tab(
                                  text: '${con.listaCategorias[index].name}',
                                )),
                      ),
                    ),
                    Expanded(
                        child: TabBarView(
                            children: List.generate(
                                con.listaCategorias.length,
                                (index) => FutureBuilder(
                                    future: con.getProduct(
                                        con.listaCategorias[index].id!),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.only(top: 20),
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      } else {
                                        if (snapshot.data.length == 0) {
                                          return NoDataWidget(
                                            text: 'No hay productos',
                                          );
                                        } else {
                                          return ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                  leading: CircleAvatar(
                                                    child: Image.network(
                                                        snapshot.data[index]
                                                            .images[0].src),
                                                  ),
                                                  title: GestureDetector(
                                                    onTap: () =>
                                                        con.goToProductoPage(
                                                            snapshot.data[index]
                                                          ),
                                                    child: Text(snapshot
                                                        .data[index].name),
                                                  ),
                                                  subtitle: Row(children: [
                                                    snapshot.data[index]
                                                                .onSale ==
                                                            true
                                                        ? Row(
                                                            children: [
                                                              snapshot.data[index]
                                                                          .regularPrice ==
                                                                      ''
                                                                  ? const Text('')
                                                                  : Text(
                                                                      '${snapshot.data[index].regularPrice} €',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        decoration:
                                                                            TextDecoration.lineThrough,
                                                                        decorationColor:
                                                                            Color(0xff000000),
                                                                        fontSize:
                                                                            14.0,
                                                                      ),
                                                                    ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              const Text(
                                                                'En oferta',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${snapshot.data[index].price} €',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            '${snapshot.data[index].price} €'),
                                                  ]),
                                                  trailing: AnimateIcons(
                                                    startIcon: Icons
                                                        .shopping_cart_checkout,
                                                    endIcon:
                                                        Icons.add_shopping_cart,
                                                    size: 24.0,
                                                    controller: controller,
                                                    // add this tooltip for the start icon
                                                    startTooltip:
                                                        'Icons.add_circle',
                                                    // add this tooltip for the end icon
                                                    endTooltip:
                                                        'Icons.add_circle_outline',
                                                    // onStartIconPress: () {
                                                    //   conAppBar
                                                    //       .addProductoCarrito(
                                                    //           snapshot
                                                    //               .data[index]);
                                                    //   return true;
                                                    // },
                                                    onStartIconPress: () {
                                                      print(
                                                          "Clicked on Close Icon");
                                                      return true;
                                                    },
                                                    onEndIconPress: () {
                                                      print(
                                                          "Clicked on Close Icon");
                                                      return true;
                                                    },
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    startIconColor:
                                                        Colors.deepPurple,
                                                    endIconColor:
                                                        Colors.deepOrange,
                                                    clockwise: false,
                                                  ));
                                            },
                                          );
                                        }
                                      }
                                    }))))
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Buscar producto',
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              fillColor: Colors.white,
              filled: true,
              hintStyle: const TextStyle(fontSize: 17, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.all(15)),
        ),
      ),
    );
  }

  // Widget _cardProduct(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(top: 15, left: 20, right: 20),
  //           child: ListTile(
  //             title: Text('product.name ?? ' ''),
  //             subtitle: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   'product.description ?? ' '',
  //                   maxLines: 2,
  //                   style: const TextStyle(fontSize: 13),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 Text(
  //                   'product.price',
  //                   style: TextStyle(
  //                       color: Colors.black, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //               ],
  //             ),
  //             trailing: Container(
  //               height: 70,
  //               width: 60,
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(15),
  //                 child: FadeInImage(
  //                   // image: product.image1 != null
  //                   //     ? NetworkImage(product.image1!)
  //                   //     : AssetImage('assets/img/no-image.png')
  //                   //         as ImageProvider,
  //                   image: AssetImage('assets/img/no-image.png'),
  //                   fit: BoxFit.cover,
  //                   fadeInDuration: Duration(milliseconds: 50),
  //                   placeholder: AssetImage('assets/img/no-image.png'),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Divider(
  //           height: 2,
  //           color: Colors.grey[400],
  //           indent: 35,
  //           endIndent: 35,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
