/*
===========================================================================================
ENUM
----
used to convert text into number...
===========================================================================================
*/
import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
  });
}



/*
===========================================================================================
MAP
---
Updating & adding item..
adding item if doesn't exist..
===========================================================================================
*/

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

----------------------------------------------------------
  # updating and adding item inside Map
----------------------------------------------------------
  void addItem(
      String productId,
      double price,
      String title,
      ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
-----------------------------------------------------------
update MAP
-----------------------------------------------------------
 void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
          ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }




/*
===========================================================================================
Traversing map & filtering with condition
===========================================================================================
*/

Map<String, bool> _filters = { 
	'gluten': false, 
	'lactose': false, 
	'vegan': false, 
	'vegetarian': false, 
}; 
List<Meal> _availableMeals = DUMMY_MEALS; 
List<Meal> _favoriteMeals = []; 
 
void _setFilters(Map<String, bool> filterData) { 
setState(() { 
	_filters = filterData; 
	 
	_availableMeals = DUMMY_MEALS.where((meal) { 
		if (_filters['gluten'] && !meal.isGlutenFree) { 
			return false; 
		} 
		if (_filters['lactose'] && !meal.isLactoseFree) { 
			return false; 
		} 
		if (_filters['vegan'] && !meal.isVegan) { 
			return false; 
		} 
		if (_filters['vegetarian'] && !meal.isVegetarian) { 
			return false; 
		} 
			return true; 
	}).toList(); 
}); 
} 


  List<Meal> _favoriteMeals = [];

_favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );

filtering
-----------------------------------------------------------

          Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }