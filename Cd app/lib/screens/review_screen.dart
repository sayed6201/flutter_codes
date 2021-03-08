import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';


class ReviewScreen extends StatefulWidget {
  static final String tag = "/ReviewScreen";
  String serviceID;
  String serviceType;
  ReviewScreen();
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var complainController =  TextEditingController();
  final GlobalKey<FormState> _formKeyComplain = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyReview = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var header_text = "Review ";
  var _isLoadingReview = false;
  var _isLoadingComplain = false;

  double service = 3.5;
  double organisation = 3.5;
  double friendliness = 3.5;
  double area_expert = 3.5;
  double safety = 3.5;
  var isBtnSelected = 0;


  @override
  Widget build(BuildContext context) {

//    print('type ${widget.serviceType} - id ${widget.serviceID}');



    //complainFiled++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final complainFiled = TextFormField(
      keyboardType: TextInputType.text,
      controller: complainController,
      autofocus: false,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Write Your Comaplain',
        icon: Icon(Icons.report_problem),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //registration Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final submitBtn = Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 0),
        child: RaisedButton(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: (){
            validationComplain();
          },
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Submit Complain",
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );

    final formUi = Form(
      key: _formKeyComplain,
      autovalidate: true,
      child:
      Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: complainFiled,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 3),

          _isLoadingComplain ?
          Center(child: CircularProgressIndicator(),)
              :
          submitBtn,
          SizedBox(height: SizeConfig.blockSizeVertical * 5),

        ],
      ),
    );

    final title = TextFormField(
      keyboardType: TextInputType.text,
      controller: titleController,
      autofocus: false,
//        initialValue: userData['first_name'] == null ? "" : userData['first_name'],
      validator: (val) {
        if (val.isEmpty) {
          return "must be filled";
        } else {
          return null;
        }
      },
      onSaved: (String val) {
      },
      decoration: InputDecoration(
        hintText: "Write review",
        icon: Icon(Icons.title),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    final content = TextFormField(
      keyboardType: TextInputType.text,
      controller: contentController,
      autofocus: false,
      maxLines: 4,
//        initialValue: userData['first_name'] == null ? "" : userData['first_name'],
      validator: (val) {
        if (val.isEmpty) {
          return "must be filled";
        }
        else if (val.length < 10) {
          return "review content is too short, at least 10 character required";
        }
        else {
          return null;
        }
      },
      onSaved: (String val) {

      },
      decoration: InputDecoration(
        hintText: "Review content",
        icon: Icon(Icons.rate_review),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    final saveButton = Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: validation,
          padding: EdgeInsets.all(12),
          color: Theme.of(context).primaryColor,
          child:
          Text(
              "Leave a review",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    return
      MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab( text: "Review",),
                  Tab( text: "Complain",)
                ],
              ),
              title: Text('Feedback'),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                    child:
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 5,
                          left: 10,
                          right: 10
                      ),
                      child:  Form(
                          key: _formKeyReview,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30,),
                              title,
                              SizedBox(height: 10,),
                              content,
                              SizedBox(height: 50,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(color: Colors.black12,thickness: 5,height: 5,),
                              ),
                              SizedBox(height: 20,),

                              //service+++++++++++++++++++
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Overall rating",
                                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  RatingBar(
                                    itemSize: 30,
                                    initialRating: 3.5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 0.4),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      service = rating;
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 40,),

                              _isLoadingReview ?
                              Center(child: CircularProgressIndicator(),) :
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: saveButton,
                              ),
                              SizedBox(height: 20,)
                            ],
                          )),
                    )

                ),
                //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
                SingleChildScrollView(
                  child:Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5, bottom: SizeConfig.blockSizeVertical * 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 5
                    ),
                    child: formUi,
                  ),
                )
              ],
            ),
          ),
        ),
      );
//      Scaffold(
//        body: Stack(children: [
//
//          isBtnSelected == 0 ?
//          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
//          SingleChildScrollView(
//              child:
//
//              Container(
//                margin: EdgeInsets.only(
//                    top: SizeConfig.blockSizeVertical * 17,
//                    left: 10,
//                    right: 10
//                ),
//                child:  Form(
//                    key: _formKeyReview,
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(height: 30,),
//                        title,
//                        SizedBox(height: 10,),
//                        content,
//                        SizedBox(height: 50,),
//                        Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 20),
//                          child: Divider(color: Colors.black12,thickness: 5,height: 5,),
//                        ),
//                        SizedBox(height: 20,),
//
//                        //service+++++++++++++++++++
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(left: 10),
//                              child: Text(
//                                "Overall rating",
//                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
//                              ),
//                            ),
//                            SizedBox(width: 10,),
//                            RatingBar(
//                              itemSize: 30,
//                              initialRating: 3.5,
//                              direction: Axis.horizontal,
//                              allowHalfRating: true,
//                              itemCount: 5,
//                              itemPadding: EdgeInsets.symmetric(horizontal: 0.4),
//                              itemBuilder: (context, _) => Icon(
//                                Icons.star,
//                                color: Colors.amber,
//                              ),
//                              onRatingUpdate: (rating) {
//                                service = rating;
//                                print(rating);
//                              },
//                            ),
//                          ],
//                        ),
//                        SizedBox(height: 40,),
//                        isLoadingReview ?
//                        Center(child: CircularProgressIndicator(),) :
//                        Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 10),
//                          child: saveButton,
//                        ),
//                        SizedBox(height: 20,)
//                      ],
//                    )),
//              )
//
//          ) :
//          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
//          SingleChildScrollView(
//            child:Container(
//              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 30, bottom: SizeConfig.blockSizeVertical * 5),
//              padding: EdgeInsets.symmetric(
//                  horizontal: SizeConfig.blockSizeHorizontal * 5
//              ),
//              child: formUi,
//            ),
//          ),
//
//          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//          Positioned(
//              top: 0.0,
//              left: 0.0,
//              right: 0.0,
//              child: Container(
//                height: SizeConfig.blockSizeVertical * 17,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                  color: primaryColor,
//                  borderRadius: BorderRadius.only(
//                    bottomLeft: Radius.circular(45.0),
//                    bottomRight: Radius.circular(45.0),
//                  ),
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey,
//                      offset: Offset(0.0, 1.0), //(x,y)
//                      blurRadius: 6.0,
//                    ),
//                  ],
//                ),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    SizedBox(
//                      height: SizeConfig.statusBarSize,
//                    ),
//                    //app-bar data=========================================
//                    Align(
//                        alignment: Alignment.center,
//                        child: Text(
//                          header_text,
//                          style: heading_style.copyWith(
//                            fontSize: SizeConfig.blockSizeVertical * 2,
//                          ),
//                        )
//                    ),
//                    Divider(),
//                    buildButton(),
////                    Column(
////                      children: <Widget>[
////                        Text(
////                          catagory_text,
////                          style: heading_style.copyWith(
////                            fontSize: SizeConfig.blockSizeVertical * 2,
////                          ),
////                        ),
////                      ],
////                    )
//                  ],
//                ),
//              )),
//        ]),
//      );
  }

  Widget buildButton() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.bold,
        color: Theme
            .of(context)
            .primaryColor);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async{
                setState(() {
                  isBtnSelected = 0;
//                  _isLoading = true;
                });
//                await Provider.of<AuthProvider>(context,listen: false).fetchGeneralNotification();
//                setState(() {
//                  _isLoading = false;
//                });
              },
              child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isBtnSelected == 0
                            ? Colors.white
                            : Theme
                            .of(context)
                            .primaryColor,
                        width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: isBtnSelected == 0
                        ? Theme
                        .of(context)
                        .primaryColor
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.male,
//                        color: isBtnSelected == 0
//                            ? Colors.white
//                            : Theme
//                            .of(context)
//                            .primaryColor,
//                        size: SizeConfig.blockSizeHorizontal * 7,
//                      ),
//                      SizedBox(
//                        height: SizeConfig.blockSizeVertical * 1,
//                      ),
                      Flexible(
                        child: Text(
                          "Review",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: isBtnSelected == 0
                              ? selectedTextColor
                              : unSelectedTextColor,
                        ),
                      )
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () async{
                setState(() {
                  isBtnSelected = 1;
//                  _isLoading = true;
                });
//                await Provider.of<AuthProvider>(context,listen: false).fetchSpecificNotification();
//                setState(() {
//                  _isLoading = false;
//                });
              },
              child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isBtnSelected == 1
                            ? Colors.white
                            : Theme
                            .of(context)
                            .primaryColor,
                        width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: isBtnSelected == 1
                        ? Theme
                        .of(context)
                        .primaryColor
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.female,
//                        color: isBtnSelected == 1
//                            ? Colors.white
//                            : Theme
//                            .of(context)
//                            .primaryColor,
//                        size: SizeConfig.blockSizeHorizontal * 7,
//                      ),
//                      SizedBox(
//                        height: SizeConfig.blockSizeVertical * 1,
//                      ),
                      Flexible(
                        child: Text(
                          "Complain",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: isBtnSelected == 1
                              ? selectedTextColor
                              : unSelectedTextColor,
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ],
    );
  }

  void validation() async{

    if (
    contentController.text.toString() != ""
    ){
      print("validation success");

      setState(() {
        _isLoadingReview = true;
      });

      print("validation started");

      try{

          await Provider.of<AuthProvider>(context,listen: false).submitReviewRecruiter(
            comments: contentController.text.toString(),
            ratings: service.toString()
          );

          setState(() {
            _isLoadingReview = false;
          });
          contentController.clear();
          titleController.clear();
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
                        child: Text("Your Review Submitted Successfully",
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
                  },
                )
              ],
            ),
          );

      }catch(e){
        setState(() {
          _isLoadingReview = false;
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
    }else{
      print("validation falied");
      setState(() {
        _isLoadingReview = false;
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
                    child: Text(msg[CRED_FILL],
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

  void validationComplain() async{

    if (complainController.text.toString() != "") {
      print("validation success");

      setState(() {
        _isLoadingComplain = true;
      });

      print("validation started");


      try{
        await Provider.of<AuthProvider>(context,listen: false).submitComplainRecruiter(
          details: complainController.text.toString(),
        );

        setState(() {
          _isLoadingComplain = false;
        });

        complainController.clear();

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
                      child: Text("Your Complain Submitted successfully",
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
                },
              )
            ],
          ),
        );

      }catch(e){
        setState(() {
          _isLoadingComplain = false;
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
    }else{
      print("validation falied");
      setState(() {
        _isLoadingComplain = false;
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
                    child: Text(msg[CRED_FILL],
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
