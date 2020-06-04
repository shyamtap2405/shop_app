import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName='/Product-detail';
 // final String title;
  //ProductDetailScreen(this.title);
  @override
  Widget build(BuildContext context) {
    final productId= ModalRoute.of(context).settings.arguments as String;
    final productLoaded= Provider.of<Products>(context,listen: false).findById(productId);
    
    return Scaffold(appBar: AppBar(title: Text(productLoaded.title,
    ),
    ),
    body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(height: 300, 
          width: double.infinity,
          child: Image.network(productLoaded.imageUrl,fit: BoxFit.cover,),
          
          ),
          SizedBox(height: 10,),
          Text('\$${productLoaded.price}'
          ,style: TextStyle(color: Colors.grey,fontSize: 20),),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(productLoaded.description,textAlign: TextAlign.center,
            softWrap: true,),
          ),
        ],
      ),
    ),

      
    );
  }
}