import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/screens/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class VerifyEmail extends StatefulWidget {
  static final String tag = "VerifyEmail";

  VerifyEmail();

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  var _isSubmissionLoading = false;
  var header_text = "Verify Email";
  List<dynamic> quizQuestionList = [];
  Map<String, double> quizScoreMap = {};
  String url = "";

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
                SizedBox(height: SizeConfig.blockSizeVertical * 30,),
                Text("Welcome To CrowdV\n Before you start you must verify your email address", textAlign: TextAlign.center,  style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400, fontSize: 19),),
                Center(
                  child:
                  _isSubmissionLoading ?
                  CircularProgressIndicator () :
                  RaisedButton(
                    color: primaryColor,
                    child: Text("Click here to request for verification link", style: TextStyle(color: Colors.white),),
                    onPressed: validate,
                  ),
                )
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
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, UserChooseScreen.tag);
                              },
                            ),
                          )),
                      Expanded(
                        child: Text(
                          header_text,
                          textAlign: TextAlign.center,
                          style: heading_style.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 2,),
                        ),
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(" ")))
                    ],
                  ),
//                    Divider(),
//                  SizedBox(
//                    height: SizeConfig.blockSizeVertical * 0.5,
//                  ),
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
    );
  }

  void validate() async{

    setState(() {
      _isSubmissionLoading = true;
    });

    print("validation started");

    try{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Text("Verifying"),
          content:
          Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Sending Verification link to Your Email")
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
          ],
        ),
      );

      await Provider.of<AuthProvider>(context, listen: false).verifyEmail();

      setState(() {
        _isSubmissionLoading = false;
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
                      "Verification Link sent to your email\nPlease verify and login again",
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
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, UserChooseScreen.tag);
              },
            )
          ],
        ),
      );

    }catch(e){
      setState(() {
        _isSubmissionLoading = false;
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