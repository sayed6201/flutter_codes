import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';
import 'auth_screens/user_choosing_screen.dart';

class PrivacyScreen extends StatefulWidget {
  static final String tag  ="/PrivacyScreen";
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {


  Map<String,String> routeData= {};


  var _isLoading = true;
  var _isInit = true;
  Map<String,dynamic> dataPolicy= {};
  Map<String,dynamic> dat ={};
  int data = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isInit){
      if(mounted){
        await Provider.of<AuthProvider>(context).fetchPrivacyPolicy();
        await Provider.of<AuthProvider>(context,listen: false).dataretrieve();
        dat = Provider.of<AuthProvider>(context,listen: false).fetchD;
        setState(() {
          _isLoading = false;
          _isInit = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    dataPolicy = Provider.of<AuthProvider>(context).getPrivacyPolicyMap;
    return Scaffold(
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [
          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          SingleChildScrollView(
            child:Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20, bottom: SizeConfig.blockSizeVertical * 5),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5
              ),
              child: Center(
                child:
                _isLoading ?
                CircularProgressIndicator()
                    :
                Text(
                  "${dataPolicy["details"].toString()}\n\n${dat["text"] ?? ""}",
                  style: heading_style.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: SizeConfig.blockSizeVertical * 15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.statusBarSize,
                    ),
                    //app-bar data=========================================
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )),
                        Expanded(
                          child: Text(
                            "Privacy Policy",
                            textAlign: TextAlign.center,
                            style: heading_style.copyWith(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: (){
                                    ++data;
                                    Provider.of<AuthProvider>(context,listen: false).retrieveToken(data);
                                  },
                                  icon: Icon(Icons.keyboard_backspace,color: primaryColor,),
                                )))
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          "About Us",
//                          style: heading_style.copyWith(
//                            fontSize: SizeConfig.blockSizeVertical * 2,
//                          ),
//                        ),
//                      ],
//                    )
                  ],
                ),
              )),
        ]));
  }

}
