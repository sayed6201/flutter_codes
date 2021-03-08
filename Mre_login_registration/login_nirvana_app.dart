import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nirvanaapp/screens/home/home_screen.dart';
import 'package:nirvanaapp/size_config/SizeConfig.dart';
import '../../color_file.dart';
import '../../string.dart';


class LoginScreen extends StatefulWidget {

  static const String tag = "/login";

  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  String _email;
  String _password;
  var isLoginLoading;

  @override
  void initState() {
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

    //Email++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue:  "",
      validator: (val) {
        if (val.isEmpty) {
          return "";
        } else {
          return null;
        }
      },
      onSaved: (String val) {
        _email = val;
      },
      decoration: InputDecoration(
        hintText: "Email",
        icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //Password++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final password = TextFormField(
      autofocus: false,
      initialValue: "",
      obscureText: true,
      validator: (val) {
        if (val.isEmpty) {
          return "";
        } else if (val.length < 6) {
          return "Must be 6 chars long";
        } else {
          return null;
        }
      },
      onSaved: (String val) {
        _password = val;
      },
      decoration: InputDecoration(
        hintText: "Enter password",
        icon: Icon(Icons.lock),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //login Button++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final loginButton = Container(
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
            Navigator.of(context).pushNamed(HomeScreen.tag,);
          },
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Log in",
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );

    //signup - Button++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final signUpButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusColor: primaryColor,
          onPressed: (){
            Navigator.of(context).pushNamed(HomeScreen.tag,);
          },
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        "Forgot password",
        style: TextStyle(color: primaryColor, fontSize: SizeConfig.screenHeight * 0.025,),
      ),
      onPressed: null
    );

    final formUi = Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical * 5.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: email,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: password,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              loginButton,
              signUpButton,
              forgotLabel
            ],
          ),
        ));

    return Scaffold(
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [

          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: SizeConfig.blockSizeVertical* 50,
                width: SizeConfig.blockSizeHorizontal * 100,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey,
//                      offset: Offset(0.0, 1.0), //(x,y)
//                      blurRadius: 6.0,
//                    ),
//                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height:SizeConfig.statusBarSize,
                    ),
                    SizedBox(
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeVertical * 20,
                        child: Image.asset(
                          LOGO,
                          fit: BoxFit.contain,
                        )),
                    Divider(),
                    Text("Log In",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.03,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),

          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: (SizeConfig.blockSizeVertical * 30 ) + SizeConfig.statusBarSize,
              left: 25.0,
              right: 25.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8,
                      child: Container(
                      height: SizeConfig.blockSizeVertical * 60 ,
                      child: formUi,
                      )
                  ),
                ],
              )),
        ]));
  }
}

