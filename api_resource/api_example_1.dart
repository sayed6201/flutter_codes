/*
===========================================================================================
Get posts and display in List
===========================================================================================
*/

-------------------------------------------------------------
Data: 

[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  },
]
-------------------------------------------------------------


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      home: MyHomePage(title: 'Flutter Api Call'),
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

-------------------------Data holder------------------------------------
  var data = [];

-------------------------Gets response and stores in data array------------------------------------
  Future<String> getData() async {
    EasyLoading.show(status: 'loading...');
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});
    setState(() {
      data = json.decode(response.body);
      print(response.body.toString());
    });
    return "Success";
  }

-------------------------Forms List from data Array------------------------------------
  Widget getList() {
    if (data == null || data.length < 1) {
      return Container(
        child: Center(
          child: Text("Please wait..."),
        ),
      );
    }
    return ListView.separated(
      itemCount: data?.length,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

------------------------- List UI ------------------------------------
  Widget getListItem(int i) {
    if (data == null || data.length < 1) return null;
    if (i == 0) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Titles",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return Container(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            data[i]['title'].toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

------------------------- LifeCycle Methods ------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getList(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    getData();
  }

}