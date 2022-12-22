import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/product_provider.dart';
import 'package:untitled/screens/widgets/product_widget.dart';

class ProdcutListView extends StatefulWidget {
  const ProdcutListView({Key? key}) : super(key: key);

  @override
  State<ProdcutListView> createState() => _ProdcutListViewState();
}

class _ProdcutListViewState extends State<ProdcutListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.getNewProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of(context, listen: true);
    print(productProvider.productList.length);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Product List",
            style: TextStyle(color: Colors.black),
          )),
      body: productProvider.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 4,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: productProvider.productList.length,
              itemBuilder: (context, i) {
                return ProductWidget(
                  productModel: productProvider.productList[i],
                );
              },
            ),
    );
  }
}
