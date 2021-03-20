=============================================================================================
StatefulWidget........

Lifecycle method
=============================================================================================
import 'package:flutter/material.dart';
import 'package:flutter_app_text_converter/models/TextData.dart';
import 'package:sqflite/sqlite_api.dart';
import './helper/DatabaseHelper.dart';

class HistoryListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryListWidgetState();
}

class HistoryListWidgetState extends State<HistoryListWidget> {

//context cant be accessed--------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //through this a[[roach context can be accessed...............
//    Future.delayed(Duration.zero).then((_){
//      Provider.of<Products>(context).fetchProducts();
//    });
  }

//context cant be accessed--------------------------------------------
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isInit){
      Provider.of<Products>(context).fetchProducts();
    }
    _isInit = false;
  }

  
 }




=============================================================================================
Lifecycle methods
=============================================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.updateTitle}) : super(key: key);

  final String title;
  Function updateTitle;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  int _counter = 0;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState: first called");
    animationController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies: called after initstate & called whenever dependecies changes");
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(this.widget.title != oldWidget.title){
      print("didUpdateWidget: called whenever any configuration changes ofr this Widget");
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //if you don't dispose you may have memory leak
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.updateTitle,
        tooltip: 'Update title',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
