import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/languages.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/expert_suggestion_screen.dart';
import 'package:crowdv/screens/medicine_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/string.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';
import '../text_style.dart';

class SuggestionViewScreen extends StatefulWidget {
  static final String tag = "/SuggestionViewScreen";

  @override
  _SuggestionViewScreenState createState() => _SuggestionViewScreenState();
}

class _SuggestionViewScreenState extends State<SuggestionViewScreen> {
  var _isInit = true;
  var _isLoading = true;
  var header_text = "Fetching Expert Catagories...";
  List<dynamic> suggestionList = [];
  Map<String,dynamic> catagoryInfo = {};
  Map<String,dynamic> bookingHistoryIds = {};

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      print("isloading $_isLoading");
      await Provider.of<AuthProvider>(context,listen: false).fetchMemberSuggestionHistory();
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

    suggestionList = Provider.of<AuthProvider>(context).getSuggestionList;
    bookingHistoryIds = Provider.of<AuthProvider>(context).getSelectedBokingDataId;
    
    setState(() {
      header_text = "${suggestionList.length ?? ""} Suggestions found";
    });
    print("suggestionList-length-ui:  ${suggestionList.length}");

    print("bokind ids ${bookingHistoryIds.toString()}");

    return Scaffold(
      body: Stack(children: [
        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        Positioned(
            top: SizeConfig.blockSizeVertical * 10,
            left: 5,
            right: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5, bottom: SizeConfig.blockSizeVertical * 5),
                    height: SizeConfig.blockSizeVertical * 85,
                    child:
                    _isLoading ?
                    Center(
                      child: CircularProgressIndicator(),)
                        :
                    (
                        suggestionList.length < 1 ?
                        NoData(text: "No Suggestion Found",)
                            :
                        ListView.builder(
                          padding: EdgeInsets.only(
                            top:SizeConfig.blockSizeVertical * 1,
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                            bottom: SizeConfig.blockSizeHorizontal * 15,
                          ),
                          itemBuilder: (ctx,index){
                            return InkWell(
                              onTap: () async{
                                await Provider.of<AuthProvider>(context, listen: false)
                                    .setBookingCred(
                                    member_id: null,
                                    problem: null,
                                    bookin_id: null,
                                    suggestion_id: suggestionList[index]["id"]
                                );
                                Navigator.of(context).pushNamed(MedicineViewScreen.tag);
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
                                                vertical: 10,
                                                horizontal: 15,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.purple,
                                                  width: 2,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(10),
                                              child: Icon(FontAwesomeIcons.fileMedical),
                                            ),
                                            Expanded(
                                              child: Column(
                                                  children : <Widget>[
                                                    Row(
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
                                                                        "Expert name: "+suggestionList[index]["expert_name"] ?? "Name",
                                                                        style: TextStyle(
                                                                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.black38
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                                      decoration: BoxDecoration(
                                                                        color:Colors.blue,
                                                                        border: Border.all(color: Colors.blue),
                                                                        borderRadius: BorderRadius.circular(100),
                                                                      ),
                                                                      child: Text(
                                                                        "Booking ID: "+bookingHistoryIds["booking_id"] ?? "N/A",
                                                                        style: TextStyle(
                                                                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.white
                                                                        ),
                                                                      ),)
                                                                  ],
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(right: 10),
                                                                  child: Divider(color: Colors.black38,),
                                                                ),
                                                                Text("Category: "+suggestionList[index]["category_name"] ?? "bmdc_no",
                                                                    textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      color: Colors.black38,
                                                                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                    )),
                                                                SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                                                                Text("Expert Name: "+suggestionList[index]["expert_name"],
                                                                    textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      color: Colors.black38,
                                                                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                    )),
                                                                SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                                                                Text("Suggestion Detail: "+suggestionList[index]["suggestion_details"],
                                                                    textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      color: Colors.black38,
                                                                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                          padding: EdgeInsets.only(bottom: 0, right: 5),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
//                                                          IconButton(
//                                                            onPressed: () {
//                                                            },
//                                                            color: Theme.of(context)
//                                                                .primaryColor,
//                                                            icon: Icon(Icons.chat),
//                                                          ),
                                                              Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                                margin: EdgeInsets.only(top: 5, bottom: 10, right: 10),
                                                                decoration: BoxDecoration(
                                                                  color:primaryColor,
                                                                  border: Border.all(color: primaryColor),
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Text("View medicine",
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                    )),
                                                              ),
                                                            ],
                                                          )),
                                                    )
                                                  ]
                                              ),
                                            )
                                          ],
                                        )
                                    )),
                              ),
                            );
                          },
                          itemCount: suggestionList.length,
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

      floatingActionButton:
      Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID ?
      FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(
            ExpertSuggestionPostScreen.tag
          );
        },
        child: Icon(Icons.add),
      ):
          null
    );
  }
}
