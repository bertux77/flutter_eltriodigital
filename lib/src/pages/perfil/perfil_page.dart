import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PerfilPage extends StatelessWidget {
   
  PerfilPageController con = Get.put(PerfilPageController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Column(
        children: [
          _nombreUsuario(),
          _totalWallet(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Divider(
              thickness: 2,
              indent: 30,
              endIndent: 30,
            ),
          ),
          _ultimosPedidos(context),
        ],
      )
    );
  }
  Widget _nombreUsuario(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: const ListTile(
            leading: Icon(Icons.person),
            title: Text('Alberto Carrion'),
            trailing: Icon(Icons.edit),
          ),
    );
  }

  Widget _totalWallet(){
    return Container(
      child: const Text('24,95€', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
    );
  }

  Widget _ultimosPedidos(BuildContext context){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: con.wallets.length,
      itemBuilder: (_, index) {
        final item = con.wallets[index];
        print(item['tipo']);
        return Card(
          // this key is required to save and restore ExpansionTile expanded state
          key: PageStorageKey(item['id']),
          color: Theme.of(context).colorScheme.secondary,
          elevation: 4,
          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            expandedCrossAxisAlignment: CrossAxisAlignment.end,
            maintainState: true,
            //leading: Text('leading'),
            title: Text(DateFormat.yMMMd().format(item['created_at'])),
            subtitle: item['tipo'] == 1 
               ? Text(DateTime.parse(item['created_at']))
               : Text('acumula'), 
            
            children: [
              Text('Mandanga2'),
              // This button is used to remove this item
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                label: const Text(
                  'Remove',
                ),
                style: TextButton.styleFrom(primary: Colors.red),
              )
            ],
          ),
        );
    });
  }
}