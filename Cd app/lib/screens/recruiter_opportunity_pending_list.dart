
import 'package:crowdv/screens/recruiter_approval_list.dart';
import 'package:crowdv/screens/review_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/payment_screen.dart';
import 'package:crowdv/screens/suggestion_view_screen.dart';
import 'package:crowdv/string.dart';
import 'package:crowdv/text_style.dart';
import 'package:crowdv/widgets/loader_widget.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:crowdv/widgets/home_widget_loder.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';

class RecruiterOpportunityPendingList extends StatefulWidget {
  static const String tag = "/RecruiterOpportunityPendingList";
  @override
  _RecruiterOpportunityPendingListState createState() => _RecruiterOpportunityPendingListState();
}

class _RecruiterOpportunityPendingListState extends State<RecruiterOpportunityPendingList> {

  var _init = true;
  var _isLoading = true;
  List<dynamic> opportunityPrndingList = [];
  var catagory_text = "Your Job Posts";


  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(_init){
      if(Provider.of<AuthProvider>(context).getUserRoleID != GUEST_ROLE_ID && Provider.of<AuthProvider>(context).getUserRoleID != VOLUNTEER_ROLE_ID) {
        await Provider.of<AuthProvider>(context).fetchRecruiterPendingOpportunityList();
      }
      _init = false;
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }

  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    opportunityPrndingList = Provider.of<AuthProvider>(context).getRecruiterPendingOpportunityList;

    print("history iu llength ${opportunityPrndingList.length}");

    return
      Scaffold(
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [
          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: SizeConfig.blockSizeVertical * 10,
              left: 5,
              right: 5,
              child: Provider.of<AuthProvider>(context).getUserRoleID == GUEST_ROLE_ID ?
              HomeWidgetLoader()
                  :
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child:
//          RefreshIndicator(
//            onRefresh: null,
//            child:

                  _isLoading ?
                  Center(
                      child: LoaderWidget(text: "Loading History",)
                  )
                      :
                  (
                      opportunityPrndingList.length < 1 ?
                      NoData(
                        text: "No Hiring Posts Found",
                      ):
                      Padding(
                        padding: EdgeInsets.all(8),
                        child:
                        ListView.builder(
                            itemCount: opportunityPrndingList.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index){
                              return
                                opportunityPrndingList[index]["volunteers_id"] != null  ?
                                Container()
                                    :
                                InkWell(
                                  onTap: () async{
                                    await Provider.of<AuthProvider>(context,listen: false).setOpportunityData(
                                      vol_name: "",
                                      rec_id: "",
                                      id: opportunityPrndingList[index]["id"],
                                      vol_id:opportunityPrndingList[index]["volunteers_id"]
                                    );
                                    Navigator.of(context).pushNamed(ApprovalScreen.tag);
                                  },
                                  child: Container(
                                    child: Card(
                                        elevation: 8,
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
                                                          'Title: '+opportunityPrndingList[index]["title"],
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
                                                  Icon(Icons.book, color: Colors.grey,),
                                                ],
                                              ),
                                              Divider(
                                                color: Theme.of(context).primaryColor,
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Desription: '+opportunityPrndingList[index]["description"],
                                                  style: TextStyle(color: Colors.black38,),
                                                ),
                                              ) ,

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Location: '+ "N/A",
                                                  style: TextStyle(color: Colors.black38,),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'ID: '+opportunityPrndingList[index]["id"],
                                                  style: TextStyle(color: Colors.black38,),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Colors.blue ,
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                  child: Text(
                                                    'status: Open for Hiring',
                                                    style: TextStyle(color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  "",
//                                                  'Date: '+opportunityPrndingList[index]["date"],
                                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                            }
                        ),
                      )
                  )
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
                            catagory_text,
                            textAlign: TextAlign.center,
                            style: heading_style.copyWith(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight, child: Text(" ")))
                      ],
                    ),
//                    Divider(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          catagory_text,
//                          style: heading_style.copyWith(
//                            fontSize: SizeConfig.blockSizeVertical * 2,
//                          ),
//                        ),
////                    Container(
////                      margin: EdgeInsets.only(
////                          top: SizeConfig.blockSizeVertical * 0.5),
////                      child: Icon(
////                        FontAwesomeIcons.search,
////                        color: Colors.white70,
////                      ),
////                    ),
//                      ],
//                    )
                  ],
                ),
              )),
        ]));
  }
}

