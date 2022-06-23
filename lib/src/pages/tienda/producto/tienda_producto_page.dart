import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/producto/tienda_producto_controller.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/tienda_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

class TiendaProductoPage extends StatelessWidget {
  TiendaProductoController con = Get.put(TiendaProductoController());
//Product? product = Product();
  //late ClientProductsDetailController con;
  var counter = 0.obs;
  var price = 0.0.obs;

  // ClientProductsDetailPage({required this.product}) {
  //   con = Get.put(ClientProductsDetailController());
  // }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        future: con.obtenerProducto(),
        builder: (context, AsyncSnapshot snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.only(top: 20),
              child: const Center(child: CircularProgressIndicator()),
            );
          } else {
            Producto product = snapshot.data;
            return Scaffold(
                bottomNavigationBar:
                    Container(height: 100, child: _buttonsAddToBag()),
                body: Column(
                  children: [
                    _imageSlideshow(context),
                    _textNameProduct(product),
                    _textDescriptionProduct(product),
                    _textPriceProduct(product),
                  ],
                ));
            
          }});
        } 
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

  Widget _textDescriptionProduct(Producto product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product.description ?? '',
       
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textPriceProduct(Producto product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        //'${product!.price.toString()} €',
        '35.95 €',
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(
          height: 1,
          color: Colors.grey[400],
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Row(
            children: [
              ElevatedButton(
               // onPressed: () => con.removeItem(product!, price, counter),
                onPressed: () => {},
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
                  //'${counter.value}',
                  '0',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, minimumSize: const Size(40, 37)),
              ),
              ElevatedButton(
                //onPressed: () => con.addItem(product!, price, counter),
                onPressed: () => {},
                child: const Text(
                  '+',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)))),
              ),
              Spacer(),
              ElevatedButton(
                //onPressed: () => con.addToBag(product!, price, counter),
                onPressed: () => {},
                child: Text(
                  //'AGREGAR ${price.value}€',
                  'Agregar',
                  style: TextStyle(color: Colors.black, fontSize: 14),
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
    );
  }

  Widget _imageSlideshow(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      initialPage: 0,
      indicatorColor: Colors.amber,
      indicatorBackgroundColor: Colors.grey,
      children: [
        FadeInImage(
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
          image: AssetImage('assets/img/no-image.png') as ImageProvider,
          //image: product!.image1 != null
          //    ? NetworkImage(product!.image1!)
          //    : const AssetImage('assets/img/no-image.png') as ImageProvider,
        ),
        FadeInImage(
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
          image: AssetImage('assets/img/no-image.png') as ImageProvider,
          // image: product!.image2 != null
          //     ? NetworkImage(product!.image2!)
          //     : const AssetImage('assets/img/no-image.png') as ImageProvider,
        ),
        FadeInImage(
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
          image: AssetImage('assets/img/no-image.png') as ImageProvider,
          // image: product!.image3 != null
          //     ? NetworkImage(product!.image3!)
          //     : const AssetImage('assets/img/no-image.png') as ImageProvider,
        )
      ],
    );
  }

