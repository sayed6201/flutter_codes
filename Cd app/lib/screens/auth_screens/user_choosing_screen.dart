import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/auth_screens/login_screen.dart';
import 'package:crowdv/screens/home/home_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/widgets/already_have_account.dart';
import 'package:crowdv/widgets/or_divider.dart';
import 'package:crowdv/widgets/rounded_button.dart';
import 'package:crowdv/widgets/rounded_password_field.dart';
import 'package:crowdv/widgets/rounded_textfield.dart';
import 'package:crowdv/widgets/social_icon.dart';
import 'package:provider/provider.dart';

import '../../color_file.dart';
import '../../string.dart';

class UserChooseScreen extends StatefulWidget {

  static final String tag = "/UserChooseScreen";

  @override
  _UserChooseScreenState createState() => _UserChooseScreenState();
}

class _UserChooseScreenState extends State<UserChooseScreen> {
  

  var isBtnSelected = 0;
  
  
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: primaryColor,
        body:SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            // Here i can use size.width but use double.infinity because both work as a same
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/signup_top.png",
                    width: size.width * 0.35,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/main_bottom.png",
                    width: size.width * 0.25,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: SizeConfig.blockSizeVertical * 15,
                          child: Image.asset(LOGO, fit: BoxFit.contain,)),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3),
//                      OrDivider("Hello, let us know who you are"),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
//                      Text(
//                        "CHOOSE USER TYPE",
//                        style:
//                        TextStyle(fontWeight: FontWeight.w700,
//                            fontSize: SizeConfig.blockSizeVertical * 2.5,
//                          color: Colors.white70
//                        ),
//                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 5),
                      buildButton()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.arrow_forward, color: Colors.white,),
//        onPressed: (){
//          if(isBtnSelected == 2){
//            Provider.of<AuthProvider>(context,listen: false).setUserRole(roleId:isBtnSelected);
//            Navigator.of(context).pushNamed(LoginScreen.tag);
//          }
//          if(isBtnSelected == 3){
//            Provider.of<AuthProvider>(context,listen: false).setUserRole(roleId:isBtnSelected);
//            Navigator.of(context).pushNamed(LoginScreen.tag);
//          }
//          if(isBtnSelected == 0){
//            Provider.of<AuthProvider>(context,listen: false).setUserRole(roleId:isBtnSelected);
//            Navigator.of(context).pushNamed(HomeScreen.tag);
//          }
//        },
//      ),
    );
  }

  
  Widget buildButton() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 2, fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 2,
        fontWeight: FontWeight.bold,
        color: primaryColor);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
//        Text("Choose Scanner", style:TextStyle(color: Colors.black12, fontSize: 20, fontWeight: FontWeight.w500),),
//        SizedBox(height: 10,),
        GestureDetector(
          onTap: () {
            setState(() {
              isBtnSelected = 3;
            });
            Provider.of<AuthProvider>(context,listen: false).setUserRole(roleId:isBtnSelected);
            Navigator.of(context).pushNamed(LoginScreen.tag);
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: SizeConfig.blockSizeHorizontal * 42,
              height: SizeConfig.blockSizeVertical * 9,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isBtnSelected == 3
                        ? Colors.white
                        : primaryColor,
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: isBtnSelected == 3
                    ? primaryColor
                    : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        width: 0, // you can adjust the width as you need
                        child: Icon(
                          FontAwesomeIcons.male,
                          color: isBtnSelected == 2
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        width: 0, // you can adjust the width as you need
                        child: Icon(
                          FontAwesomeIcons.female,
                          color: isBtnSelected == 2
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 0.6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Volunteer",
                          style: isBtnSelected == 3
                              ? selectedTextColor
                              : unSelectedTextColor,
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                      Text(
                        'Join as a volunteer',
                        style: isBtnSelected == 3
                            ? selectedTextColor.copyWith(
                          fontSize: SizeConfig.blockSizeVertical * 1.5
                        ): unSelectedTextColor.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 1.5
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2,),
        GestureDetector(
          onTap: () {
            setState(() {
              isBtnSelected = 2;
            });
            Provider.of<AuthProvider>(context,listen: false).setUserRole(roleId:isBtnSelected);
            Navigator.of(context).pushNamed(LoginScreen.tag);
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: SizeConfig.blockSizeHorizontal * 42,
              height: SizeConfig.blockSizeVertical * 9,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isBtnSelected == 2
                        ? Colors.white
                        : primaryColor,
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: isBtnSelected == 2
                    ? primaryColor
                    : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.handsHelping,
                    color: isBtnSelected == 2
                        ? Colors.white
                        : primaryColor,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 0.7,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Recruiter",
                        style: isBtnSelected == 2
                            ? selectedTextColor
                            : unSelectedTextColor,
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                      Text(
                        'Create opportunities',
                        style: isBtnSelected == 2
                            ? selectedTextColor.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 1.5
                        ): unSelectedTextColor.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 1.5
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2,),
//        GestureDetector(
//          onTap: () {
//            setState(() {
//              isBtnSelected = 0;
//            });
//          },
//          child: Container(
//              margin: const EdgeInsets.symmetric(horizontal: 8),
//              width: SizeConfig.blockSizeHorizontal * 40,
//              height: SizeConfig.blockSizeVertical * 8,
//              decoration: BoxDecoration(
//                border: Border.all(
//                    color: isBtnSelected == 0
//                        ? Colors.white
//                        : primaryColor,
//                    width: 2),
//                borderRadius: BorderRadius.all(Radius.circular(16)),
//                color: isBtnSelected == 0
//                    ? primaryColor
//                    : Colors.white,
//              ),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Icon(
//                    FontAwesomeIcons.wpexplorer,
//                    color: isBtnSelected == 0
//                        ? Colors.white
//                        : primaryColor,
//                  ),
//                  SizedBox(
//                    height: SizeConfig.blockSizeHorizontal * 2,
//                  ),
//                  Text(
//                    'Explorer',
//                    style: isBtnSelected == 0
//                        ? selectedTextColor
//                        : unSelectedTextColor,
//                  )
//                ],
//              )),
//        ),
      ],
    );

  }
}