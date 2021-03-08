
import 'package:crowdv/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../string.dart';

class HomeWidgetLoader extends StatefulWidget {
  @override
  _HomeWidgetLoaderState createState() => _HomeWidgetLoaderState();
}

class _HomeWidgetLoaderState extends State<HomeWidgetLoader> {


  Map<String, dynamic> data = {};
  @override
  Widget build(BuildContext context) {

    data = Provider.of<AuthProvider>(context).getdataNot;

    return Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
//              SizedBox(
//                  height: 100.0,
//                  child: Image.asset(
//                    LOGO,
//                    fit: BoxFit.contain,
//                  )),
//
//              SizedBox(height: 5,),
              SizedBox(
                  height: SizeConfig.blockSizeVertical * 20,
                  child: Image.asset(
                    ERROR,
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: 20,
              ),

              Text(
                '${data["text"] ?? ""}',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),

//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 40),
//                width: MediaQuery.of(context).size.width,
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 16.0),
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(5),
//                    ),
//                    onPressed: () {
//                      Navigator.of(context).pushNamedAndRemoveUntil(
//                          UserChooseScreen.tag, (Route<dynamic> route) => false);
//                    },
//                    padding: EdgeInsets.all(12),
//                    color: Theme.of(context).primaryColor,
//                    child: Text('Create account',
//                        style: TextStyle(color: Colors.white)),
//                  ),
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 40),
//                width: MediaQuery.of(context).size.width,
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 0.0),
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(5),
//                    ),
//                    onPressed: () {
//                      Navigator.of(context).pushNamedAndRemoveUntil(
//                          UserChooseScreen.tag, (Route<dynamic> route) => false);;
//                    },
//                    padding: EdgeInsets.all(12),
//                    color: Theme.of(context).primaryColor,
//                    child: Text('Log In', style: TextStyle(color: Colors.white)),
//                  ),
//                ),
//              ),
            ],
          ),
        ));
  }
}
