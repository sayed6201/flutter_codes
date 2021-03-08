import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:crowdv/widgets/rounded_button.dart';
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

class QuizOPtionScreen extends StatefulWidget {
  static final String tag = "QuizOPtionScreen";

  QuizOPtionScreen();

  @override
  _QuizOPtionScreenState createState() => _QuizOPtionScreenState();
}

class _QuizOPtionScreenState extends State<QuizOPtionScreen> {
  var _isInit = true;
  var _isLoading = true;
  var header_text = "Quiz";
  List<dynamic> questionOptionList = [];
  Map<String, dynamic> selectedQuizQuestion = {};
  Map<String, double> quizScoreMap = {};
  String _selectedId = "-1";

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<AuthProvider>(context, listen: false).fetchQuizOptions();
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

    selectedQuizQuestion = Provider.of<AuthProvider>(context).getSelectedQuizQuestion;
//    print("isloading-selectedQuizQuestion ${selectedQuizQuestion.toString()}");

    questionOptionList = Provider.of<AuthProvider>(context).getQuizOption;


    print("questionOptionList-length-ui:  ${questionOptionList.length}");

    return Scaffold(
      body: Stack(children: [
        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        SingleChildScrollView(
          child:Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15, bottom: SizeConfig.blockSizeVertical * 5),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      elevation: 5,
                      child: Container(
                        padding:
                        EdgeInsets.all(0),
                        child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 5,
                                    color:
                                    primaryColor,
                                  ),
//                                  Container(
//                                    margin: EdgeInsets
//                                        .symmetric(
//                                      vertical: 10,
//                                      horizontal: 15,
//                                    ),
//                                    decoration:
//                                    BoxDecoration(
//                                      border:
//                                      Border.all(
//                                        color: Colors
//                                            .purple,
//                                        width: 2,
//                                      ),
//                                    ),
//                                    padding:
//                                    EdgeInsets
//                                        .all(10),
//                                    child: Icon(
//                                      FontAwesomeIcons.solidQuestionCircle,
//                                      color: primaryColor,
//                                    ),
//                                  ),
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
                                                    "Question" ,
                                                    style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 1.8, fontWeight: FontWeight.w500, color: Colors.black38),
                                                  ),
                                                  padding: EdgeInsets.only(left: 10),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  border: Border.all(color: Colors.blue),
                                                  borderRadius: BorderRadius.circular(100),
                                                ),
                                                child: Icon(Icons.done_all, color: Colors.white,),
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
                                                    Padding(
                                                      child: Text( selectedQuizQuestion["question_name"] ?? "N/A",
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            color: Colors.black38,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                                                          )),
                                                      padding: EdgeInsets.only(left: 10),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig.blockSizeVertical * 1,
                                                    ),
                                                  ],
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 5,),
                    child: _isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : (questionOptionList.length == 0
                        ? NoData(
                      text:
                      "No Option found...",
                    )
                        :
                    Wrap(
                      children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                            bottom: SizeConfig.blockSizeHorizontal * 15,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return
                              CheckboxListTile(
                                dense: true,
//                                groupValue: questionOptionList,
                                value: index.toString() == _selectedId ? true : false,
                                onChanged: (v){
                                  if(mounted){
                                    setState(() {
                                      print("v: $v");
                                      if(index.toString() == _selectedId){
                                      }
                                      else{
                                        _selectedId = index.toString();
                                      }
                                    });
                                  }
                                },
                                title:  Text(questionOptionList[index]["option_name"] ?? "N/A",
                                  style: TextStyle(fontSize: 13),),
                                controlAffinity: ListTileControlAffinity.leading,
    //                     subtitle: new Text('Subtitle'),
    //                     secondary:  Icon(Icons.bookmark, color: primaryColor,),
                                activeColor: Colors.red,

                              );
                          },
                          itemCount: questionOptionList.length,
                        )
                      ],
                    )
                    )),
                SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                Center(
                  child: RoundedButton(
                    press: (){
                      print("_selectedId : $_selectedId ");
                      if(_selectedId == "-1") return;
                      quizScoreMap = Provider.of<AuthProvider>(context,listen: false).getQuizScoresMap;
                      quizScoreMap[selectedQuizQuestion["id"].toString()] = double.parse(questionOptionList[int.parse(_selectedId)]["score"].toString());
                      print("UI ${quizScoreMap.toString()}");
                      Provider.of<AuthProvider>(context,listen: false).setQuizScore(data: quizScoreMap);
                      Navigator.of(context).pop();
                    },
                    color: primaryColor,
                    text: "Save Answer",
                    textColor: Colors.white,
                  ),
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
    );
  }
}
