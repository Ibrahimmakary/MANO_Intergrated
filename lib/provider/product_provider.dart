import 'package:flutter/foundation.dart';
import 'package:untitled/services/product_services.dart';

import '../model/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _services = ProductServices();
  int userAddressId =60877;
  int storeId =4 ;
  List<Product> productList = [];
  bool loading = true ;
  getNewProducts()async {
    productList =await  _services.getNewProducts(storeId: storeId, userAddressId: userAddressId);
    if(productList.isNotEmpty){
      print("ew");
      loading=false ;
      notifyListeners();
      return true ;
    }else{
      loading=false ;
      notifyListeners();
      return false ;
    }
  }

}
