import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:eltriodigital_flutter/src/models/wallet.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilPageController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});
  UsersProvider usersProvider = UsersProvider();
  List<dynamic> wallets =  [];
  PerfilPageController() {
    cargarWallet();
  }

  void cargarWallet() async{
    ResponseApi responseApi = await usersProvider.cargarWallet();
    if(responseApi.success == true){
         wallets = responseApi.data;
         print(wallets.toString());
    }else{
      Get.snackbar('ERROR', responseApi.message ?? '');
    }
    
  }
}