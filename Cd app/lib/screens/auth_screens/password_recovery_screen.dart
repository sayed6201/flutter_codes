
import 'package:crowdv/widgets/or_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../../color_file.dart';
import '../../string.dart';
import '../../text_style.dart';


class PasswordRecoveryScreen extends StatefulWidget {
  static final String tag  ="/PasswordRecoveryScreen";
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  List<String> gender = [
    "Male",
    "Female",
    "Others"
  ];

  Map<String,String> routeData= {};
  Map<String,dynamic> profileData = {};

  var emailController = TextEditingController();
  var emailController2 = TextEditingController();

  var urlLinkController = TextEditingController();

  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  var passObsecure = true;


  var _isLoading = false;
  var _isLoading2 = false;
  var isBtnSelected = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    if(_isInit){
//
//      await Provider.of<GuestProvider>(context).fetchExpertCatagoryList();
//
//      routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;
//
//      print(routeData['title']+" - "+routeData['btn_text']);
//
//      setState(() {
//        title_text = routeData['title'];
//        btn_text = routeData['btn_text'];
//        _profieCase = routeData['is_signup'];
//      });
//
//      if(_profieCase != "1"){
////        volunteers_id,address,occupation_name,instituation_name
//        profileData = Provider.of<AuthProvider>(context,listen: false).getAData;
//        nameController.text = profileData["volunteer_name"];
//        urlLinkController.text = profileData["address"];
//        InstituationNameController.text = profileData["instituation_name"];
//        occupationController.text =  profileData["occupation_name"];
////        nidFieldController.text = profileData["nid"];
//        print("data setup ${nameController.text} - ${urlLinkController.text}- ${InstituationNameController.text} - ${nidFieldController.text}");
//      }
//      caregoryId = Provider.of<GuestProvider>(context,listen: false).getCategoryMap;
//      setState(() {
//        _categoryName =  caregoryId.keys.toList()[0].toString();
//      });
//      await Provider.of<AuthProvider>(context,listen: false).fetchDisabilityList();
//      setState(() {
//        disabilityList =  Provider.of<AuthProvider>(context,listen: false).getDisabilityList;
//        _isLoading = false;
//      });
//      _isInit = false;
//    }
  }

  @override
  Widget build(BuildContext context) {

    //Email++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autovalidate: true,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
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

    //Email++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final email2 = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController2,
      autovalidate: true,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
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

    //Password+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final pass = TextFormField(
      keyboardType: TextInputType.text,
      controller: passController,
      autofocus: false,
      autovalidate: true,
      obscureText: passObsecure,
      cursorColor: primaryColor.withOpacity(0.4),
      validator: (val) {
        if (val.length < 6) {
          return"Password must be at lest 6 char long";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Password',
        icon: Icon(Icons.lock_open),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
          icon: Icon(
              passObsecure ? Icons.visibility : Icons.visibility_off,
              color: primaryColor
          ),
          onPressed: (){
            setState(() {
              passObsecure = ! passObsecure;
            });
          },
        ),
      ),
    );

    //Confirm Password+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final confPass = TextFormField(
      keyboardType: TextInputType.text,
      controller: confirmPassController,
      autofocus: false,
      autovalidate: true,
      obscureText: passObsecure,
      cursorColor: primaryColor.withOpacity(0.4),
      validator: (val) {
        if (passController.text.toString() != confirmPassController.text.toString() ) {
          return "Password Does not match";
        }
        else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Password',
        icon: Icon(Icons.lock_open),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
          icon: Icon(
            passObsecure ? Icons.visibility : Icons.visibility_off,
            color: primaryColor,
          ),
          onPressed: (){
            setState(() {
              passObsecure = ! passObsecure;
            });
          },
        ),
      ),
    );

    //urlLink++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final urlLink = TextFormField(
      keyboardType: TextInputType.text,
      autovalidate: true,
      controller: urlLinkController,
      autofocus: false,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Paste Url here',
        icon: Icon(Icons.link),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
    );

    //getCode Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final getCodeButton = Container(
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
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            validation();
          },
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Request for Url",
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );

    //updatePassButton+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final updatePassButton = Container(
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
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            validation2();
          },
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Update Password",
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
            child: email,
          ),

          
          SizedBox(height: SizeConfig.blockSizeVertical * 2),

          _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          )
              :getCodeButton,
          SizedBox(height: SizeConfig.blockSizeVertical * 5),

        ],
      ),
    );

    final formUi2 = Form(
      key: _formKey2,
      autovalidate: true,
      child:
      Column(
        children: <Widget>[

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: urlLink,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: email2,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: pass,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: confPass,
          ),


          SizedBox(height: SizeConfig.blockSizeVertical * 4),


          _isLoading2 ?
          Center(
            child: CircularProgressIndicator(),
          )
              :updatePassButton,
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
              child:
              Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
                  OrDivider("STEP:1 - Request For Url"),
                  formUi,

                  OrDivider("STEP:2 - Change Password"),
                  formUi2
                ],
              )
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            "Password Setup",
                            textAlign: TextAlign.center,
                            style: heading_style.copyWith(
                              fontSize: SizeConfig.blockSizeVertical * 1.8,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight, child: Text(" ")))
                      ],
                    ),
//                    Divider(),
//                    SizedBox(
//                      height: SizeConfig.blockSizeVertical * 1,
//                    ),
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



  void validation() async{

    if (_formKey.currentState.validate()) {

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      try{

          await Provider.of<AuthProvider>(context,listen: false).requestForTokenbyEmail(
              email: emailController.text.toString().trim()
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
                        child: Text("Token Link is sent to your email,\n Copy the Link and use in Step:2 to change the password",
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
    else{
      print("validation falied");
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

  void validation2() async{

    if (_formKey2.currentState.validate()) {

      setState(() {
        _isLoading2 = true;
      });

      print("validation started");

      try{

        await Provider.of<AuthProvider>(context,listen: false).resetPasswordWithToken(
            email: emailController2.text.toString().trim(),
            password: passController.text.toString().trim(),
            token: urlLinkController.text.toString().trim()
        );

        setState(() {
          _isLoading2 = false;
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
                      child: Text("Your Password has been Changed Successfully !",
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
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );

      }catch(e){
        setState(() {
          _isLoading2 = false;
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
    else{
      print("validation falied");
      setState(() {
        _isLoading2 = false;
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
