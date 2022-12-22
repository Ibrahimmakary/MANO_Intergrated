import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/product_provider.dart';
import 'package:untitled/screens/product_list_view.dart';
import 'package:untitled/services/product_services.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider()),
  ], child: const MyApp()));
  ProductServices().getNewProducts(storeId: 4, userAddressId: 60877);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const ProdcutListView(),
    );
  }
}

