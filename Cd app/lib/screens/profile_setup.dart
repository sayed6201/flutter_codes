
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/auth_screens/login_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';
import 'auth_screens/user_choosing_screen.dart';

class ProfileSetup extends StatefulWidget {
  static final String tag  ="/ProfileSetup";
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

   String title_text = "Profile Setup";
   String btn_text = "Register";
   List<String> gender = [
    "Male",
    "Female",
    "Other"
  ];

  Map<String,String> routeData= {};

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var nidController = TextEditingController();
  var ageController = TextEditingController();

  var _isLoading = false;
  var isBtnSelected = 0;
  var _isInit = true;
  var _profieCase = "1";

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
      routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;
      print(routeData['title']+" - "+routeData['btn_text']);
      setState(() {
        title_text = routeData['title'];
        btn_text = routeData['btn_text'];
        _profieCase = routeData['is_signup'];
      });
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {


    //name++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final name = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: nameController,
      validator: (val) {
        if (val.isEmpty) {
          return "must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Your name',
        icon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //Email++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return "must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Email',
        icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //address++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final address = TextFormField(
      keyboardType: TextInputType.text,
      controller: addressController,
      autofocus: false,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Location',
        icon: Icon(Icons.location_on),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );


    //Nid++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final nId = TextFormField(
      keyboardType: TextInputType.number,
      controller: nidController,
      autofocus: false,
      validator:(val){
        if (val.isEmpty) {
          return "must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'National ID number',
        icon: Icon(Icons.credit_card),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );


    //age++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final age = TextFormField(
      keyboardType: TextInputType.number,
      controller: ageController,
      autofocus: false,
      validator:(val){
        if (val.isEmpty) {
          return "must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter age',
        icon: Icon(Icons.credit_card),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );


    //registration Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final regButton = Container(
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
      Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: name,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: age,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          if(_profieCase == "1")
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: email,
          ),
          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: address,
          ),

          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2),

          if(_profieCase == "1")
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: nId,
          ),


          SizedBox(height: SizeConfig.blockSizeVertical * 3),

          buildButton(),

          SizedBox(height: SizeConfig.blockSizeVertical * 3),

          _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          )
              :regButton,
          SizedBox(height: SizeConfig.blockSizeVertical * 5),

        ],
      ),
    );

    return Scaffold(
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [
          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          SingleChildScrollView(
              child:Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15, bottom: SizeConfig.blockSizeVertical * 5),
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
                            title_text,
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
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          title_text,
//                          style: heading_style.copyWith(
//                            fontSize: SizeConfig.blockSizeVertical * 2,
//                          ),
//                        ),
////                    Container(
////                      margin: EdgeInsets.only(
////                          top: SizeConfig.blockSizeVertical * 0.5),
////                      child: Icon(
////                        FontAwesomeIcons.search,
////                        color: Colors.white70,
////                      ),
////                    ),
//                      ],
//                    )
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
    if(_profieCase == "1"){
      if(
      nameController.text.toString().isEmpty ||
          emailController.text.toString().isEmpty ||
          ageController.text.toString().isEmpty ||
          addressController.text.toString().isEmpty ||
          nidController.text.toString().isEmpty
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
        return;
      }
    }

    if(_profieCase != "1"){
      if(
      nameController.text.toString().isEmpty ||
          ageController.text.toString().isEmpty ||
          addressController.text.toString().isEmpty
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
        return;
      }
    }

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      try{

        if(_profieCase == "1"){
          Map<String,dynamic> regData = Provider.of<AuthProvider>(context, listen: false).getInsertedUserInfoForReg;

          await Provider.of<AuthProvider>(context,listen: false).setRegUserInfo(
              password: regData["password"],
              phone: regData["phone"],
              address: addressController.text.toString().trim(),
              age: ageController.text.toString().trim(),
              email: emailController.text.toString().trim(),
              gender: gender[isBtnSelected],
              name: nameController.text.toString().trim(),
              nid: nidController.text.toString().trim()
          );

          await Provider.of<AuthProvider>(context, listen: false).memberRegister();


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
                        child: Text(msg[SUCCESS_REG_MSG],
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      ModalRoute.withName(UserChooseScreen.tag),
                    );
                  },
                )
              ],
            ),
          );
        }
        else{

          await Provider.of<AuthProvider>(context,listen: false).updateProfile(
              name: nameController.text.toString().trim(),
              gender: gender[isBtnSelected],
              age: ageController.text.toString().trim(),
              address: addressController.text.toString().trim()
          );

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
                        child: Text("Profile Updated Successfully",
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
        }
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
