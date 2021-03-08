import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/widgets/home_widget_loder.dart';
import 'package:crowdv/widgets/time1.dart';
import 'package:crowdv/widgets/time2.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class BookingScreen extends StatefulWidget {
  static final String tag = "/BookingScreen";
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String title_text = "Book Appointment";
  String btn_text = "Book Schedule";
  List<String> gender = [
    "Male",
    "Female",
    "Other"
  ];

  Map<String,String> routeData= {};

  var problemDescriptionController = TextEditingController();
  
  var _isLoading = false;
  var isBtnSelected = 0;
  var _isInit = true;
  Map<String,dynamic> doctorInfo = {};
  Map<String,dynamic> bookingTime={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isInit){
//      routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;
//      print(routeData['title']+" - "+routeData['btn_text']);
//      setState(() {
//        title_text = routeData['title'];
//        btn_text = routeData['btn_text'];
//      });
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    doctorInfo = Provider.of<GuestProvider>(context).getSelectedDoctorInfo;
    bookingTime = Provider.of<AuthProvider>(context).getBookingDateTime;

    //problem description++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final problemDesController = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: problemDescriptionController,
      maxLines: 3,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Write problem description',
        icon: Icon(Icons.description),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );


    //registration Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final bookBtn = Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 0),
        child: RaisedButton(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: validation,
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              btn_text,
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );

    

    final formUi = Form(
      key: _formKey,
      autovalidate: true,
      child:
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: SizeConfig.blockSizeVertical * 4.0),

          DateTimePickerWidget2(),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: problemDesController,),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          _isLoading ?
          Center(child: CircularProgressIndicator(),)
              :
          bookBtn,
          SizedBox(height: SizeConfig.blockSizeVertical * 5),
        ],
      ),
    );

    return Scaffold(
        body:

        Provider.of<AuthProvider>(context).getUserRoleID == GUEST_ROLE_ID ?
        HomeWidgetLoader() :

      //in stack widgets are placed on top of each other================================================================
        Stack(children: [
          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
            top: SizeConfig.blockSizeVertical * 15,
            left: 5,
            right: 5,
            child:Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0, bottom: SizeConfig.blockSizeVertical * 5),
              height: SizeConfig.blockSizeVertical * 85,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5
              ),
              child: formUi,
            ),
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
                            "",
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                    Column(
                      children: <Widget>[
                        Text(
                          title_text,
                          style: heading_style.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
//                    Container(
//                      margin: EdgeInsets.only(
//                          top: SizeConfig.blockSizeVertical * 0.5),
//                      child: Icon(
//                        FontAwesomeIcons.search,
//                        color: Colors.white70,
//                      ),
//                    ),
                      ],
                    )
                  ],
                ),
              )),
        ]));
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
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 10,bottom: 0),
              child: Text(
                "Gender:",
                style: heading_style.copyWith(
                    color: Colors.black38,
                    fontSize: SizeConfig.blockSizeVertical * 2.3
                ),
              ),
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isBtnSelected = 0;
                });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) =>
//
//                ),
//              );
              },
              child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeHorizontal * 20,
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
                      Icon(
                        FontAwesomeIcons.male,
                        color: isBtnSelected == 0
                            ? Colors.white
                            : Theme
                            .of(context)
                            .primaryColor,
                        size: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Flexible(
                        child: Text(
                          "Male",
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
              onTap: () {
                setState(() {
                  isBtnSelected = 1;
                });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) =>
//
//                ),
//              );
              },
              child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeHorizontal * 20,
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
                      Icon(
                        FontAwesomeIcons.female,
                        color: isBtnSelected == 1
                            ? Colors.white
                            : Theme
                            .of(context)
                            .primaryColor,
                        size: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Flexible(
                        child: Text(
                          "Female",
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
    if(
    problemDescriptionController.text.toString().trim().isEmpty ||
    bookingTime["date"] == null || bookingTime["time"] == null
    ){
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
    }else{

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      try{

        await Provider.of<AuthProvider>(context,listen: false).bookSchedule(
            problem: problemDescriptionController.text.toString().trim(),
            REQRUITER_ROLE_ID: doctorInfo["id"]);

        setState(() {
          _isLoading = false;
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
                      child: Text(msg[SUCCESS_BOOKIING_MSG],
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
//                  Navigator.pushAndRemoveUntil(
//                    context,
//                    MaterialPageRoute(builder: (context) => LoginScreen()),
//                    ModalRoute.withName(UserChooseScreen.tag),
//                  );
                },
              )
            ],
          ),
        );

        Navigator.of(context).pop();

      }catch(e){
        setState(() {
          _isLoading = false;
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
                      child: Text(msg[ERR_MSG_REG],
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
}
