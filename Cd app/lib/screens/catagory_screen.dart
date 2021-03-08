import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/opportunity_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/vol_list_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/text_style.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import 'home/home_profile_screen.dart';

class CatagoryScreen extends StatefulWidget {
  static final String tag = "CatagoryScreen";

  CatagoryScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {
  var _isInit = true;
  var _isLoading = true;
  var catagory_text = "Fetching Expert Catagories...";
  List<dynamic> catagoryList = [];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      if(mounted){
      print("isloading $_isLoading");
      await Provider.of<GuestProvider>(context,listen: false).fetchExpertCatagoryList();
      Provider.of<AuthProvider>(context,listen: false).fetchTotalUnreadNotification();
      Provider.of<AuthProvider>(context,listen: false).frchatnotification();
      _isInit = false;
        setState(() {
          _isLoading = false;
          print("isloading $_isLoading");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    catagoryList = Provider.of<GuestProvider>(context).getCatagoryList;
    setState(() {
      catagory_text = "Search in ${catagoryList.length ?? ""} different catagories";
    });
    print("catagoryList-length-ui:  ${catagoryList.length}");
    return Scaffold(
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
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5, bottom: SizeConfig.blockSizeVertical * 5),
                  height: SizeConfig.blockSizeVertical * 85,
                  child:
                  _isLoading ?
                  Center(
                    child: CircularProgressIndicator(),)
                      :
                  GridView.builder(
                          padding: EdgeInsets.only(
                            top:SizeConfig.blockSizeVertical * 1,
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                            bottom: SizeConfig.blockSizeHorizontal * 15,
                          ),
                          itemCount: catagoryList.length,
                          itemBuilder: (ctx, i) =>
                              InkWell(
                                onTap: () async{
                                  print("ok");
                                  await Provider.of<GuestProvider>(context,listen: false)
                                      .setCategoryInfo(
                                        categoryId: catagoryList[i]["id"],
                                        catagoryName: catagoryList[i]["category_name"]
                                      );
                                  if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){
                                    Navigator.of(context).pushNamed(VolListScreen.tag);
                                  }else if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == VOLUNTEER_ROLE_ID){
                                    Navigator.of(context).pushNamed(OpportunityListScreen.tag);
                                  }

                                },
                                splashColor: primaryColor,
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.heartbeat,
                                          color: primaryColor,
                                        ),
                                        Text(catagoryList[i]["category_name"] ?? "No catagory found")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
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
                      child:
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(ProfileScreen.tag);
                        },
                        icon: Icon(Icons.menu, color: Colors.white,),
                      )
//                      IconButton(
//                        icon: Icon(
//                          Icons.arrow_back_ios,
//                          color: Colors.white,
//                        ),
//                        onPressed: () {
//                          Navigator.of(context).pop();
//                        },
//                      )
                      ,
                    )),
                    Expanded(
                      child: Text(
                        "Category",
//                        catagory_text,
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
//                Column(
//                  children: <Widget>[
//                    Text(
//                      catagory_text,
//                      style: heading_style.copyWith(
//                        fontSize: SizeConfig.blockSizeVertical * 2,
//                      ),
//                    ),
////                    Container(
////                      margin: EdgeInsets.only(
////                          top: SizeConfig.blockSizeVertical * 0.5),
////                      child: Icon(
////                        FontAwesomeIcons.search,
////                        color: Colors.white70,
////                      ),
////                    ),
//                  ],
//                )
              ],
            ),
          )),
    ]));
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
}
