
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdv/screens/picture_upload.dart';
import 'package:crowdv/widgets/loader_widget.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:crowdv/widgets/home_widget_loder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/booking_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../api_url.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';
import 'home/home_profile_screen.dart';

class RecruiterProfileView extends StatefulWidget {

  static final String tag = "RecruiterProfileView";

  @override
  _RecruiterProfileViewState createState() => _RecruiterProfileViewState();
}

class _RecruiterProfileViewState extends State<RecruiterProfileView> {
  var _isInit = true;
  var _isLoading = true;
  var avgRating;
  var header_text = "RECRUITER'S PROFILE";
  Map<String,dynamic> recInfo = {};
  List<dynamic> reviewList = [];
  var mode_flag = "1" ;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      print("isloading $_isLoading");
      
      if(ModalRoute.of(context).settings.arguments != null)
      mode_flag = await ModalRoute.of(context).settings.arguments as String;

      avgRating = await Provider.of<AuthProvider>(context,listen: false).fetchRecAvgRating(mode: mode_flag);
      await Provider.of<AuthProvider>(context,listen: false).fetchRecReviews(mode: mode_flag);
      Provider.of<AuthProvider>(context,listen: false).fetchTotalUnreadNotification();
      Provider.of<AuthProvider>(context,listen: false).frchatnotification();
      _isInit = false;
      if(mounted){
        if(mounted){
        setState(() {
          _isLoading = false;
          print("isloading $_isLoading");
        });
      }
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

    if(mode_flag == "1"){
      recInfo =  Provider.of<AuthProvider>(context).getAData;
      setState(() {
        header_text = "My Profile";
      });
    }else{
      recInfo =  Provider.of<AuthProvider>(context).getRecData;
      setState(() {
        header_text = "RECRUITER'S PROFILE";
      });
    }

    reviewList =  Provider.of<AuthProvider>(context).getVolReviewLIst;
//    setState(() {
//      header_text = "${doctorData.length ?? ""} Experts found";
//    });
    print("Vol Data-length-ui:  ${recInfo.toString()}");

    return Scaffold(
      body:
      Provider.of<AuthProvider>(context).getUserRoleID == GUEST_ROLE_ID ?
      HomeWidgetLoader()
          :
      Stack(children: [
        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        Positioned(
            top: SizeConfig.blockSizeVertical * 30,
            left: 5,
            right: 5,
            child: Container(
              height: SizeConfig.blockSizeVertical * 70,
              child: ListView(
                shrinkWrap: true,

                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
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
                                                        "Name  : ${recInfo["recruiter_name"]}",
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
                                                      child:
                                                      Icon(Icons.verified_user, color: Colors.white,)
//                                                      Text(
//                                                        "ID: ${recInfo["id"]}",
//                                                        style: TextStyle(
//                                                            fontSize: SizeConfig.blockSizeVertical * 2,
//                                                            fontWeight: FontWeight.w500,
//                                                            color: Colors.white
//                                                        ),
//                                                      ),
                                                    )
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
                                                          Text("Email: ${recInfo["email"] ?? "N/A"}",
                                                              textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                color: Colors.black38,
                                                                fontSize: SizeConfig.blockSizeVertical * 2,
                                                              )),
                                                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                                                          Text("Phone: ${recInfo["phone"] ?? "N/A"}",
                                                              textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                color: Colors.black38,
                                                                fontSize: SizeConfig.blockSizeVertical * 2,
                                                              )),
                                                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                                                          Text( avgRating == null ? "Rating: N/A" : "Rating: $avgRating",
                                                              textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                color: Colors.black38,
                                                                fontSize: SizeConfig.blockSizeVertical * 2,
                                                              )),
//                                                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                          Text("Location: ${recInfo["address"] ?? "N/A"}",
//                                                              textAlign: TextAlign.left,
//                                                              style: TextStyle(
//                                                                color: Colors.black38,
//                                                                fontSize: SizeConfig.blockSizeVertical * 2,
//                                                              )),
//                                                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                          Text("DOB: ${recInfo["age"] ?? "N/A"}",
//                                                              textAlign: TextAlign.left,
//                                                              style: TextStyle(
//                                                                color: Colors.black38,
//                                                                fontSize: SizeConfig.blockSizeVertical * 2,
//                                                              )),
                                                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                          Text("Level: Pro",
//                                                              textAlign: TextAlign.left,
//                                                              style: TextStyle(
//                                                                color: Colors.black38,
//                                                                fontSize: SizeConfig.blockSizeVertical * 2,
//                                                              )),
//                                                          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                          Text("phone: 12323213",
//                                                              textAlign: TextAlign.left,
//                                                              style: TextStyle(
//                                                                color: Colors.black38,
//                                                                fontSize: SizeConfig.blockSizeVertical * 2,
//                                                              )),
                                                        ],
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      ),
                                                    ),
//                                                    Container(
//                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                      margin: EdgeInsets.only(top: 5),
//                                                      decoration: BoxDecoration(
//                                                        color:primaryColor,
//                                                        border: Border.all(color: primaryColor),
//                                                        borderRadius: BorderRadius.circular(100),
//                                                      ),
//                                                      child: Text("Fee: 2000tk",
//                                                          style: TextStyle(
//                                                            color: Colors.white,
//                                                            fontSize: SizeConfig.blockSizeVertical * 2,
//                                                          )),
//                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
//                                    Align(
//                                      alignment: Alignment.center,
//                                      child: Padding(
//                                          padding: EdgeInsets.only(bottom: 0, right: 5),
//                                          child: Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                            children: <Widget>[
//                                              IconButton(
//                                                onPressed: () {
//                                                },
//                                                color: Theme.of(context)
//                                                    .primaryColor,
//                                                icon: Icon(Icons.chat),
//                                              ),
//                                              IconButton(
//                                                onPressed: () {
//                                                },
//                                                color: primaryColor,
//                                                icon: Icon(Icons.call),
//                                              ),
//                                              IconButton(
//                                                onPressed: () {
//                                                },
//                                                color: Theme.of(context)
//                                                    .primaryColor,
//                                                icon: Icon(Icons.arrow_forward_ios),
//                                              ),
//                                            ],
//                                          )),
//                                    )
                                  ]
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Wrap(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                            elevation: 10,
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
                                                        "Reviews",
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
                                                      child: Icon(Icons.schedule,
                                                        color: Colors.white,),)
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Divider(color: Colors.black38,),
                                                ),
                                                _isLoading ?
                                                LoaderWidget(text:"Fetching Reviews...",) :
                                                (
                                                    reviewList.length == 0 ?
                                                    NoData(
                                                      text: "NO reviews",
                                                    ) :
                                                    Wrap(
                                                      children: <Widget>[
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: reviewList.length,
                                                            itemBuilder: (context,index){
                                                              return Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    margin: EdgeInsets.all(5),
                                                                    padding: EdgeInsets.all(10),
                                                                    child: (
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Container(
//                                                                              decoration: BoxDecoration(
//                                                                                color:Colors.blue,
//                                                                                border: Border.all(color: Colors.blue),
//                                                                                borderRadius: BorderRadius.circular(100),
//                                                                              ),
                                                                              child:Text(
                                                                                " ${reviewList[index]["comments"]}",
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                                            ),
//                                                                            Column(
//                                                                              children: <Widget>[
//                                                                                Text(
//                                                                                  "Date: 12-21-2020",
//                                                                                  style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
//                                                                                ),
//                                                                                SizedBox(height: 2,),
//                                                                                Text(
//                                                                                  "Rate: 4.6/5",
//                                                                                  style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
//                                                                                ),
//                                                                                SizedBox(height: 2,),
////                                                                                Text(
////                                                                                  "Fee: 200 tk",
////                                                                                  style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
////                                                                                ),
//                                                                              ],
//                                                                              crossAxisAlignment: CrossAxisAlignment.end,
//                                                                            ),
                                                                          ],
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              height: SizeConfig.blockSizeVertical * 25,
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
                            mode_flag == "1" ?
                            IconButton(
                              onPressed: (){
//                        Scaffold.of(context).openDrawer();
                                Navigator.of(context).pushNamed(ProfileScreen.tag);
                              },
                              icon: Icon(Icons.menu, color: Colors.white,),
                            )
                                :
                            IconButton(
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

        //profile-image++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        Positioned(
            top:
            recInfo["photo"] != null ?
            SizeConfig.blockSizeVertical * 15 :
            SizeConfig.blockSizeVertical * 10,
            left: SizeConfig.blockSizeHorizontal * 35,
//            right: SizeConfig.blockSizeHorizontal * 88,
            child: InkWell(
              onTap: (){
                if(mode_flag == "1")
                  Navigator.of(context).pushNamed(
                      PictureUploadScreen.tag
                  );
              },
              child:
              _isLoading?
              CircularProgressIndicator()
                  :
              Hero(
                  tag: header_text,
                  child:
                  recInfo["photo"] != null ?
                  CachedNetworkImage(
                    height: SizeConfig.blockSizeVertical * 15,
                    width: SizeConfig.blockSizeVertical * 15,
                    imageUrl:
                    IMG_HEAD_STR+recInfo["photo"],
                    imageBuilder: (context, imageProvider) => Container(
                      height: SizeConfig.blockSizeVertical * 15,
                      width: SizeConfig.blockSizeVertical * 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Container(
                            height: SizeConfig.blockSizeVertical * 15,
                            width: SizeConfig.blockSizeVertical * 15,
                            margin: EdgeInsets.all(5),
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor: AlwaysStoppedAnimation(
                                  Colors.white),
                            )),
                    errorWidget: (context, url, error) =>
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(PROFILE_IMG),
                                  fit: BoxFit.contain)
                          ),
                          height: SizeConfig.blockSizeVertical * 15,
                          width: SizeConfig.blockSizeVertical * 15,),
                    fit: BoxFit.fill,
                  )
                      :
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(PROFILE_IMG),
                              fit: BoxFit.contain)
                      ),
                      height: SizeConfig.blockSizeVertical * 25,
                      width: SizeConfig.blockSizeHorizontal * 25)
              ),
            )
        ),

      ]),

//      bottomNavigationBar: InkWell(
//        onTap: () async{
////          if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID) return;
////            await Navigator.of(context).pushNamed(BookingScreen.tag);
////
//        },
//        child: Container(
//          height: SizeConfig.blockSizeVertical * 6,
//          padding: EdgeInsets.only(left: 20, right: 20),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(0.0),
//              color: primaryColor),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Icon(
//                    FontAwesomeIcons.dollarSign,
//                    color: Colors.white,
//                  ),
//                  SizedBox(
//                    width: SizeConfig.blockSizeHorizontal * 2,
//                  ),
//                  Text(
//                    "Hire now",
//                    style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2),
//                  ),
//                ],
//              ),
//              Icon(
//                Icons.arrow_forward_ios,
//                color: Colors.white,
//              ),
//            ],
//          ),
//        ),
//      )
    );
  }
}
