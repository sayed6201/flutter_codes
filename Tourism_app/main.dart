import 'package:flutter/material.dart';
import 'package:flutter_app/screens/location_detail.dart';
import 'package:flutter_app/screens/locations.dart';
import 'package:flutter_app/style.dart';


//defined const for Routing....
const locationsRoute = '/';
const LocationDetailRoute = '/location_detail';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    //onGenerateRoute generates Routes, then it can be used to nabigate from other widgets
      onGenerateRoute: _routes(),

      theme: _themeData(),
    );
  }

  RouteFactory _routes(){
    return (settings){

      //setting will be passed with data when list is clicked
      final Map<String, dynamic> arguments = settings.arguments;

      //screen will be returned on basis of click/passed data
      Widget screen;

      //it is derieved when clicked from: Navigator.pushNamed(context, LocationDetailRoute, arguments: {"id": locationId} );
      //settings.name = LocationDetailRoute = '/location_detail'
      switch(settings.name){

        case locationsRoute:
          screen = Locations();
          break;

        case LocationDetailRoute:
          //it is derieved when clicked from: Navigator.pushNamed(context, LocationDetailRoute, arguments: {"id": locationId} );
          screen = LocationDetail(arguments['id']);
          break;

        default:
          return null;
      }

      return MaterialPageRoute(builder: (BuildContext context) => screen );
    };
  }

  ThemeData _themeData(){
    return ThemeData(
        appBarTheme: AppBarTheme(textTheme: TextTheme(title: AppBarTextStyle )),
        textTheme: TextTheme(title: TitleTextStyle, body1: Body1TextStyle)
    );
  }
}

