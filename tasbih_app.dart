import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(elevation: 20.5,color: Colors.green,brightness: Brightness.dark)
      ),
      home: MyHomePage(title: 'Flutter Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _reset(){
    setState(() {
      _counter = 0;
    });
  }

   void _decreement(BuildContext context){
    setState(() {
      if(_counter <= 0){
//        Fluttertoast.showToast(
//            msg: "Gu khaa Gunda",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIos: 1);
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Ghu kha Gunda"),
        ));
      }else{
        _counter --;
      }
      return null;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display3,
            ),
            RaisedButton(
              onPressed: _reset,
              child: Text(
                  "Reset",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurple,
            ),
        Builder(
          builder:(context)=> RaisedButton(
              onPressed: ()=>_decreement(context),
              child: Text(
                "Decrement",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
