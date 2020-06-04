import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widget/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  ProductGrid(this.showFavs);
  

  @override
  Widget build(BuildContext context) {
    final productData= Provider.of<Products>(context);
    final products=showFavs? productData.favoritesItems:productData.items;
    return GridView.builder(itemCount: products.length,
    padding: EdgeInsets.all(10),
    itemBuilder: (ctx,index)=>ChangeNotifierProvider.value(
      value: products[index],
      child: ProductItem()
      ),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    mainAxisSpacing: 20,
    crossAxisSpacing: 20,
    childAspectRatio: 3/2),
    );
  }
}