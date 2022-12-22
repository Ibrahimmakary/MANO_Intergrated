import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/product_model.dart';

import '../api_keys.dart';
import 'api_link.dart';

class ProductServices {
  Future< List<Product>> getNewProducts({required int storeId, required int userAddressId}) async {
    try {
      List<Product> productList = [];
      var headers = {
        'Authorization': apiToken,
        "StoreID": storeId.toString(),
        "UserAddressID": userAddressId.toString()
      };
      var request = http.Request('GET', Uri.parse(ApiLink.newProducts));
      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData["success"] == true &&
            responseData.containsKey("data") ) {
          print(responseData);
          for (var element in responseData["data"]["items"]) {
            print("yes");
            Product product = Product.fromJson(element);
            if (product.isUsable) {
              productList.add(product);
            }
          }
          return productList;
        } else {
          return productList;
        }
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return productList;
      }
    } catch (e, stack) {
      print({e, stack});
      return [];
    }
  }
}
