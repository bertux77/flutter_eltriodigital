import 'package:eltriodigital_flutter/src/models/categoria.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/tienda_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

class TiendaPage extends StatelessWidget {
  TiendaPageController con = Get.put(TiendaPageController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: con.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else {
          //print(con.listaCategorias.length);
          return Scaffold(
            appBar: MyAppBar(),
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
                                              child: CircularProgressIndicator()),
                                        );
                                      } else {
                                        return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return ListTile(
                                              leading: CircleAvatar(
                                                child: Image.network(
                                                    snapshot.data[index]["images"]
                                                        [0]["src"]),
                                              ),
                                              title: Text(
                                                  snapshot.data[index]["name"]),
                                              subtitle: Text('${snapshot.data[index]["price"]} €'),
                                              trailing: Icon(Icons.shopping_cart_checkout_outlined),
                                            );
                                          },
                                        );
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

  Widget _cardProduct(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text('product.name ?? ' ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'product.description ?? ' '',
                    maxLines: 2,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'product.price',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              trailing: Container(
                height: 70,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    // image: product.image1 != null
                    //     ? NetworkImage(product.image1!)
                    //     : AssetImage('assets/img/no-image.png')
                    //         as ImageProvider,
                    image: AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 2,
            color: Colors.grey[400],
            indent: 35,
            endIndent: 35,
          )
        ],
      ),
    );
  }
}
