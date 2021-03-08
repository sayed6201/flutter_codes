=============================================================================================
Named Route defining
=============================================================================================
import 'package:flutter/material.dart';

import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      //if routing fails it will display this routes
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
        return;
      },
      //if routing fails it will display this routes at the end
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
    );
  }
}


---------------- named Route Navigation------------------------

// Pushing a named route
Navigator.of(context).pushNamed(
  '/second',
  arguments: 'Hello there from the first page!',
);

----------------------------------------------------------------
Navigator.of(context).pushNamed(
                                TourSearchViewScreen.tag,
                                arguments: {
                                  'location': _selectedCity,
                                  'startDate': _startDate,
                                  'endDate': _endDate
                                }
                              );

=============================================================================================
Retrieving Data in Screen
=============================================================================================

final productId =
        ModalRoute.of(context).settings.arguments as String; 


        routeData =
      ModalRoute.of(context).settings.arguments as Map<String, String>;
      print(routeData['startDate']);