import 'dart:convert';

import 'package:crowdv/screens/home/home_history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/vol_list_screen.dart';
import 'package:crowdv/screens/notification_view.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/text_style.dart';
import 'package:crowdv/widgets/home_widget_loder.dart';
import 'package:provider/provider.dart';

import '../../api_url.dart';
import '../../color_file.dart';
import '../../string.dart';
import '../recruiter_opportunity_pending_list.dart';
import 'package:http/http.dart' as http;



class NotificationSceen extends StatefulWidget {
  static final String tag = "NotificationSceen";

  NotificationSceen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationSceenState();
}

class _NotificationSceenState extends State<NotificationSceen> {
  var _isInit = true;
  var _isLoading = true;
  var catagory_text = "Notifications";
  List<dynamic> notificationList = [];
  List<dynamic> specNotificationList = [];
  var isBtnSelected = 0;
  int totalUnreadNotification = 0;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      print("isloading $_isLoading");

      if(Provider.of<AuthProvider>(context).getUserRoleID != GUEST_ROLE_ID ){
        await Provider.of<AuthProvider>(context,listen: false).fetchGeneralNotification();
//        Provider.of<AuthProvider>(context,listen: false).updateSingleUnreadNotification();
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
  Widget build(BuildContext context) {
    notificationList = Provider.of<AuthProvider>(context).getGeneralNotofication;
    totalUnreadNotification = Provider.of<AuthProvider>(context).getTotalUnreadNotification;
    
    print("gen-notificationList-length-ui:  ${notificationList.length}");
    print("unread notification:  ${totalUnreadNotification}");
    
    return
//      (Provider.of<AuthProvider>(context).getUserRoleID != VOLUNTEER_ROLE_ID ||
//          Provider.of<AuthProvider>(context).getUserRoleID != REQRUITER_ROLE_ID ) ?
//      HomeWidgetLoader()
//      :
      Scaffold(
//        floatingActionButton: FloatingActionButton(
//          onPressed: ()async{
//            callOnFcmApiSendPushNotifications(
//              title: "from device",
//              body: "body",
//              userToken: ["fX8VYAhNv4g:APA91bHEgE9altfRey8rzr8k2h8O7eJIH42rsr8P67h5UIo9xp7OXsIyzh6_tShEI427wv9KBNqgzimoJCP8S_499e8kGVLM4eR26Q9lRLBfyYsi5FxWriQngK72d23_TRqyg4tJ1tCB"]
//            );
//          },
//        ),
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [
          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: SizeConfig.blockSizeVertical * 15,
              left: 5,
              right: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 5),
                      height: SizeConfig.blockSizeVertical * 82,
                      child:
                      _isLoading ?
                      Center(
                        child: CircularProgressIndicator(),)
                          :
                      ListView.builder(
                        padding: EdgeInsets.only(
                          top:SizeConfig.blockSizeVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 3,
                          bottom: SizeConfig.blockSizeHorizontal * 15,
                        ),
                        itemCount:notificationList.length,
                        itemBuilder: (ctx, i) =>
                            InkWell(
                              onTap: () async{

                                Provider.of<AuthProvider>(context,listen: false).updateSingleUnreadNotification(
                                  id: notificationList[i]["id"].toString()
                                );

                                if(Provider.of<AuthProvider>(context, listen: false).getUserRoleID == REQRUITER_ROLE_ID){
                                  Navigator.of(context).pushNamed(
                                      RecruiterOpportunityPendingList.tag
                                  );
                                }

                                if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == VOLUNTEER_ROLE_ID){
                                  Navigator.of(context).pushNamed(
                                      HistoryScreen.tag
                                  );
                                }

                              },
                              child: Container(
                                padding: EdgeInsets.all(0),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1,
                                    right: SizeConfig.blockSizeHorizontal * 1,
                                    top: SizeConfig.blockSizeVertical * 1,
                                    bottom: SizeConfig.blockSizeVertical * 1),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        padding: EdgeInsets.all(0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 50,
                                              width: 5,
                                              color: primaryColor,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 15,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.purple,
                                                  width: 2,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(10),
                                              child: Icon(FontAwesomeIcons.bell,color: primaryColor,),
                                            ),
                                            Expanded(
                                              child: Column(
                                                  children : <Widget>[ Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 10,right: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child: Text(
                                                                     "Title: "+notificationList[i]["title"],
                                                                      style: TextStyle(
                                                                          fontSize: SizeConfig.blockSizeVertical * 1.8,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: Colors.black38
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if(notificationList[i]["is_viewed"] == "1")
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                                    decoration: BoxDecoration(
                                                                      color:Colors.blue,
                                                                      border: Border.all(color: Colors.blue),
                                                                      borderRadius: BorderRadius.circular(100),
                                                                    ),
                                                                    child:
                                                                    Icon(Icons.notifications_active, color: Colors.white,),)
                                                                ],
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Divider(color: Colors.black38,),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child: Column(
                                                                      children: <Widget>[

                                                                        Provider.of<AuthProvider>(context).getUserRoleID != VOLUNTEER_ROLE_ID ?

                                                                        Text("Name: "+notificationList[i]["volunteer_name"] ?? "N/A",
                                                                            textAlign: TextAlign.left,
                                                                            style: TextStyle(
                                                                              color: Colors.black38,
                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                            )) :
                                                                        Text("",
                                                                            textAlign: TextAlign.left,
                                                                            style: TextStyle(
                                                                              color: Colors.black38,
                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                            )),
                                                                        SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                                        Text("Address: Djanmondi 32",
//                                                                            textAlign: TextAlign.left,
//                                                                            style: TextStyle(
//                                                                              color: Colors.black38,
//                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                            )),
//                                                                        Text("Opportunity title: do job 123",
//                                                                            textAlign: TextAlign.left,
//                                                                            style: TextStyle(
//                                                                              color: Colors.black38,
//                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                            )),
                                                                      ],
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    ),
                                                                  ),
//                                                                  Container(
//                                                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                    margin: EdgeInsets.only(top: 5),
//                                                                    decoration: BoxDecoration(
//                                                                      color:primaryColor,
//                                                                      border: Border.all(color: primaryColor),
//                                                                      borderRadius: BorderRadius.circular(100),
//                                                                    ),
//                                                                    child: Text("Fee: 1200 tk",
//                                                                        style: TextStyle(
//                                                                          color: Colors.white,
//                                                                          fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                        )),
//                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
//                                                    Align(
//                                                      alignment: Alignment.centerRight,
//                                                      child: Padding(
//                                                          padding: EdgeInsets.only(bottom: 0, right: 5),
//                                                          child: Row(
//                                                            mainAxisAlignment: MainAxisAlignment.end,
//                                                            children: <Widget>[
//                                                              IconButton(
//                                                                onPressed: () {
//                                                                },
//                                                                color: Theme.of(context)
//                                                                    .primaryColor,
//                                                                icon: Icon(Icons.chat),
//                                                              ),
//                                                              IconButton(
//                                                                onPressed: () {
//                                                                },
//                                                                color: Colors.red,
//                                                                icon: Icon(Icons.call),
//                                                              ),
//                                                              IconButton(
//                                                                onPressed: () {
//                                                                },
//                                                                color: Theme.of(context)
//                                                                    .primaryColor,
//                                                                icon: Icon(Icons.share),
//                                                              ),
//                                                            ],
//                                                          )),
//                                                    )
                                                  ]
                                              ),
                                            )
                                          ],
                                        )
                                    )),
                              ),
                            )
                      )
                  ),
                ],
              )),
          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: SizeConfig.blockSizeVertical * 17,
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        catagory_text,
                        style: heading_style.copyWith(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                        ),
                      )
                    ),
//                  Divider(),
//                    buildButton(),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          catagory_text,
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

  Widget buildButton() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.bold,
        color: Theme
            .of(context)
            .primaryColor);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async{
                setState(() {
                  isBtnSelected = 0;
//                  _isLoading = true;
                });
//                await Provider.of<AuthProvider>(context,listen: false).fetchGeneralNotification();
//                setState(() {
//                  _isLoading = false;
//                });
              },
              child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isBtnSelected == 0
                            ? Colors.white
                            : Theme
                            .of(context)
                            .primaryColor,
                        width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: isBtnSelected == 0
                        ? Theme
                        .of(context)
                        .primaryColor
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.male,
//                        color: isBtnSelected == 0
//                            ? Colors.white
//                            : Theme
//                            .of(context)
//                            .primaryColor,
//                        size: SizeConfig.blockSizeHorizontal * 7,
//                      ),
//                      SizedBox(
//                        height: SizeConfig.blockSizeVertical * 1,
//                      ),
                      Flexible(
                        child: Text(
                          "Requests",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: isBtnSelected == 0
                              ? selectedTextColor
                              : unSelectedTextColor,
                        ),
                      )
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () async{
                setState(() {
                  isBtnSelected = 1;
//                  _isLoading = true;
                });
//                await Provider.of<AuthProvider>(context,listen: false).fetchSpecificNotification();
//                setState(() {
//                  _isLoading = false;
//                });
              },
              child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isBtnSelected == 1
                            ? Colors.white
                            : Theme
                            .of(context)
                            .primaryColor,
                        width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: isBtnSelected == 1
                        ? Theme
                        .of(context)
                        .primaryColor
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.female,
//                        color: isBtnSelected == 1
//                            ? Colors.white
//                            : Theme
//                            .of(context)
//                            .primaryColor,
//                        size: SizeConfig.blockSizeHorizontal * 7,
//                      ),
//                      SizedBox(
//                        height: SizeConfig.blockSizeVertical * 1,
//                      ),
                      Flexible(
                        child: Text(
                          "Other Notifications",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: isBtnSelected == 1
                              ? selectedTextColor
                              : unSelectedTextColor,
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ],
    );
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

  Future<bool> callOnFcmApiSendPushNotifications({
    @required List <String> userToken,
    @required String title,
    @required String body
  }) async {

    print("calling");
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids" : userToken,
      "collapse_key" : "type_a",
      "notification" : {
        "title": title,
        "body" : body,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': "Bearer "+SERVER_KEY_FCM // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM - response - ${response.body.toString()}');
      return true;
    } else {
      print(' CFM error -${response.statusCode} - ${response.body.toString()}');
      // on failure do sth
      return false;
    }
  }

}

