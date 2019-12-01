import 'package:flutter/material.dart';
import 'package:flutter_test_app/product_manager.dart';

main()=>runApp(MyApp());

//MyApp extends StatelessWidget, now it can be used as a widget
//StatelessWidget can't change internal data
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

//it is required to create _MyAppState extends State<MyApp> while creating StatefulWidget
class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    //MaterialApp() widget is the root widget, has many named param
    return MaterialApp(

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),

      //Scaffold() will create the page
      home: Scaffold(
        appBar: AppBar( title: Text('Flutter App') ),
        body: ProductManager(startingProduct: 'Food tester'),
      )
    );
  }
}