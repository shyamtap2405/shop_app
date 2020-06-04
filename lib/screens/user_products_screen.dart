import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widget/app_drawer.dart';
import 'package:shop_app/widget/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
 static const routeName='/User-ProductScreen';
 
 Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts(true);
 }


 
  @override
  Widget build(BuildContext context) {
     //final productData= Provider.of<Products>(context);
    return Scaffold(appBar: AppBar(title: const Text('Your Products'),
    actions: <Widget>[
        IconButton(icon:const Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },)
    ],
    ),
    drawer: AppDrawer(),
    body: FutureBuilder(
      future: _refreshProducts(context),
      builder:(context,datasnapshot)=> 
      datasnapshot.connectionState==ConnectionState.waiting?
      Center(child: CircularProgressIndicator(),):
      RefreshIndicator(
        onRefresh:()=>_refreshProducts(context) ,
            child: Consumer(
                          builder:(ctx,productData,_)=>Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(itemBuilder:(ctx,index)=> Column(
          children: <Widget>[
              UserProductItem(productData.items[index].id,productData.items[index].title, productData.items[index].imageUrl),
              Divider(),
          ],
        ),
        itemCount: productData.items.length),
        ),
            ),
      ),
    ),
    );
  }
}