import 'package:flutter/material.dart';
import 'package:playstore_clone_app/tabs/gametoptabs.dart';
import 'package:playstore_clone_app/tabs/hometoptabs.dart';
import 'package:playstore_clone_app/tabs/movietoptabs.dart';

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

Color PrimaryColor = Color(0xff109618);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: _GooglePlayAppBar(),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 6.0,
            onTap: (index){
              setState(() {
                switch (index){
                  case 0:
                    PrimaryColor = Color(0xffff5722);
                    break;
                  case 1:
                    PrimaryColor = Color(0xff3f51b5);
                    break;
                  case 2:
                    PrimaryColor = Color(0xffe91e63);
                    break;
                  case 3:
                    PrimaryColor = Color(0xff9c27b0);
                    break;
                  case 4:
                    PrimaryColor = Color(0xff2196f3);
                    break;
                }
              });
            },
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Games',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Movies',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Books',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Musics',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomeTopTabs(0xffff5722),
            GamesTopTabs(0xffff5722),
            MoviesTopTabs(0xffff5722),
            HomeTopTabs(0xffff5722),
            HomeTopTabs(0xffff5722),
          ],
        ),
      ),
    );
  }

  Widget _GooglePlayAppBar(){
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: IconButton(
                icon: Icon(Icons.menu), onPressed: null),
          ),
          Container(
            child: Text(
              'Google play',
              style: TextStyle(color: Colors.grey),
            )
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.mic),
              onPressed: null,
              color: Colors.blueGrey)
          ),
        ],

      ),
    );
}

}


