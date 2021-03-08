
import 'package:crowdv/color_file.dart';
import 'package:crowdv/screens/chat_screen.dart';
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

class HistoryScreen extends StatefulWidget {
  static final String tag = "HistoryScreen";
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  
  var _init = true;
  var _isLoading = true;
  List<dynamic> hiringHistory = [];


  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(_init){
      if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID) {
        await Provider.of<AuthProvider>(context).fetchRecruiterHiringHistory();
      }
      if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == VOLUNTEER_ROLE_ID) {
        await Provider.of<AuthProvider>(context).fetchVolHistory();
      }
      Provider.of<AuthProvider>(context,listen: false).fetchTotalUnreadNotification();
      Provider.of<AuthProvider>(context,listen: false).frchatnotification();
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

    hiringHistory = Provider.of<AuthProvider>(context).getRecHiringHistoryData;

    print("history iu llength ${hiringHistory.length}");

    return Scaffold(
//      appBar: AppBar(
//        title: Text("Reminder"),
//      ),
        body:
        Provider.of<AuthProvider>(context).getUserRoleID == GUEST_ROLE_ID ?
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
          hiringHistory.length < 1 ?
              NoData(
                text: "No Hiring History Found",
              ):
              Padding(
                padding: EdgeInsets.all(8),
                child:
                ListView.builder(
                    itemCount: hiringHistory.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index){
                      return
//                        (hiringHistory[index]["status"] == STATUS_UN_PAID &&
//                            Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID) ?
//                        null
//                            :
                        InkWell(
                          onTap: () async{

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
                                                'Title: '+hiringHistory[index]["title"],
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
                                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Volunteer Name: '+hiringHistory[index]["volunteer_name"],
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    if(Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Recruiter Name: '+hiringHistory[index]["recruiter_name"],
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Desription: '+hiringHistory[index]["description"],
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ) ,
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Occupation: ${hiringHistory[index]["occupation_name"] ?? "N/A"}",
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ) ,
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Institution: '+hiringHistory[index]["instituation_name"],
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ) ,
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
//                                    Align(
//                                      alignment: Alignment.centerLeft,
//                                      child: Text(
//                                        'Location: '+hiringHistory[index]["address"],
//                                        style: TextStyle(color: Colors.black38,),
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      height: SizeConfig.blockSizeVertical * 1,
//                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Phone: '+hiringHistory[index]["phone"],
                                        style: TextStyle(color: Colors.black38,),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.blue ,
                                        borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Text(
                                          'status: Ongoing',
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
//                                        'Date: '+hiringHistory[index]["date"],
                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: ()async{
                                            if(Provider.of<AuthProvider>(context, listen: false).getUserRoleID == REQRUITER_ROLE_ID)
                                              await Provider.of<AuthProvider>(context,listen: false).setOpportunityData(
                                                id: hiringHistory[index]["id"],
                                                vol_id: hiringHistory[index]["volunteers_id"],
                                                vol_name: hiringHistory[index]["volunteer_name"],
                                                rec_id: ""
                                            );

                                            if(Provider.of<AuthProvider>(context, listen: false).getUserRoleID == VOLUNTEER_ROLE_ID)
                                              await Provider.of<AuthProvider>(context,listen: false).setOpportunityData(
                                                id: hiringHistory[index]["id"],
                                                vol_id: hiringHistory[index]["recruiters_id"],
                                                vol_name: hiringHistory[index]["recruiter_name"],
                                                rec_id: ""
                                            );
                                            Navigator.of(context).pushNamed(
                                              ReviewScreen.tag
                                            );
                                          },
                                          icon: Icon(Icons.rate_review,color: Colors.blue,),
                                        ),
                                        IconButton(
                                          onPressed: () async{
//                                            if(Provider.of<AuthProvider>(context, listen: false).getUserRoleID == REQRUITER_ROLE_ID)
                                            await Provider.of<AuthProvider>(context,listen: false).setOpportunityData(
                                                id: hiringHistory[index]["id"],
                                                vol_id: hiringHistory[index]["volunteers_id"],
                                                rec_id: hiringHistory[index]["recruiters_id"],
                                                vol_name: hiringHistory[index]["volunteer_name"]
                                            );
                                            Navigator.of(context).pushNamed(ChatScreen.tag);
                                          },
                                          icon: Icon(Icons.chat_bubble, color: primaryColor,),
                                        )
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    }
                ),
              )
          )
        )
    );
  }
}

