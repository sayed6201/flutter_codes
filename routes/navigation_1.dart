/*
===========================================================================================
flutter remove back button on appbar
===========================================================================================
*/

Don't want to display that ugly back button ( :] ), and thus go for : AppBar(...,automaticallyImplyLeading: false,...);

Don't want the user to go back - replacing current view - and thus go for: Navigator.pushReplacementNamed(## your routename here ##);

Don't want the user to go back - replacing a certain view back in the stack - and thus use: Navigator.pushNamedAndRemoveUntil(## your routename here ##, f(Route<dynamic>)→bool); where f is a function returning truewhen meeting the last view you want to keep in the stack (right before the new one);

Don't want the user to go back - EVER - emptying completely the navigator stack with: Navigator.pushNamedAndRemoveUntil(context, ## your routename here ##, (_) => false);

/*
===========================================================================================
Navigation ways, best practices
===========================================================================================
*/

----------------without named Route------------------------
RaisedButton(
              child: Text('Go to second'),
              onPressed: () {
                // Pushing a route directly, WITHOUT using a named route
                Navigator.of(context).push(
                  // With MaterialPageRoute, you can pass data between pages,
                  // but if you have a more complex app, you will quickly get lost.
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondPage(data: 'Hello there from the first page!'),
                  ),
                );
              },
            )


----------------pushReplacement Route------------------------
        Navigator. pushReplacement(
          context,
            MaterialPageRoute(
              builder: (context) => TextEditor(desText,widget._file),
            ),
      );


---------------- named Route------------------------

// Pushing a named route
Navigator.of(context).pushNamed(
  '/second',
  arguments: 'Hello there from the first page!',
);
...

---------------- replace all named route------------------------
Navigator.of(context)
    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);


----------------RouteGenerator Class------------------------


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => FirstPage());
      case '/second':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SecondPage(
                  data: args,
                ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

----------------Home Class------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ...
      // Initially display FirstPage
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ...
            RaisedButton(
              child: Text('Go to second'),
              onPressed: () {
                // Pushing a named route
                Navigator.of(context).pushNamed(
                  '/second',
                  arguments: 'Hello there from the first page!',
                );
              },
            )
      ...
  }
}








/*
===========================================================================================
Navigatioin Result, Home Page
===========================================================================================
*/

import 'package:flutter/material.dart';
import 'package:navigation_app/page_1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

        //here Builder is required otherwise
        // exception was thrown: Navigator operation requested with a context that does not include a Navigator
        // or you can use different widget...
      home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("Home pAge"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Home Page',
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton (
              onPressed: () async {
                var navigationResult = await Navigator.push(context, new MaterialPageRoute(
                    builder: (context)=> Page1()
                ));

                if(navigationResult == 'from_fb'){
                  showDialog(context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Navigation from floating button'),
                    )
                  );
                }else if(navigationResult == 'from_appbar_back'){
                  showDialog(context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Navigation from appbar back button'),
                      )
                  );
                }else if(navigationResult == 'from_back_button'){
                  showDialog(context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Navigation from back button'),
                      )
                  );
                }

              },
              tooltip: 'move to Page 1',
              child: Icon(Icons.navigate_next),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          )
      )

      );
  }
}



/*
===========================================================================================
Navigatioin Result, Page 1
===========================================================================================
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //back button will not work, if you pass false in Future.value(false)
      onWillPop: () async{
//        Future.value(false)
      navigateToHome(context, 'from_back_button');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            navigateToHome(context, 'from_appbar_back');
          }),
          title: Text("page 1"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Page 1',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            navigateToHome(context,"from_fb");
          },
          tooltip: 'Move',
          child: Icon(Icons.arrow_back),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    );
  }

  void navigateToHome(context, result){
    Navigator.pop(context, result);
  }
}





/*
===========================================================================================
simple routes
===========================================================================================
*/

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}

//it is used to navigate
Navigator.of(context).pushNamed(HomePage.tag);






/*
===========================================================================================
proper routes.................
===========================================================================================
*/
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

