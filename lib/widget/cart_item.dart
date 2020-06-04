import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;

   CartItem({
  this.id, 
  this.title, 
  this.productId,
  this.price, 
  this.quantity});
  @override
  Widget build(BuildContext context) {


    return Dismissible(
      key: ValueKey(id),
      background: Container(color: Theme.of(context).errorColor,
      child: Icon(Icons.delete,
      color:Colors.white,
      size: 40,),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
          return showDialog(context: context,builder: (context)=>AlertDialog(title: Text('Are you sure?'),
          content: Text('Do you want to remove the item from the cart?'),
          actions: <Widget>[
            FlatButton(child: Text('No'),onPressed: (){
              Navigator.of(context).pop(false);
            },),
            FlatButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: Text('Yes'))
          ],
          )
          );
      },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
          child: Card(margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 4),
        child: Padding(padding: EdgeInsets.all(8),
        child: ListTile(leading: Padding(
          padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: CircleAvatar(child: Text('\$$price'),
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text('\$${(price*quantity)}'),
        trailing: Text('$quantity x'),
        ),
        ),
      ),
    );
  }
}