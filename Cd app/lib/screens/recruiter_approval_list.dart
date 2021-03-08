import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class ApprovalScreen extends StatefulWidget {
  static final String tag = "ApprovalScreen";
  ApprovalScreen();
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {

  var _isInit = true;
  var _isLoading = true;
  var header_text = "Volunteer Application";
  List<dynamic> approvalList = [];
  Map<String,dynamic> catagoryInfo = {};

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      catagoryInfo =  Provider.of<AuthProvider>(context,listen: false).getSelectedOpportunityData;
      print("isloading $_isLoading");
      await Provider.of<AuthProvider>(context,listen: false).fetchApprovalList(
        oppurtunities_id: catagoryInfo["id"]
      );
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

    approvalList = Provider.of<AuthProvider>(context).getApprovalList;

    setState(() {
      header_text = "${approvalList.length ?? ""} Volunteer Applications found";
    });
    print("approvalList-length-ui:  ${approvalList.length}");

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
                        approvalList.length == 0 ?
                        NoData(text: "No Volunteer found for this category...",)
                            :
                        ListView.builder(
                          padding: EdgeInsets.only(
                            top:SizeConfig.blockSizeVertical * 1,
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                            bottom: SizeConfig.blockSizeHorizontal * 15,
                          ),
                          itemBuilder: (ctx,index){
                            return

                              InkWell(
                              onTap: () async{
//                              if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID != REQRUITER_ROLE_ID)
//                              Navigator.of(context).pushNamed(ReqruiterProfileScreen.tag);
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
                                              child: Icon(FontAwesomeIcons.joomla, color: primaryColor,),
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
                                                                      "Name: "+approvalList[index]["volunteer_name"]??"Sayed",
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
                                                                      "ID: "+approvalList[index]["id"]??"12",
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
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Text("Profession: ${approvalList[index]["occupation_name"] ?? "N/A"}",
                                                                            textAlign: TextAlign.left,
                                                                            style: TextStyle(
                                                                              color: Colors.black38,
                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                            )),
                                                                        SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                                        Text("NID: "+approvalList[index]["nid"],
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
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                                    margin: EdgeInsets.only(top: 5),
                                                                    decoration: BoxDecoration(
                                                                      color:primaryColor,
                                                                      border: Border.all(color: primaryColor),
                                                                      borderRadius: BorderRadius.circular(100),
                                                                    ),
                                                                    child: Text("Institute: ${approvalList[index]["instituation_name"] ?? "N/A"}",
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: SizeConfig.blockSizeVertical * 1.5,
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
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
                                                              RaisedButton(
                                                                onPressed: () async{
                                                                  try{
                                                                    showDialog(
                                                                      context: context,
                                                                      barrierDismissible: false,
                                                                      builder: (ctx) => AlertDialog(
                                                                        title: Text(msg[SUCCESS_TITLE]),
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
                                                                                      child: CircularProgressIndicator()),
                                                                                ),
                                                                                SizedBox(height: 20,),
                                                                                Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text("Approving Application",
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
//                                                                            Navigator.pushAndRemoveUntil(
//                                                                              context,
//                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
//                                                                              ModalRoute.withName(UserChooseScreen.tag),
//                                                                            );
                                                                            },
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                    await Provider.of<AuthProvider>(context,listen: false).apprroveApplication(
                                                                        oppurtunities_id: approvalList[index]["oppurtunities_id"],
                                                                        volunteers_id: approvalList[index]["volunteers_id"]
                                                                    );
                                                                    await Provider.of<AuthProvider>(context,listen: false).sendNotificationToVol(
                                                                      title: "Your application has been approved, visit history to see the detail",
                                                                      oppurtunities_id: approvalList[index]["oppurtunities_id"].toString(),
                                                                      volunteers_id: approvalList[index]["volunteers_id"].toString()
                                                                    );

                                                                    Navigator.of(context).pop();
                                                                    await showDialog(
                                                                      context: context,
                                                                      barrierDismissible: false,
                                                                      builder: (ctx) => AlertDialog(
                                                                        title: Text("Applicant Hired Successfully!"),
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
                                                                                        SUCCESS,
                                                                                        fit: BoxFit.contain,
                                                                                      )),
                                                                                ),
                                                                                SizedBox(height: 20,),
                                                                                Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(msg[SUCCESS_REG_MSG],
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
//                                                                            Navigator.pushAndRemoveUntil(
//                                                                              context,
//                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
//                                                                              ModalRoute.withName(UserChooseScreen.tag),
//                                                                            );
                                                                            },
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }catch(e){
                                                                    Navigator.of(context).pop();
                                                                    await showDialog(
                                                                      context: context,
                                                                      barrierDismissible: false,
                                                                      builder: (ctx) => AlertDialog(
                                                                        title: Text(msg[SUCCESS_TITLE]),
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
//                                                                            Navigator.pushAndRemoveUntil(
//                                                                              context,
//                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
//                                                                              ModalRoute.withName(UserChooseScreen.tag),
//                                                                            );
                                                                            },
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }

                                                                },
                                                                color: Theme.of(context)
                                                                    .primaryColor,
                                                                child: Text("Approve",
                                                                  style: TextStyle(color: Colors.white),
                                                                ),
                                                              ),
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
//                                                                icon: Icon(Icons.arrow_forward_ios),
//                                                              ),
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
                            ) ;
                          },
                          itemCount: approvalList.length,
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
//
//                    ],
//                  )
                ],
              ),
            )),
      ]),
    );
  }
}
