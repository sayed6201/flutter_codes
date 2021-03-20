/*
===========================================================================================
Converting map key and values to List
===========================================================================================
*/
//CartItem is widget--------------------------------

CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price,
              ),