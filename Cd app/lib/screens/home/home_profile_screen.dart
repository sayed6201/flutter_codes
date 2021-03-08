
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdv/screens/about_us.dart';
import 'package:crowdv/screens/certificate_screen.dart';
import 'package:crowdv/screens/faq_screen.dart';
import 'package:crowdv/screens/picture_upload.dart';
import 'package:crowdv/screens/privacy_policy.dart';
import 'package:crowdv/screens/quiz_screen.dart';
import 'package:crowdv/screens/recruiter_opportunity_pending_list.dart';
import 'package:crowdv/screens/review_screen.dart';
import 'package:crowdv/screens/tutorial_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/screens/recruiter_profile_setup.dart';
import 'package:crowdv/screens/recruiter_create_opportunity.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/widgets/home_widget_loder.dart';
import 'package:provider/provider.dart';

import '../../api_url.dart';
import '../../color_file.dart';
import '../../string.dart';
import '../catagory_screen.dart';
import '../profile_setup.dart';
import '../recruiter_view_opportunity.dart';
import '../vol_profile_setup.dart';

class ProfileScreen extends StatefulWidget {
  static final String tag = "/ProfileScreen";
  Color widgetColor = primaryColor;

//  ProfileScreen({@required this.widgetColor});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {

  Map<String,dynamic> userProfileData ={};
  var _isPlatinumLoading = false;
  var mode = 1;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

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
    // TODO: implement build

    userProfileData = Provider.of<AuthProvider>(context).getAData;

    return

    Scaffold(
      body: Provider.of<AuthProvider>(context).getUserRoleID == GUEST_ROLE_ID ?
      HomeWidgetLoader()
          :
      Stack(children: <Widget>[

        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        SingleChildScrollView(
          child:
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 10),
            margin: EdgeInsets.only(top: 2),
            width: SizeConfig.blockSizeVertical * 70,
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    boxShadow: [
//                      BoxShadow(
//                          color: Colors.black.withOpacity(.1),
//                          blurRadius: 30,
//                          spreadRadius: 5)
//                    ],
//                    borderRadius: BorderRadius.circular(10)),
            child: Wrap(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 30,),
                    //setting+++++++++++++++++++++
                    InkWell(
                        onTap: () {
                          if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == VOLUNTEER_ROLE_ID){
                            Navigator.of(context).pushNamed(
                                VolProfileSetup.tag,
                                arguments: {
                                  'title': "Profile Update",
                                  'btn_text': "Update",
                                  'is_signup' : "2"
                                }
                            );
                          }else if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){
                            Navigator.of(context).pushNamed(
                                RecruiterProfileSetup.tag,
                                arguments: {
                                  'title': "Profile Update",
                                  'btn_text': "Update",
                                  'is_signup' : "2"
                                }
                            );
                          }

                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.edit,color: Colors.deepOrange),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5,),
                              Text("Edit profile",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *1 ),
                      child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                    ),

                    //picture setting+++++++++++++++++++++
//                    InkWell(
//                        onTap: () {
//                          Navigator.of(context).pushNamed(
//                              PictureUploadScreen.tag
//                          );
//                        },
//                        splashColor: Colors.white,
//                        borderRadius: BorderRadius.circular(10),
//                        child: Container(
//                          margin: EdgeInsets.only(
//                            top: SizeConfig.blockSizeVertical * 1,
//                            bottom: SizeConfig.blockSizeVertical * 0.5,),
//                          padding: EdgeInsets.all(5.0),
////                                  width: 100,
////                                  decoration: BoxDecoration(
////                                    color: widget.widgetColor,
////                                    borderRadius: BorderRadius.circular(10.0),
////                                  ),
//                          alignment: Alignment.center,
//                          child: Row(
//                            children: <Widget>[
//                              Icon(FontAwesomeIcons.edit,color: Colors.deepOrange),
//                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5,),
//                              Text("Edit Profile Picture",
//                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
//                            ],
//                          ),
//                        )
//                    ),
//                    Container(
//                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *1 ),
//                      child:Divider(color: Colors.black12,thickness: 3,height: 5,),
//                    ),

                    //picture setting+++++++++++++++++++++
                    if(Provider.of<AuthProvider>(context).getUserRoleID != REQRUITER_ROLE_ID)
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                TutorialScreen.tag
                            );
                          },
                          splashColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              bottom: SizeConfig.blockSizeVertical * 0.5,),
                            padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.bookReader,color: Colors.deepOrange),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5,),
                                Text("Attempt Quiz",
                                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                              ],
                            ),
                          )
                      ),
                    if(Provider.of<AuthProvider>(context).getUserRoleID != REQRUITER_ROLE_ID)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *1 ),
                        child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                      ),

                    //Apply for platinum plate+++++++++++++++++++++
                    if(Provider.of<AuthProvider>(context).getUserRoleID != REQRUITER_ROLE_ID)
                      InkWell(
                          onTap: applyForPLainum,
                          splashColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              bottom: SizeConfig.blockSizeVertical * 0.5,),
                            padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidIdBadge,color: Colors.deepOrange),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5,),
                                Text("Apply for Platinum Badge",
                                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                              ],
                            ),
                          )
                      ),
                    if(Provider.of<AuthProvider>(context).getUserRoleID != REQRUITER_ROLE_ID)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *1 ),
                        child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                      ),

                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                    //edit schedule+++++++++++++++++++++
                      InkWell(
                        onTap: () {
//                          Navigator.of(context).pushNamed(
//                              ViewOpprtunityByRec.tag
//                          );
                          Navigator.of(context).pushNamed(
                              ReqruiterOpprtunityCreate.tag
                          );
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_box,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: SizeConfig.blockSizeHorizontal* 1.5,),
                              Text("Create Opportunity",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),),
                      ),

                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                        child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                      ),


                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                    //edit schedule+++++++++++++++++++++
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              RecruiterOpportunityPendingList.tag
                          );
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.history,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: SizeConfig.blockSizeHorizontal* 1.5,),
                              Text("See Your Hiring Posts",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),),
                      ),

                    if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                        child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                      ),


                    if(Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID)
                    //certificate+++++++++++++++++++++
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(CertificatePage.tag);
                          },
                          splashColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              bottom: SizeConfig.blockSizeVertical * 0.5,),
                            padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.history,color: Colors.deepOrange),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5,),
                                Text("Get Certificate",
                                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                              ],
                            ),
                          )
                      ),
                    if(Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                        child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                      ),

                    //password+++++++++++++++++++++
                    InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return passwordChangeDialog();
                              });
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.key,color: Colors.deepOrange),
                              SizedBox(width: SizeConfig.blockSizeHorizontal*1.5,),
                              Text("Change Password",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                      child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                    ),

                    //about us+++++++++++++++++++++
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AboutUsScreen.tag);
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.info,color: Colors.deepOrange),
                              SizedBox(width: SizeConfig.blockSizeHorizontal*1.5,),
                              Text("About us",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                      child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                    ),

                    //provacy policy+++++++++++++++++++++
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(PrivacyScreen.tag);
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.paperclip,color: Colors.deepOrange),
                              SizedBox(width: SizeConfig.blockSizeHorizontal*1.5,),
                              Text("Privacy policy",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                      child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                    ),

                    //FAQ+++++++++++++++++++++
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(FAQScreen.tag);
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.solidQuestionCircle,color: Colors.deepOrange),
                              SizedBox(width: SizeConfig.blockSizeHorizontal*1.5,),
                              Text("FAQ",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
                      child:Divider(color: Colors.black12,thickness: 3,height: 5,),
                    ),

                    //log out+++++++++++++++++++++
                    InkWell(
                        onTap: () async{
                          await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(""),
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
                                        child: Text("You are logged out Successfully",
                                          textAlign: TextAlign.center,),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Okay'),
                                  onPressed: () async{
                                    await Provider.of<AuthProvider>(context,listen: false).logout();
                                    Navigator.of(ctx).pop();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserChooseScreen()
                                        ),
                                            (Route<dynamic> route) => false
                                    );
                                  },
                                )
                              ],
                            ),
                          );

                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            bottom: SizeConfig.blockSizeVertical * 0.5,),
                          padding: EdgeInsets.all(5.0),
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                    color: widget.widgetColor,
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.powerOff,color: Colors.deepOrange),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
                              Text("Log Out",
                                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w700, )),
                            ],
                          ),
                        )
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 5,),

                  ],
                )
              ],
            ),
          ),
        ),

        //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        Positioned(
            top: 0.0,
            left: 0,
            right: 0,
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
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  SizedBox(height: 15,),
                  //app-bar data=========================================
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                      ),
                      Expanded(
                        child: Text("MENU",
                          style:
                          TextStyle(color: Colors.white, fontSize: SizeConfig.screenHeight * 0.02),
                          textAlign: TextAlign.center,),
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                ++mode;
                                Provider.of<AuthProvider>(context,listen: false).isLogRec(mode);
                              },
                            ),
                          )
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                  Padding(
//                    padding: EdgeInsets.only(left: 10),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisAlignment: MainAxisAlignment.start,
////                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        //image+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                        userProfileData["photo"] == null ?
//                        Container(
//                          height: SizeConfig.blockSizeVertical * 6,
//                          width: SizeConfig.blockSizeVertical * 6,
//                          decoration: BoxDecoration(
//                              image: DecorationImage(
//                                  image: AssetImage(PROFILE_IMG),
//                                  fit: BoxFit.fill),
//                              borderRadius: BorderRadius.circular(100),
//                              border: Border.all(
//                                  color: primaryColor.withOpacity(.2), width: 1)),
//                        ):
//                        CachedNetworkImage(
//                          height: SizeConfig.blockSizeVertical * 10,
//                          width: SizeConfig.blockSizeVertical * 10,
//                          imageUrl:
//                          IMG_HEAD_STR+userProfileData["photo"],
//                          imageBuilder: (context, imageProvider) => Container(
//                            height: SizeConfig.blockSizeVertical * 10,
//                            width: SizeConfig.blockSizeVertical * 10,
//                            decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              image: DecorationImage(
//                                  image: imageProvider, fit: BoxFit.cover),
//                            ),
//                          ),
//                          placeholder: (context, url) =>
//                              Container(
//                                  height: SizeConfig.blockSizeVertical * 10,
//                                  width: SizeConfig.blockSizeVertical * 10,
//                                  margin: EdgeInsets.all(5),
//                                  child: CircularProgressIndicator(
//                                    strokeWidth: 1.0,
//                                    valueColor: AlwaysStoppedAnimation(
//                                        Colors.white),
//                                  )),
//                          errorWidget: (context, url, error) =>
//                          new Icon(Icons.error),
//                          fit: BoxFit.fill,
//                        )
//                        ,
//                        SizedBox(
//                          width: 10,
//                        ),
//                        //user name and email+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                        Column(
//                          mainAxisSize: MainAxisSize.min,
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Flexible(
//                              child:
//                            (Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID) ?
//                              Text(
//                                "Name: "+userProfileData["recruiter_name"] ?? "Sayed AHmed",
//                                style: TextStyle(color: Colors.white,
//                                  fontSize: SizeConfig.screenHeight * 0.018,
//                                ),
//                                overflow: TextOverflow.ellipsis,
//                              )
//                            :
//                            Text(
//                              "Name: "+userProfileData["volunteer_name"] ?? "Sayed AHmed",
//                              style: TextStyle(color: Colors.white,
//                                fontSize: SizeConfig.screenHeight * 0.018,
//                              ),
//                              overflow: TextOverflow.ellipsis,
//                            ),),
//                            Flexible(
//                              child: Text(
//                                "Email: "+userProfileData["email"] ?? "Sayed AHmed",
//                                style: TextStyle(color: Colors.white,
//                                  fontSize: SizeConfig.screenHeight * 0.018,),
//                                overflow: TextOverflow.ellipsis,
//                              ),),
//                            Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID ?
//                            Flexible(
//                              child: Text(
//                                "Age: "+userProfileData["age"] ?? "Sayed AHmed",
//                                style: TextStyle(color: Colors.white,
//                                  fontSize: SizeConfig.screenHeight * 0.018,),
//                                overflow: TextOverflow.ellipsis,
//                              ),) :
//                            Flexible(
//                              child: Text(
//                                "ID: "+userProfileData["id"] ?? "Sayed AHmed",
//                                style: TextStyle(color: Colors.white,
//                                  fontSize: SizeConfig.screenHeight * 0.018,),
//                                overflow: TextOverflow.ellipsis,
//                              ),),
//                          ],
//                        )
//                      ],),
//                  )
                ],
              ),)),

        //-image++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        Positioned(
            top:
            userProfileData["photo"] != null ?
            SizeConfig.blockSizeVertical * 10 :
            SizeConfig.blockSizeVertical * 5,
            left: SizeConfig.blockSizeHorizontal * 35,
            //            right: SizeConfig.blockSizeHorizontal * 88,
            child:
            InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(
                      PictureUploadScreen.tag
                  );
                },
                child:

                    Hero(
                        tag: "211",
                        child:
                        userProfileData["photo"] != null ?
                        Stack(
                            children: <Widget>[
                                CachedNetworkImage(
                                  height: SizeConfig.blockSizeVertical * 15,
                                  width: SizeConfig.blockSizeVertical * 15,
                                  imageUrl:
                                  IMG_HEAD_STR+userProfileData["photo"],
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
                                ),
                                Positioned(
                                  top : 5,
                                  right: 5,
                                  child: Icon(Icons.camera_alt,color: Colors.white,),
                                )])
                            :
                        Stack(
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(PROFILE_IMG),
                                          fit: BoxFit.contain)
                                  ),
                                  height: SizeConfig.blockSizeVertical * 25,
                                  width: SizeConfig.blockSizeHorizontal * 25),
                              Positioned(
                                top : 40,
                                right: 5,
                                child: Icon(Icons.camera_alt,color: Colors.white,),
                              )])
                    ),

            )
        ),
      ]),
    );
  }

  void applyForPLainum() async{

    setState(() {
      _isPlatinumLoading = true;
    });

    print("validation started");

    try{
      bool cancel = false ;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("NOTE"),
          content:
          Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                        child: Text("To be eligible for Platinum Badge You must have\n 1) 100 Hour Working record \n 2) Average Rating atleast 4.0")
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Agree & Proceed'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
                cancel = true;
              },
            )
          ],
        ),
      );

      if(cancel) return;

       showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Submitting Your Application"),
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
                        child: CircularProgressIndicator()
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              )
            ],
          ),
          actions: <Widget>[
          ],
        ),
      );


      String rating = await Provider.of<AuthProvider>(context, listen: false).fetchVolAvgRating(mode: "1");

      String hour = await Provider.of<AuthProvider>(context, listen: false).fetchVolTotalHour();

      if(rating == null || hour == null){
        setState(() {
          _isPlatinumLoading = false;
        });

        Navigator.of(context).pop();

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text("Opps!"),
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
                      child: Text(
                        "Sorry ! You are not eligible for Platinum Badge Yet",
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
        return;
      }

      double avgRating = double.parse(rating);
      double totalWorkingHour = double.parse(hour);

      print("avgRating = $avgRating - totalWorkingHour : $totalWorkingHour ");

      if(avgRating < 4.0 || totalWorkingHour < 100.0){
        setState(() {
          _isPlatinumLoading = false;
        });

        Navigator.of(context).pop();

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text("Opps!"),
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
                      child: Text(
                        "Sorry ! You are not eligible for Platinum Badge Yet",
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
        return;
      }

      await Provider.of<AuthProvider>(context, listen: false).applyVolPlatinum();

      setState(() {
        _isPlatinumLoading = false;
      });

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
                          SUCCESS,
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Applcation Successful! \n Congrats! You have been Awarded Platinum Badge",
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

    }catch(e){
      setState(() {
        _isPlatinumLoading = false;
      });
      Navigator.of(context).pop();
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

class passwordChangeDialog extends StatefulWidget {
  Map<String, String> cacheData = {};

  passwordChangeDialog();

  @override
  _passwordChangeDialogState createState() => _passwordChangeDialogState();
}

class _passwordChangeDialogState extends State<passwordChangeDialog> {
  final passController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isPassChangeLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return AlertDialog(
      title: Card(
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.vpn_key,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          )),
      content: Wrap(
        children: <Widget>[
          Container(
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      controller: passController,
                      obscureText: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "must be filled";
                        }if(val.length < 5){
                          return "Must be 6 char long";
                        }
                        else {
                          return null;
                        }
                      },
                      onSaved: (String val) {},
                      decoration: InputDecoration(
                        hintText: "Enter current password",
                        icon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      controller: newPasswordController,
                      obscureText: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "must be filled";
                        }if(val.length < 5){
                          return "Must be 6 char long";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String val) {
//                                            _email = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter new password",
                        icon: Icon(Icons.new_releases),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      controller: confirmPassController,
                      obscureText: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "must be filled";
                        } else if (val != newPasswordController.text) {
                          return 'Password does not match';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String val) {
//                                            _email = val;
                      },
                      decoration: InputDecoration(
                        hintText:"Confirm new password",
                        icon: Icon(Icons.verified_user),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed:(){
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),

        _isPassChangeLoading ?
        CircularProgressIndicator()    
            :
        FlatButton(
          onPressed: _validateInputs,
          child: Text("Update"),
        ),
      ],
    );
  }

  void _validateInputs() async{
    print("_validateInputs ...");

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("password ${passController.text.toString().trim()} - newPasswprd ${newPasswordController.text.toString().trim()}");
      print("Validation Success");

      try{
        setState(() {
          _isPassChangeLoading = true;
        });

        String resonse = await Provider.of<AuthProvider>(context,listen: false)
            .chnagePassword(
            newPass: newPasswordController.text.toString().trim(),
            oldPass: passController.text.toString().trim()
        );

        setState(() {
          _isPassChangeLoading = false;
        });

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
                            SUCCESS,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(resonse,
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

        Navigator.of(context).pop();

      }catch(e){
        setState(() {
          _isPassChangeLoading = false;
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
    } else {
      print("Validation failed");
    }
  }



}




