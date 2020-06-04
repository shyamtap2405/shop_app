import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widget/app_drawer.dart';
import 'package:shop_app/widget/badge.dart';
import 'package:shop_app/widget/products_grid.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/providers/cart.dart';

 enum FilterOptions{
    Favorites,
    All
  }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites=false;
  var _isInit=true;
  var _isLoading =false;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies()  {
    if(_isInit){
      setState(() {
        _isLoading=true;
      });
      
        Provider.of<Products>(context).fetchAndSetProducts()
      .then((_){
       setState(() {
          _isLoading=false;
       });
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('My Shop'),
      actions: <Widget>[
        PopupMenuButton(icon: Icon(Icons.more_vert),
          onSelected: (selectedValue){
           setState(() {
              if(selectedValue==FilterOptions.Favorites){
              _showOnlyFavorites=true;
              
            }else{
            _showOnlyFavorites=false;
              
            }
           });

          },
          itemBuilder: (_)=>[
          PopupMenuItem(child: Text('Only Favorites'),value: FilterOptions.Favorites,),
          PopupMenuItem(child: Text('Show All'),value: FilterOptions.All,)
        ],
        ),
        Consumer<Cart>(builder: (_,cart,ch)=>
        Badge(child: ch,
        value: cart.itemCount.toString(),
        

        ),
        child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
          Navigator.of(context).pushNamed(CartScreen.routeName);
        }),
        ),
        
      ],
      ),
      drawer: AppDrawer(),
      body:_isLoading? Center(child: CircularProgressIndicator(),): ProductGrid(_showOnlyFavorites),

    );
  }
}

