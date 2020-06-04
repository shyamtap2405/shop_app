import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/splash_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(providers: [
      ChangeNotifierProvider(
         create: (_)=>Auth(),),
      ChangeNotifierProxyProvider<Auth,Products>(
        create: (_)=>Products(null,[],null),
         update: (_,auth,prod)=>Products(auth.token,prod==null? []:prod.items,auth.userId),
         ),
       ChangeNotifierProvider.value(
      value: Cart(),
       ),
       ChangeNotifierProxyProvider<Auth,Orders>(
         create: (ctx)=>Orders(null,[],null),
         update: (ctx,auth,order)=>Orders(auth.token, order==null?[]:order.orders,auth.userId),
       ),
       
       
       ],
   
        child:Consumer<Auth>(builder: (context,auth,child)=>MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange
        ),
        home: auth.isAuth? ProductsOverviewScreen():
        FutureBuilder(future: auth.tryAutoLogin(), 
        builder:(context,snapshot) => 
        snapshot.connectionState==ConnectionState.waiting?
        SplashScreen()
        : AuthScreen()),
        routes: {ProductDetailScreen.routeName: (ctx)=>ProductDetailScreen(),
        CartScreen.routeName:(ctx)=>CartScreen(),
        OrdersScreen.routeName:(ctx)=>OrdersScreen(),
        UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
        EditProductScreen.routeName:(ctx)=>EditProductScreen(),
        },
      ),)
         
    );
  }
}