import 'package:crowdv/screens/vol_profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crowdv/UserRegData.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/auth_screens/login_screen.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/screens/recruiter_profile_setup.dart';
import 'package:crowdv/screens/home/home_screen.dart';
import 'package:crowdv/screens/profile_setup.dart';
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


class SignUpScreen extends StatefulWidget {
  static final tag  = "SignUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  var isLoginLoading;
  var passObsecure = true;
  var _isLoading =false;

  var phoneNumController = TextEditingController();
  var passwordController = TextEditingController();
  var conPasswordController = TextEditingController();
  var passwordTextErr = "";
  var phoneTextErr = "";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    //phoneNumField++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final phoneNumField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: SizeConfig.blockSizeHorizontal * 70,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(29),
        ),
        child:
        TextFormField(
          controller: phoneNumController,
          keyboardType: TextInputType.phone,
          autofocus: false,
          cursorColor: primaryColor.withOpacity(0.4),
          decoration: InputDecoration(
            hintText: "Phone",
            icon: Icon(
              Icons.phone_android,
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
          validator: null,
        )
    );

    //Password++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final passwordField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: SizeConfig.blockSizeHorizontal * 70,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(29),
        ),
        child:
        TextFormField(
          controller: passwordController,
          autofocus: false,
          autovalidate: true,
          obscureText: passObsecure,
          cursorColor: primaryColor.withOpacity(0.4),
          decoration: InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                passObsecure ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  passObsecure = ! passObsecure;
                });
              },
            ),
            border: InputBorder.none,
          ),
          validator: (val) {
            if (val.length < 6) {
              return"Password must be at lest 6 char long";
            } else {
              return null;
            }
          },

        )
    );

    //confirm Password++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final ConpasswordField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: SizeConfig.blockSizeHorizontal * 70,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(29),
        ),
        child:
        TextFormField(
          controller: conPasswordController,
          autofocus: false,
          obscureText: passObsecure,
          autovalidate: true,
          cursorColor: primaryColor.withOpacity(0.4),
          decoration: InputDecoration(
            hintText: "Confirm Password",
            icon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                passObsecure ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  passObsecure = ! passObsecure;
                });
              },
            ),
            border: InputBorder.none,
          ),
          validator: (val) {
            if (conPasswordController.text.toString().length < 6 ) {
              return "Must be 6 char long";
            }
            else if (passwordController.text.toString() != conPasswordController.text.toString() ) {
              return "Does not match";
            }
            else {
              return null;
            }
          },
        )
    );

    return Scaffold(
      key: _scaffoldKey,
      body:Container(
        height: size.height,
        width: double.infinity,
        color: primaryColor.withOpacity(0.4),
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
                  Text(
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
//                  SizedBox(height: size.height * 0.03),
                  SizedBox(
                      height: SizeConfig.blockSizeVertical * 25,
                      width: SizeConfig.blockSizeVertical * 25,
                      child: Image.asset(
                        LOGO,
                        fit: BoxFit.contain,
                      )),
//                  SvgPicture.asset(
////                    LOGO,
//                    "assets/icons/signup.svg",
//                    height: size.height * 0.35,
//                  ),
                  phoneNumField,
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.0),
                  passwordField,
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.0),
                  ConpasswordField,
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.0),
                  RoundedButton(
                    text: "SIGNUP",
                    press: (){
                      validation();
                    }
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical*2,),
                  AlreadyHaveAnAccountCheck(login: false,press: (){
                    Navigator.of(context).pushReplacementNamed(LoginScreen.tag);
                  },)

//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      SocalIcon(
//                        iconSrc: "assets/icons/facebook.svg",
//                        press: () {},
//                      ),
//                      SocalIcon(
//                        iconSrc: "assets/icons/facebook.svg",
//                        press: () {},
//                      ),
//                      SocalIcon(
//                        iconSrc: "assets/icons/facebook.svg",
//                        press: () {},
//                      ),
//                    ],
//                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void validation() async{

    if(passwordController.text.toString().isEmpty
        || phoneNumController.text.toString().isEmpty
    || conPasswordController.text.toString().isEmpty){
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
                    child: SizedBox(
                        height: 50.0,
                        child: Text(msg[CRED_FILL],
                          textAlign: TextAlign.center,)),
                  ),

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
      if(passwordController.text.toString().length < 6){
        final snackBar = SnackBar(
          content: Text(
            'Make sure your passowrd is at least 5 char long',
            style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.white,
            onPressed: () {
            },
          ),);
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if(passwordController.text.toString() != conPasswordController.text.toString() ){
        final snackBar = SnackBar(
          content: Text(
            "Password confirmation failed",
            style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.white,
            onPressed: () {
            },
          ),);
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }

      setState(() {
        _isLoading = true;
      });
      print("validation started");

      if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == VOLUNTEER_ROLE_ID){
        await Provider.of<AuthProvider>(context, listen: false)
            .setRegVolInfo(
            phone: phoneNumController.text.toString(),
            password: passwordController.text.toString()
        );

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushNamed(
            VolProfileSetup.tag,
            arguments: {
              'title': "Profile Setup",
              'btn_text': "Register",
              'is_signup' : "1"
            }
        );
      }
      else if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){

        await Provider.of<AuthProvider>(context, listen: false)
            .setRegRecInfo(
            phone: phoneNumController.text.toString(),
            password: passwordController.text.toString()
        );
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed(
            RecruiterProfileSetup.tag,
            arguments: {
              'title': "Recruiter Profile Setup",
              'btn_text': "Register",
              'is_signup' : "1"
            }
        );
      }
    }
  }
}