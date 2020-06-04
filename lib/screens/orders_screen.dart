import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widget/app_drawer.dart';
import 'package:shop_app/widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName='/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Your Orders'),),
    drawer: AppDrawer(),
    body:FutureBuilder(future:Provider.of<Orders>(context,
      listen: false)
      .fetchAndSetOrders() ,builder: (context,dataSnapshot){
        if(dataSnapshot.connectionState==ConnectionState.waiting){
          return Center(child:CircularProgressIndicator());
        }else{ if(dataSnapshot.error!= null){
          return Center(child: Text('error occured!'),);
        }else{
          return Consumer<Orders>(builder: (context,orderData,child)=>ListView.builder(
            itemBuilder: (ctx,index)=>OrderItem(orderData.orders[index]),
            itemCount:orderData.orders.length,));
        }
        }
      } ,)
    
      
    );
  }
}