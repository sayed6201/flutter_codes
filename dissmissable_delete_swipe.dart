=============================================================================================
Dissmissable: 
=============================================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price ;
  final int quantity;
  final String title;

  CartItem(@required this.id, @required this.productId, @required this.title, @required this.quantity, @required this.price);

  @override
  Widget build(BuildContext context) {
    /*
    Dismissable Widget to-----------------------------------------------------------------------------
    */
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white,),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(child: Text('Total: \$$price'),),
              ),),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
