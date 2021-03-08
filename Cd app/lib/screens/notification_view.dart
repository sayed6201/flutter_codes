
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/booking_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class NotificationViewScreen extends StatefulWidget {

  static final String tag = "NotificationViewScreen2";

  @override
  _NotificationViewScreenState createState() => _NotificationViewScreenState();
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {
  
  var _isInit = true;
  var _isLoading = true;
  var data = "";
  var header_text = "Notiication Detail";
  Map<String,dynamic> notificationData = {};

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {

      print("isloading $_isLoading");

      data = ModalRoute.of(context).settings.arguments as String;

      if(data == "0"){
        await Provider.of<AuthProvider>(context).notificationViewUpdateGeneral();
      }else{
        await Provider.of<AuthProvider>(context).notificationViewUpdateSpec();
      }
      _isInit = false;
      if(mounted){
        setState(() {
          _isLoading = false;
          print("isloading $_isLoading");
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    notificationData =  Provider.of<AuthProvider>(context).getNotificationData;

    print("doctorData-length-ui:  ${notificationData.toString()}");

    return Scaffold(
        body: Stack(children: [

          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: SizeConfig.blockSizeVertical * 25,
              left: 5,
              right: 5,
              child: Container(
                height: SizeConfig.blockSizeVertical * 64,
                child: ListView(
                  shrinkWrap: true,

                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 250,
                                          child: Wrap(
                                            children: <Widget>[
                                              Text(
                                                notificationData['title'] ??'N/A title',
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                                softWrap: true,
                                                overflow:
                                                TextOverflow
                                                    .fade,
                                              )
                                            ],
                                          ),
                                        ),
                                        notificationData["is_viewed"].toString().trim() == "0" ?
                                        Icon(Icons.notifications, color: Colors.grey,) :
                                        Icon(Icons.notifications_active, color: Colors.blue,)
                                      ],
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Detail: '+notificationData["des"] ?? "N/A",
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Date: ' + notificationData["created_at"],
                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),

          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: SizeConfig.blockSizeVertical * 20,
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
                            "",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight, child: Text(" ")))
                      ],
                    ),
//                    Divider(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.5,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          header_text,
                          style: heading_style.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ]),
    );
  }
}
