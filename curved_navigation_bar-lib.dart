
/*
===========================================================================================
curved_navigation_bar library usage
===========================================================================================
*/
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  dynamic content;

  @override
  void initState() {
    setState(() {
      content = Page1(0,_bottomNavigationKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('1 Card', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepOrange,
          elevation: 20, ),
        drawer: _buildDrawer(context),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          color: Colors.red,
          backgroundColor: Colors.yellow,
          buttonBackgroundColor: Colors.green,
          
          items: <Widget>[

                Icon(Icons.add, size: 30),

                Icon(Icons.list, size: 30),

                Icon(Icons.compare_arrows, size: 30),

          ],
          onTap: (index) {

            if(index == 0){
              setState(() {
                _page = index;
                content = Page1(_page,_bottomNavigationKey);
              });
            }else if(index == 1){
              setState(() {
                _page = index;
                content = Page1(_page,_bottomNavigationKey);
              });
            }else if(index == 2){
              setState(() {
                _page = index;
                content = Page1(_page,_bottomNavigationKey);
              });
            }
          },
        ),
        body: content
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
                  Icon(
                    Icons.pregnant_woman,
                    size: 30,
                    color: Colors.white,
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
              
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: (){
            
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){
              
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
             
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Privacy'),
            onTap: (){
           
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

}

class Page1 extends StatelessWidget{

  int _page;
  GlobalKey _bottomNavigationKey;

  Page1(this._page, this._bottomNavigationKey);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Page: $_page", textScaleFactor: 5.0),
            RaisedButton(
              child: Text('Go To Page of index 1'),
              onPressed: () {
                //Page change using state does the same as clicking index 1 navigation button
                final CurvedNavigationBarState navBarState =
                    _bottomNavigationKey.currentState;
                navBarState.setPage(1);
              },
            )
          ],
        ),
      ),
    );
  }
  }

class Page2 extends StatelessWidget{

  int _page;
  GlobalKey _bottomNavigationKey;

  Page2(this._page, this._bottomNavigationKey);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Page: $_page", textScaleFactor: 5.0),
            RaisedButton(
              child: Text('Go To Page of index 1'),
              onPressed: () {
                //Page change using state does the same as clicking index 1 navigation button
                final CurvedNavigationBarState navBarState =
                    _bottomNavigationKey.currentState;
                navBarState.setPage(1);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget{

  int _page;
  GlobalKey _bottomNavigationKey;

  Page3(this._page, this._bottomNavigationKey);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Page: $_page", textScaleFactor: 5.0),
            RaisedButton(
              child: Text('Go To Page of index 1'),
              onPressed: () {
                //Page change using state does the same as clicking index 1 navigation button
                final CurvedNavigationBarState navBarState =
                    _bottomNavigationKey.currentState;
                navBarState.setPage(1);
              },
            )
          ],
        ),
      ),
    );
  }
}




