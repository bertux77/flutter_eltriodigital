import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/producto/tienda_producto_controller.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TiendaProductoPage extends StatelessWidget {
  TiendaProductoController con = Get.put(TiendaProductoController());
  //Producto? product = Producto();
  //late TiendaProductoController con;
  var counter = 1.obs;
  var price = 0.0.obs;
  // TiendaProductoPage() {
  //   con = Get.put(TiendaProductoController());
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiendaProductoController>(
        init: TiendaProductoController(),
        builder: (value) => Scaffold(
            bottomNavigationBar:
                Container(height: 100, child: _buttonsAddToBag(value.producto)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _imageSlideshow(context, value.producto),
                  _textNameProduct(value.producto),
                  _productoVariacion(value.producto),
                  _textPriceProduct(value.producto),
                  _textDescriptionProduct(value.producto),
                ],
              ),
            )));
  }

  Widget _textNameProduct(Producto product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product.name ?? '',
        //'Nombre del producto',
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
      ),
    );
  }

  Widget _productoVariacion(Producto product) {
    if (product.type == "variable") {
      return GetBuilder<TiendaProductoController>(
          init: TiendaProductoController(), // intialize with the Controller
          builder: (value) => Column(
              children: List.generate(
                  con.selectVariaciones.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Text(
                              '${con.selectVariaciones[index].name} : ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              hint: Text('${con.selectValue[index]}'),
                              elevation: 3,
                              items: con.selectVariaciones[index].options
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                con.cambiarVariaciones(value ?? '', index);
                                //print('index: ${index}');
                              },
                            ),
                            // DropdownButton<String>(
                            //   hint: Text("Seleccionar opción"),
                            //   value: con.selectValue.value,
                            //   isDense: true,
                            //   onChanged: (newValue) {
                            //     // setState(() {
                            //     //   currentSelectedValue = newValue;
                            //     // });
                            //     con.cambiarVariaciones(newValue ?? '');
                            //   },
                            //   items: con.selectVariaciones[index].options
                            //       .map((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            // ),
                            // DropdownButton<String>(
                            //   hint: Text('Selecciona una opción'),
                            //   elevation: 3,
                            //   //isExpanded: true,
                            //   items: con.selectVariaciones[index].options
                            //       .map((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(con.selectValue.value ? null : ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     //con.cambiarVariaciones(value ?? '');
                            //     print('value en pagina: $value');
                            //   },
                            // ),
                          ],
                        ),
                      ))));
    } else {
      return Container();
    }
  }

  Widget _textDescriptionProduct(Producto product) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: ExpandableText(
          product.description ?? '',
          expandText: 'Mostrar más',
          collapseText: 'ocultar',
          maxLines: 4,
          linkColor: Colors.blue,
        ));
  }

  Widget _textPriceProduct(Producto product) {
    if (product.onSale == true) {
      return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
        child: Row(
          children: [
            Text(
              '${product.regularPrice} €',
              style: const TextStyle(
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
                decorationColor: Color(0xff000000),
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'en oferta',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              ' ${product.price.toString()} €',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
        child: Text(
          '${product.price.toString()} €',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      );
    }
  }

  Widget _buttonsAddToBag(Producto product) {
    price.value = double.parse(product.price ?? '');
    return Obx(() => Column(
          children: [
            Divider(
              height: 1,
              color: Colors.grey[400],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => con.removeItem(product, price, counter),
                    child: const Text(
                      '-',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(45, 37),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25))),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '${counter.value}',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, minimumSize: const Size(40, 37)),
                  ),
                  ElevatedButton(
                    onPressed: () => con.addItem(product, price, counter),
                    child: const Text(
                      '+',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(45, 37),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25)))),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => con.addToBag(product, price, counter),
                    child: Text(
                      'AGREGAR ${price.value.toStringAsFixed(2)}€',
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _imageSlideshow(BuildContext context, Producto product) {
    return ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        initialPage: 0,
        indicatorColor: Colors.amber,
        indicatorBackgroundColor: Colors.grey,
        children: List.generate(
          product.images!.length,
          (index) => FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png'),
              image: NetworkImage(product.images![index].src!)
              //    : const AssetImage('assets/img/no-image.png') as ImageProvider,
              ),
        ));
  }
}
