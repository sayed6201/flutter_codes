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

