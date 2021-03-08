import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/quiz_option_screen.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class QuizScreen extends StatefulWidget {
  static final String tag = "QuizScreen";

  QuizScreen();

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var _isInit = true;
  var _isLoading = true;
  var _isSubmissionLoading = false;
  var header_text = "Quiz";
  List<dynamic> quizQuestionList = [];
  Map<String, double> quizScoreMap = {};

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<AuthProvider>(context, listen: false).fetchQuizQuestion();
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

    quizScoreMap = Provider.of<AuthProvider>(context).getQuizScoresMap;
    print("is Loading-quizScoreMap:  ${quizScoreMap.toString()}");

    quizQuestionList = Provider.of<AuthProvider>(context).getQuizQuestion;


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
                    height: SizeConfig.blockSizeVertical * 85,
                    child: _isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : (quizQuestionList.length == 0
                        ? NoData(
                      text:
                      "No Question found...",
                    )
                        : ListView.builder(
                      padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 1,
                        left: SizeConfig.blockSizeHorizontal * 3,
                        right: SizeConfig.blockSizeHorizontal * 3,
                        bottom: SizeConfig.blockSizeHorizontal * 15,
                      ),
                      itemBuilder: (ctx, index) {
                        return
                          InkWell(
                            onTap: () {
                              Provider.of<AuthProvider>(context,listen: false).setQuizQuestion(data: quizQuestionList[index]);
                              Navigator.of(context).pushNamed(QuizOPtionScreen.tag);
                            },
                          child:
                          Container(
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(
                                left: SizeConfig
                                    .blockSizeHorizontal *
                                    1,
                                right: SizeConfig
                                    .blockSizeHorizontal *
                                    1,
                                top: SizeConfig
                                    .blockSizeVertical *
                                    1,
                                bottom: SizeConfig
                                    .blockSizeVertical *
                                    1),
                            child: Card(
                                elevation: 10,
                                child: Container(
                                    padding:
                                    EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 5,
                                          color:
                                          primaryColor,
                                        ),
//                                        Container(
//                                          margin: EdgeInsets
//                                              .symmetric(
//                                            vertical: 10,
//                                            horizontal: 15,
//                                          ),
//                                          decoration:
//                                          BoxDecoration(
//                                            border:
//                                            Border.all(
//                                              color: Colors
//                                                  .purple,
//                                              width: 2,
//                                            ),
//                                          ),
//                                          padding:
//                                          EdgeInsets
//                                              .all(10),
//                                          child: Icon(
//                                            FontAwesomeIcons.solidQuestionCircle,
//                                            color: primaryColor,
//                                          ),
//                                        ),
                                        Expanded(
                                          child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .end,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child:
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(top: 10, right: 10),
                                                        child:
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Padding(
                                                                    child: Text(
                                                                      "Question: ${index+1}",
                                                                      style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 1.8, fontWeight: FontWeight.w500, color: Colors.black38),
                                                                    ),
                                                                    padding: EdgeInsets.only(left: 10),
                                                                  )
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blue,
                                                                    border: Border.all(color: Colors.white),
                                                                    borderRadius: BorderRadius.circular(100),
                                                                  ),
                                                                  child:
                                                                  Icon(
                                                                    quizScoreMap.containsKey(quizQuestionList[index]["id"].toString()) ?
                                                                    Icons.done_all :
                                                                    Icons.donut_large,
                                                                    color: Colors.white,),
                                                                )
                                                              ],
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(right: 10),
                                                              child: Divider(
                                                                color: Colors.black38,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      SizedBox(
                                                                      height: SizeConfig.blockSizeVertical * 1,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 5),
                                                                        child: Text("" + quizQuestionList[index]["question_name"] ?? "N/A",
                                                                            textAlign: TextAlign.left,
                                                                            style: TextStyle(
                                                                              color: Colors.black38,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: SizeConfig.blockSizeVertical * 1.7,
                                                                            )),
                                                                      ),
                                                                      SizedBox(
                                                                        height: SizeConfig.blockSizeVertical * 1,
                                                                      ),
//                                                                      Text("Address: " + quizQuestionList[index]["location"],
//                                                                          textAlign: TextAlign.left,
//                                                                          style: TextStyle(
//                                                                            color: Colors.black38,
//                                                                            fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                          )),
                                                                    ],
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  ),
                                                                ),
//                                                                Container(
//                                                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                  margin: EdgeInsets.only(top: 5),
//                                                                  decoration: BoxDecoration(
//                                                                    color: primaryColor,
//                                                                    border: Border.all(color: primaryColor),
//                                                                    borderRadius: BorderRadius.circular(100),
//                                                                  ),
//                                                                  child: Text("Status: " + quizQuestionList[index]["status"],
//                                                                      style: TextStyle(
//                                                                        color: Colors.white,
//                                                                        fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                      )),
//                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                  Alignment
                                                      .centerRight,
                                                  child: Padding(
                                                      padding: EdgeInsets.only(bottom: 0, right: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: <Widget>[
                                                              IconButton(
                                                                onPressed: () {
                                                                  Provider.of<AuthProvider>(context,listen: false).setQuizQuestion(data: quizQuestionList[index]);
                                                                  Navigator.of(context).pushNamed(QuizOPtionScreen.tag);
                                                                },
                                                                color: Theme.of(context)
                                                                    .primaryColor,
                                                                icon:
                                                                quizScoreMap.containsKey(quizQuestionList[index]["id"].toString()) ?
                                                                Icon(Icons.done_outline,):
                                                                Icon(Icons.keyboard_arrow_right),
                                                              ),
//                                                          RaisedButton(
//                                                            child: Text("Apply", style: TextStyle(color: Colors.white),),
//                                                            color: primaryColor,
//                                                            onPressed: () async {
//                                                              try {
//                                                                showDialog(
//                                                                  context: context,
//                                                                  barrierDismissible: false,
//                                                                  builder: (ctx) => AlertDialog(
//                                                                    title: Text(msg[SUCCESS_TITLE]),
//                                                                    content: Wrap(
//                                                                      children: <Widget>[
//                                                                        Column(
//                                                                          crossAxisAlignment: CrossAxisAlignment.center,
//                                                                          mainAxisAlignment: MainAxisAlignment.center,
//                                                                          children: <Widget>[
//                                                                            Align(
//                                                                              alignment: Alignment.center,
//                                                                              child: SizedBox(height: 50.0, child: CircularProgressIndicator()),
//                                                                            ),
//                                                                            SizedBox(
//                                                                              height: 20,
//                                                                            ),
//                                                                            Align(
//                                                                              alignment: Alignment.center,
//                                                                              child: Text(
//                                                                                "Submitting Application For this opportunity",
//                                                                                textAlign: TextAlign.center,
//                                                                              ),
//                                                                            )
//                                                                          ],
//                                                                        )
//                                                                      ],
//                                                                    ),
//                                                                    actions: <Widget>[
//                                                                      FlatButton(
//                                                                        child: Text('Okay'),
//                                                                        onPressed: () {
//                                                                          Navigator.of(ctx).pop();
////                                                                            Navigator.pushAndRemoveUntil(
////                                                                              context,
////                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
////                                                                              ModalRoute.withName(UserChooseScreen.tag),
////                                                                            );
//                                                                        },
//                                                                      )
//                                                                    ],
//                                                                  ),
//                                                                );
//                                                                await Provider.of<AuthProvider>(context, listen: false).volApplyForOpportunity(
//                                                                  oppurtunities_id: quizQuestionList[index]["id"],
//                                                                );
//                                                                Navigator.of(context).pop();
//                                                                await showDialog(
//                                                                  context: context,
//                                                                  barrierDismissible: false,
//                                                                  builder: (ctx) => AlertDialog(
//                                                                    title: Text(msg[SUCCESS_TITLE]),
//                                                                    content: Wrap(
//                                                                      children: <Widget>[
//                                                                        Column(
//                                                                          crossAxisAlignment: CrossAxisAlignment.center,
//                                                                          mainAxisAlignment: MainAxisAlignment.center,
//                                                                          children: <Widget>[
//                                                                            Align(
//                                                                              alignment: Alignment.center,
//                                                                              child: SizedBox(
//                                                                                  height: 50.0,
//                                                                                  child: Image.asset(
//                                                                                    SUCCESS,
//                                                                                    fit: BoxFit.contain,
//                                                                                  )),
//                                                                            ),
//                                                                            SizedBox(
//                                                                              height: 20,
//                                                                            ),
//                                                                            Align(
//                                                                              alignment: Alignment.center,
//                                                                              child: Text(
//                                                                                msg[SUCCESS_REG_MSG],
//                                                                                textAlign: TextAlign.center,
//                                                                              ),
//                                                                            )
//                                                                          ],
//                                                                        )
//                                                                      ],
//                                                                    ),
//                                                                    actions: <Widget>[
//                                                                      FlatButton(
//                                                                        child: Text('Okay'),
//                                                                        onPressed: () {
//                                                                          Navigator.of(ctx).pop();
////                                                                            Navigator.pushAndRemoveUntil(
////                                                                              context,
////                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
////                                                                              ModalRoute.withName(UserChooseScreen.tag),
////                                                                            );
//                                                                        },
//                                                                      )
//                                                                    ],
//                                                                  ),
//                                                                );
//                                                              } catch (e) {
//                                                                Navigator.of(context).pop();
//                                                                await showDialog(
//                                                                  context: context,
//                                                                  barrierDismissible: false,
//                                                                  builder: (ctx) => AlertDialog(
//                                                                    title: Text(msg[SUCCESS_TITLE]),
//                                                                    content: Wrap(
//                                                                      children: <Widget>[
//                                                                        Column(
//                                                                          crossAxisAlignment: CrossAxisAlignment.center,
//                                                                          mainAxisAlignment: MainAxisAlignment.center,
//                                                                          children: <Widget>[
//                                                                            Align(
//                                                                              alignment: Alignment.center,
//                                                                              child: SizedBox(
//                                                                                  height: 50.0,
//                                                                                  child: Image.asset(
//                                                                                    ERROR,
//                                                                                    fit: BoxFit.contain,
//                                                                                  )),
//                                                                            ),
//                                                                            SizedBox(
//                                                                              height: 20,
//                                                                            ),
//                                                                            Align(
//                                                                              alignment: Alignment.center,
//                                                                              child: Text(
//                                                                                e.toString(),
//                                                                                textAlign: TextAlign.center,
//                                                                              ),
//                                                                            )
//                                                                          ],
//                                                                        )
//                                                                      ],
//                                                                    ),
//                                                                    actions: <Widget>[
//                                                                      FlatButton(
//                                                                        child: Text('Okay'),
//                                                                        onPressed: () {
//                                                                          Navigator.of(ctx).pop();
////                                                                            Navigator.pushAndRemoveUntil(
////                                                                              context,
////                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
////                                                                              ModalRoute.withName(UserChooseScreen.tag),
////                                                                            );
//                                                                        },
//                                                                      )
//                                                                    ],
//                                                                  ),
//                                                                );
//                                                              }
//                                                            },
//                                                          )
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
                                              ]),
                                        )
                                      ],
                                    ))),
                          ),
                        );
                      },
                      itemCount: quizQuestionList.length,
                    ))),
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
                              alignment: Alignment.centerRight,
                              child: Text(" ")))
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
      bottomNavigationBar: InkWell(
        onTap: validation,
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
                  Icon(
                    Icons.done_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Text(
                    "Submit Answers",
                    style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2),
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

  void validation() async{
    double totalScore =0.0;

    if(quizScoreMap.length != quizQuestionList.length) {
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
                    child: Text("Please answer all the Questions",
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

    for(int i=0; i<quizScoreMap.length ; i++){
      totalScore += quizScoreMap[quizScoreMap.keys.toList()[i].toString()];
    }

    if(totalScore < 80) {
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
                    child: Text("Your Score is ${totalScore}\n Your Quiz Mark is below the acceptance level",
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


      print("validation success");

      setState(() {
        _isSubmissionLoading = true;
      });

      print("validation started");

      setState(() {
        _isSubmissionLoading = true;
      });

      print("validation started");

      try{
        showDialog(
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
          await Provider.of<AuthProvider>(context, listen: false).submitQuizResult();
          await Provider.of<AuthProvider>(context, listen: false).updateToGoldStatus();


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
                        "Quiz Submitted Successfully\nYour Score is $totalScore",
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
                    Navigator.of(context).pop();
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
