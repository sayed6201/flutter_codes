
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdv/screens/home/home_profile_screen.dart';
import 'package:crowdv/screens/reruiter_profile_view.dart';
import 'package:crowdv/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/catagory_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/widgets/custom_clipper.dart';
import 'package:provider/provider.dart';
import '../../api_url.dart';
import '../../color_file.dart';
import 'package:flutter/services.dart';

import '../../string.dart';
import '../vol_list_screen.dart';
import '../vol_profile_view.dart';

enum SearchTabsOption {
  tour,
  hotel,
  transport,
  room,
}

class HomeMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeMainState();
  }
}

class HomeMainState extends State<StatefulWidget> {

  int _selectedIndexForButton = 0;
  var currentPage;
  int isBtnSelected = 100;
  int isSearchSelected = 1;
  String searchHint = 'Search Hotels';
  var _isInit = true;
  var _isLoadingHomeData = false;

  List<dynamic> recentRecLIst = [];
  List<dynamic> recentVolLIst = [];

  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

//  List<String> imgList = [
//    TRANSPORT_BANNAER,
//    ROOM_BANNAER,
//    TOUR_BANNAER
//  ];

//  Widget imageCarousel= Container(
//    height: 265.0,
//    child: Carousel(
//      overlayShadow: true,
//      borderRadius: true,
//      boxFit: BoxFit.cover,
//      autoplay: true,
//      dotSize: 5.0,
//      indicatorBgPadding: 0.0,
//      images: [
//        new AssetImage(IMG_BANNER8),
//        new AssetImage(IMG_BANNER1),
//        new AssetImage(IMG_BANNER4),
//        new AssetImage(IMG_BANNER5),
//        new AssetImage(IMG_BANNER6),
//        new AssetImage(IMG_BANNER7),
//        new AssetImage(IMG_BANNER2),
//        new AssetImage(IMG_BANNER3),
//      ],
//      animationCurve: Curves.bounceInOut,
//      animationDuration: Duration(microseconds: 2000),
//    ),
//  );

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  
  Widget buildSearchType() {
    TextStyle selectedTextColor = TextStyle(
        fontSize:SizeConfig.screenHeight * 0.02, fontWeight: FontWeight.normal, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize:SizeConfig.screenHeight * 0.02,
        fontWeight: FontWeight.normal,
        color: Theme
            .of(context)
            .primaryColor);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0,vertical: 5),
        child:
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearchSelected = 0;
                        searchHint = 'Search Tours';
                      });
                    },
                    child:
                    Wrap(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
//                          border: Border.all(
//                              color: isSearchSelected == 0
//                                  ? Colors.white
//                                  : Theme
//                                  .of(context)
//                                  .primaryColor,
//                              width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                              color: isSearchSelected == 0
                                  ? Theme
                                  .of(context)
                                  .primaryColor
                                  : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.timer,
                                  color: isSearchSelected == 0
                                      ? Colors.white
                                      : Theme
                                      .of(context)
                                      .primaryColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Schedules",
                                  style: isSearchSelected == 0
                                      ? selectedTextColor
                                      : unSelectedTextColor,
                                )
                              ],
                            )
                        )
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearchSelected = 1;
                      searchHint = 'Search Experts';
                    });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) => SearchLocation(),
//                ),
//              );
                  },
                  child: Wrap(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
//                      border: Border.all(
//                          color: isSearchSelected == 1
//                              ? Colors.white
//                              : Theme.of(context).primaryColor,
//                          width: 0.5),
                            borderRadius:  BorderRadius.circular(5),
                            color: isSearchSelected == 1
                                ? Theme
                                .of(context)
                                .primaryColor
                                : Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.local_hospital,
                                color: isSearchSelected == 1
                                    ? Colors.white
                                    : Theme
                                    .of(context)
                                    .primaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Experts",
                                style: isSearchSelected == 1
                                    ? selectedTextColor
                                    : unSelectedTextColor,
                              )
                            ],
                          )
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearchSelected = 3;
                      searchHint = 'Search Experts';
                    });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) => SearchLocation(),
//                ),
//              );
                  },
                  child: Wrap(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
//                      border: Border.all(
//                          color: isSearchSelected == 1
//                              ? Colors.white
//                              : Theme.of(context).primaryColor,
//                          width: 0.5),
                            borderRadius:  BorderRadius.circular(5.0),
                            color: isSearchSelected == 3
                                ? Theme
                                .of(context)
                                .primaryColor
                                : Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_alarm,
                                color: isSearchSelected == 3
                                    ? Colors.white
                                    : Theme
                                    .of(context)
                                    .primaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Doctors",
                                style: isSearchSelected == 3
                                    ? selectedTextColor
                                    : unSelectedTextColor,
                              )
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoadingHomeData = true;
      });
      await Provider.of<GuestProvider>(context, listen: false).fetchRecentRecruiter();
      await Provider.of<GuestProvider>(context, listen: false).fetchRecentVol();
      if(mounted){
        setState(() {
          _isLoadingHomeData = false;
        });
      }
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryColor.withOpacity(0.5), // status bar color
    ));

    recentVolLIst = Provider.of<GuestProvider>(context).getRecentVolList;
    recentRecLIst = Provider.of<GuestProvider>(context).getRecentRecList;

    return SingleChildScrollView(
      child:
          //search bar:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
          Stack(children: <Widget>[
            ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                    width: double.infinity,
                    height: SizeConfig.blockSizeVertical * 38,
                    decoration: BoxDecoration(

                    ),
                    child:Text("")
                    //image carousal section::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//                    imageCarousel
                )
            ),
            ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height:SizeConfig.blockSizeVertical * 38,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.7),
                        Theme.of(context).primaryColor.withOpacity(0.9),
                      ],
                    ),
                  ),
                )
            ),
            Container(
              padding: EdgeInsets.only(top: SizeConfig.statusBarSize),
              child:
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: (){
//                        Scaffold.of(context).openDrawer();
                        Navigator.of(context).pushNamed(ProfileScreen.tag);
                      },
                      icon: Icon(Icons.menu, color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Text(
                    (Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID) ?
                        'Find Volunteers from all over the world':
                    'Find Opportunities from all over the world',
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.025,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical * 5),
                    child: Material(
                      elevation: 8.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0)
                      ),
                      child: InkWell(
                        onTap: () {
//                          if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID != REQRUITER_ROLE_ID)
                          Navigator.of(context).pushNamed(
                              CatagoryScreen.tag
                          );
                        },
                        child: TextField(
                          enabled: false,
                          onChanged: (text) {},
                          cursorColor: Theme
                              .of(context)
                              .primaryColor,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hoverColor: Colors.white,

                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 14.0),
                            suffixIcon: Material(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              elevation: 2.0,
                              borderRadius: BorderRadius.all(Radius.circular(5.0),
                              ),
                              child: InkWell(
                                onTap: () {

                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 18,
                  ),
//                  Align(
//                      alignment: Alignment.centerLeft,
//                      child: Padding(
//                        padding: EdgeInsets.all(10),
//                        child: Text(
//                          (Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID) ?
//                          'New Opportunities' : 'Your Created Opportunities',
//                          style: TextStyle(
//                            fontWeight: FontWeight.w500,
//                            fontSize: SizeConfig.screenHeight * 0.025,
//                            color: Colors.black38,
//                          ),
//                          textAlign: TextAlign.left,
//                        ),
//                      )
//                  ),
//                  Container(
//                    height: SizeConfig.blockSizeVertical * 30,
//                    child: ListView.builder(
//                        shrinkWrap: true,
//                        itemCount: 6,
//                        scrollDirection: Axis.horizontal,
//                        itemBuilder: (conx,index){
//                          return InkWell(
//                            onTap: (){
//                              Navigator.of(context).pushNamed(VolListScreen.tag);
//                            },
//                            child: Container(
//                              margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 1),
//                              width:  SizeConfig.blockSizeHorizontal * 40,
//                              child: Stack(
//                                alignment: Alignment.topCenter,
//                                children: <Widget>[
//                                  Positioned(
//                                    bottom: 15.0,
//                                    child: Container(
//                                      height: SizeConfig.blockSizeVertical * 30,
//                                      width: SizeConfig.blockSizeVertical * 40,
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        borderRadius: BorderRadius.circular(10.0),
//                                      ),
//                                      child: Card(
//                                        elevation: 2,
//                                        child: Padding(
//                                          padding: EdgeInsets.all(5.0),
//                                          child: Column(
//                                            mainAxisAlignment: MainAxisAlignment.end,
//                                            children: <Widget>[
//                                              Text(
//                                                "Title: job 123 ",
//                                                style: TextStyle(
//                                                  fontSize: 12.0,
//                                                  fontWeight: FontWeight.w600,
//                                                  letterSpacing: 1.2,
//                                                ),
//                                              ),
//                                              SizedBox(height: 2.0),
//                                              Row(
//                                                mainAxisAlignment: MainAxisAlignment.center,
//                                                children: <Widget>[
//                                                  Text('Rating: 4/5')
//                                                ],
//                                              ),
//                                              SizedBox(height: 2.0),
//                                              Text(
//                                                "Location: dhaka 21",
//                                                style: TextStyle(
//                                                  color: Colors.black,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        borderRadius: BorderRadius.circular(20.0),
//                                        boxShadow: [
//                                          BoxShadow(
//                                            color: Colors.black26,
//                                            offset: Offset(0.0, 2.0),
//                                            blurRadius: 6.0,
//                                          ),
//                                        ],
//                                      ),
//                                      child: ClipRRect(
//                                        borderRadius: BorderRadius.circular(10.0),
//                                        child: Container(
//                                          height: SizeConfig.blockSizeVertical * 12,
//                                          width: SizeConfig.blockSizeHorizontal * 45,
//                                          child: Image.asset(IDEA),
//                                        ),
//                                      ))
//                                ],
//                              ),
//                            ),
//                          );
//                        }
//                    ),
//                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
//                        (Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID) ?
//                        'Recent Reqruiters' :
                        'Recent Volunteers',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenHeight * 0.025,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ),
                  _isLoadingHomeData ?
                      Center(
                        child: LoaderWidget(
                          text: "Fetching data ... ",
                        ),
                      ):
                  Container(
                    height: SizeConfig.blockSizeVertical * 30,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recentVolLIst.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (conx,index){
                          return InkWell(
                            onTap: ()async{
//                              if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){
                              await Provider.of<AuthProvider>(context,listen: false)
                                  .setVolData(recentVolLIst[index]);
                              Navigator
                                  .of(context)
                                  .pushNamed(
                                  VolunteerProfileView.tag,
                                  arguments: '2'
                              );
//                              }else{
//                                Navigator.of(context).pushNamed(ReqruiterProfileScreen.tag);
//                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 1),
                              width:  SizeConfig.blockSizeHorizontal * 40,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Positioned(
                                    bottom: 15.0,
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 30,
                                      width: SizeConfig.blockSizeVertical * 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Card(
                                        elevation: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "Name: "+recentVolLIst[index]["volunteer_name"] ?? "Sayed",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                "Intitute: "+recentVolLIst[index]["instituation_name"] ?? "N/A",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
//                                              Row(
//                                                mainAxisAlignment: MainAxisAlignment.center,
//                                                children: <Widget>[
//                                                  Text('Rating: 4/5')
//                                                ],
//                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                "Gender: "+recentVolLIst[index]["gender"] ?? "Sayed",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: SizeConfig.blockSizeVertical * 13,
                                          width: SizeConfig.blockSizeHorizontal * 45,
                                          child:
                                          recentVolLIst[index]["photo"] == null ?
                                          Image.asset(PROFILE_IMG) :
                                          CachedNetworkImage(
                                            imageUrl:
                                            IMG_HEAD_STR+recentVolLIst[index]["photo"],
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: SizeConfig.blockSizeVertical * 5,
                                              width: SizeConfig.blockSizeVertical * 5,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                    image: imageProvider, fit: BoxFit.fitHeight),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                                    height: SizeConfig.blockSizeVertical * 10,
                                                    width: SizeConfig.blockSizeVertical * 10,
                                                    margin: EdgeInsets.all(5),
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 1.0,
                                                      valueColor: AlwaysStoppedAnimation(
                                                          Colors.white),
                                                    )),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(PROFILE_IMG),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),


                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
//                          (Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID) ?
                          'Recent Recruiters'
//                              :
//                          'Recent Volunteers'
                          ,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenHeight * 0.025,
                            color: Colors.black38,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                  ),
                  _isLoadingHomeData ?
                  Center(
                    child: LoaderWidget(
                      text: "Fetching data ... ",
                    ),
                  ):
                  Container(
                    height: SizeConfig.blockSizeVertical * 30,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recentRecLIst.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (conx,index){
                          return InkWell(
                            onTap: () async{
//                              if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){
//                                Navigator.of(context).pushNamed(VolunteerProfileScreen.tag);
//                              }else{
                              await Provider.of<AuthProvider>(context,listen: false)
                                  .setRecData(recentRecLIst[index]);
                              Navigator
                                  .of(context)
                                  .pushNamed(
                                  RecruiterProfileView.tag,
                                  arguments: '2'
                              );
//                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 1),
                              width:  SizeConfig.blockSizeHorizontal * 40,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Positioned(
                                    bottom: 15.0,
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 30,
                                      width: SizeConfig.blockSizeVertical * 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Card(
                                        elevation: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "Name: "+recentRecLIst[index]["recruiter_name"] ?? "Sayed",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
//                                              SizedBox(height: 2.0),
//                                              Text(
//                                                "Intitute: "+recentVolLIst[index]["instituation_name"] ?? "N/A",
//                                                style: TextStyle(
//                                                  color: Colors.black,
//                                                ),
//                                              ),
//                                              Row(
//                                                mainAxisAlignment: MainAxisAlignment.center,
//                                                children: <Widget>[
//                                                  Text('Rating: 4/5')
//                                                ],
//                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                "Gender: "+recentRecLIst[index]["gender"] ?? "N/A",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: SizeConfig.blockSizeVertical * 13,
                                          width: SizeConfig.blockSizeHorizontal * 45,
                                          child:
                                          recentRecLIst[index]["photo"] == null ?
                                          Image.asset(PROFILE_IMG) :
                                          CachedNetworkImage(
                                            imageUrl:
                                            IMG_HEAD_STR+recentRecLIst[index]["photo"],
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: SizeConfig.blockSizeVertical * 5,
                                              width: SizeConfig.blockSizeVertical * 5,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                    image: imageProvider, fit: BoxFit.fitHeight),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                                    height: SizeConfig.blockSizeVertical * 10,
                                                    width: SizeConfig.blockSizeVertical * 10,
                                                    margin: EdgeInsets.all(5),
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 1.0,
                                                      valueColor: AlwaysStoppedAnimation(
                                                          Colors.white),
                                                    )),
                                            errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            )
          ]
          )
    );
  }


}