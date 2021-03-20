
=============================================================================================
DraggableScrollableSheet
=============================================================================================


import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {

  List<int> data = [
    10,9,8,7,6,5,4,3,2,1
  ];

  Widget _buildItemList(BuildContext context, int index){
    if(index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Container(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.yellow,
            width: 150,
            height: 200,
            child: Center(
              child: Text('${data[index]}',style: TextStyle(fontSize: 50.0,color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal list',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ScrollSnapList(
                  onItemFocus:(n){
                    print(n);
                  },
                  itemBuilder: _buildItemList,
                  itemSize: 150,
                  dynamicItemSize: true,
                  onReachEnd: (){
                    print('Done!');
                  },
                  itemCount: data.length,
                )
            ),
          ],
        ),
      ),
    );
  }
}

