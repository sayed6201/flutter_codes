import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../color_file.dart';
import '../text_style.dart';

class TutorialScreen extends StatefulWidget {
  static final String tag = "TutorialScreen";

  TutorialScreen();

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  var _isInit = true;
  var _isLoading = true;
  var _isSubmissionLoading = false;
  var header_text = "Tutorial";
  List<dynamic> quizQuestionList = [];
  Map<String, double> quizScoreMap = {};
  String url = "";

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      url =
      await Provider.of<AuthProvider>(context, listen: false).fetchTutorial();
      _isInit = false;
      if (mounted) {
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
    quizScoreMap = Provider
        .of<AuthProvider>(context)
        .getQuizScoresMap;
    print("is Loading-quizScoreMap:  ${quizScoreMap.toString()}");

    quizQuestionList = Provider
        .of<AuthProvider>(context)
        .getQuizQuestion;


    print("quizQuestionList-length-ui:  ${quizQuestionList.length}");

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
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 5,
                        bottom: SizeConfig.blockSizeVertical * 5),
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        :
                    InkWell(
                      child: Icon(FontAwesomeIcons.youtube, size: 90,color: Colors.red,),
                      onTap: ()async{
                        try {
                          await _launchurl();
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (ctx) =>
                                AlertDialog(
                                  title: Text("Sorry Can't not Open Youtube"),
                                  content: Wrap(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                                height: 50.0,
                                                child: Text(
                                                    "Invalid URL"
                                                )
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                        ],
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    InkWell(
                                      child: Text("Ok"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                          );
                        }
                      },
                    ),
                ),
                Text("Make Sure You watch the tutorial before attempting Quiz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black45
                  ),
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
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(
              QuizScreen.tag
          );
        },
        child: Container(
          height: SizeConfig.blockSizeVertical * 7,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              color: primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
//                  Icon(
//                    Icons.done_outline,
//                    color: Colors.white,
//                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Text(
                    "Proceed to Quiz",
                    style: TextStyle(color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchurl() async {
    if (Theme
        .of(context)
        .platform == TargetPlatform.iOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw url;
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}