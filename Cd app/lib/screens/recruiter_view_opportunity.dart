import 'package:crowdv/screens/recruiter_create_opportunity.dart';
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

class ViewOpprtunityByRec extends StatefulWidget {

  static final String tag = "/ViewOpprtunityByRec";

  @override
  _ViewOpprtunityByRecState createState() => _ViewOpprtunityByRecState();
}

class _ViewOpprtunityByRecState extends State<ViewOpprtunityByRec> {
  var _isInit = true;
  var _isLoading = true;
  var _isLoadingAdded = false;
  var _isLoadingDelete = false;
  var header_text = "View Opportunity";
  List<dynamic> opportunityList = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      print("isloading $_isLoading");
      await Provider.of<AuthProvider>(context).fetchOpportunityLists();
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

    opportunityList =  Provider.of<AuthProvider>(context).getOpportunityLIst;


    return Scaffold(
      body: Stack(children: [

        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Wrap(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children : <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        "Available Opportunity",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black38
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color:Colors.blue,
                                                        border: Border.all(color: Colors.blue),
                                                        borderRadius: BorderRadius.circular(100),
                                                      ),
                                                      child: Icon(Icons.bookmark,
                                                        color: Colors.white,),)
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Divider(color: Colors.black38,),
                                                ),
                                                  _isLoading ?
                                                  Padding(
                                                    padding: EdgeInsets.all(14),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        CircularProgressIndicator(),
                                                        SizedBox(height: SizeConfig.blockSizeVertical * 1.2,),
                                                        Text("Fetching Data ...")
                                                      ],
                                                    ),
                                                  )
                                                      :
                                                (
                                                    opportunityList.length == 0 ?
                                                    Text("You have no opportunity",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
                                                    ) :
                                                    Wrap(
                                                      children: <Widget>[
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: opportunityList.length,
                                                            itemBuilder: (context,index){
                                                              return Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    margin: EdgeInsets.all(5),
                                                                    padding: EdgeInsets.all(10),
                                                                    child: (
                                                                        Column(
                                                                          children: <Widget>[
                                                                            Align(
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color:Colors.blue,
                                                                                  border: Border.all(color: Colors.blue),
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                                child:Text(
                                                                                  "title: "+opportunityList[index]["title"]?? "N/A",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                                              ),
                                                                              alignment: Alignment.topLeft,
                                                                            ),
                                                                            Align(
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    "Starting: "+opportunityList[index]["start_time"]?? "N/A",
                                                                                    style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  Text(
                                                                                    "Ending: "+opportunityList[index]["end_time"]?? "N/A",
                                                                                    style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ],
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                              ),
                                                                              alignment: Alignment.bottomRight,
                                                                            ),

                                                                          ],
                                                                        )
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                    color: Colors.black38,
                                                                    height: 2,
                                                                    thickness: 2,
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                        )
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]
                              ),
                            )),
                      )
                    ],
                  )
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
                          header_text,
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
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        header_text,
//                        style: heading_style.copyWith(
//                          fontSize: SizeConfig.blockSizeVertical * 2,
//                        ),
//                      ),
//                    ],
//                  )
                ],
              ),
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed(
              ReqruiterOpprtunityCreate.tag
          );
        },
      ),
    );
  }

  Future<void> deleteSchedule({@required id}) async{

    print("deleteSchedule called");
    try{
      setState(() {
        _isLoadingDelete = true;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Processing"),
          content: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Deleting schedule ...",
                      textAlign: TextAlign.center,),
                  )
                ],
              )
            ],
          ),
        ),
      );

      await Provider.of<AuthProvider>(context,listen: false).deleteExpertSchedule(
          scheduleID: id
      );

      await Provider.of<GuestProvider>(context,listen: false).fetchExpertSchedule(
          expertId: Provider.of<AuthProvider>(context,listen: false).getAData["id"].toString()
      );

      setState(() {
        _isLoadingDelete = false;
      });

      Navigator.of(context).pop();

    } catch(e){
      setState(() {
        _isLoadingDelete = false;
      });
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(msg[ERR_TITLE]),
          content: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 50.0,
                        child: Image.asset(
                          ERROR,
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(e.toString(),
                      textAlign: TextAlign.center,),
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

  }

}
