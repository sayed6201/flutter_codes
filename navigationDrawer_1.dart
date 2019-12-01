/*
===========================================================================================
(1)Navigation Drawer...
===========================================================================================
*/

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
  String title = 'Flutter App';

  @override
  Widget build(BuildContext context) {
    //MaterialApp() widget is the root widget, has many named param
    return MaterialApp(
      //Scaffold will create the page
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar( title: Text(title) ),
        body: ProductManager(startingProduct: 'Food tester',),
        drawer: _buildDrawer(context),
      )
    );
  }

  Drawer _buildDrawer(context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue
            ),
            padding: EdgeInsets.all(10.0),
            child:Container(
              child: Column(
                //verticle axis
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //Horizontal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/food.jpg',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  Text('Heelow',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ), ),
                  Text('Software Developer',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ), ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Photos'),
            onTap: (){
              setState(() {
                title = 'Photos';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: (){
              setState(() {
                title = 'Notification';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){
              setState(() {
                title = 'Settings';
              });
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.black45,
            indent: 16.0,
          ),
          ListTile(
            title: Text('About us'),
            onTap: (){
              setState(() {
                title = 'About us';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Privacy'),
            onTap: (){
              setState(() {
                title = 'Privacy';
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}