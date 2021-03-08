import 'package:crowdv/screens/auth_screens/password_recovery_screen.dart';
import 'package:crowdv/screens/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/auth_screens/sign_up.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/screens/home/home_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/widgets/already_have_account.dart';
import 'package:crowdv/widgets/rounded_button.dart';
import 'package:crowdv/widgets/rounded_password_field.dart';
import 'package:crowdv/widgets/rounded_textfield.dart';
import 'package:provider/provider.dart';
import '../../color_file.dart';
import '../../string.dart';
import '../recruiter_profile_setup.dart';
import '../vol_profile_setup.dart';


class LoginScreen extends StatefulWidget {

  static const String tag = "/login";

  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _autoValidate = true;
  var isLoginLoading;
  var passObsecure = true;
  var _isLoading =false;
  
  var phoneNumController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordTextErr = "";
  var phoneTextErr = "";

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
    final password = Container(
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
//            if (val.isEmpty) {
//              return "";
//            } else
              if (val.length < 6) {
              return"Password must be at lest 6 char long";
            } else {
              return null;
            }
          }
        )
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
          onPressed:validation,
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Log in",
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );

    //signup - Button++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final signUpButton = AlreadyHaveAnAccountCheck(login: true,press: (){
//      Navigator.of(context).pushReplacementNamed(SignUpScreen.tag);
      if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == VOLUNTEER_ROLE_ID){
//        await Provider.of<AuthProvider>(context, listen: false)
//            .setRegVolInfo(
//            phone: phoneNumController.text.toString(),
//            password: passwordController.text.toString()
//        );
//
//        setState(() {
//          _isLoading = false;
//        });

        Navigator.of(context).pushNamed(
            VolProfileSetup.tag,
            arguments: {
              'title': "Volunteer Signup",
              'btn_text': "Register",
              'is_signup' : "1"
            }
        );
      }
      else if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){

//        await Provider.of<AuthProvider>(context, listen: false)
//            .setRegRecInfo(
//            phone: phoneNumController.text.toString(),
//            password: passwordController.text.toString()
//        );
//        setState(() {
//          _isLoading = false;
//        });
        Navigator.of(context).pushNamed(
            RecruiterProfileSetup.tag,
            arguments: {
              'title': "Recruiter Signup",
              'btn_text': "Register",
              'is_signup' : "1"
            }
        );
      }
    },);

    //forgot lebel++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final forgotLabel = FlatButton(
      child: Text(
        "Forgot password",
        style: TextStyle(color: primaryColor, fontSize: SizeConfig.screenHeight * 0.025,),
      ),
      onPressed: (){
        Navigator.pushNamed(context, PasswordRecoveryScreen.tag);
      }
    );

    final formUi = Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 5.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: phoneNumField,
            ),
//            Align(
//              alignment: Alignment.center,
//              child: Text(phoneTextErr, style: TextStyle(color: Colors.red),),
//            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: password,
            ),
//            Align(
//              alignment: Alignment.center,
//              child: Text(phoneTextErr, style: TextStyle(color: Colors.red),),
//            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            _isLoading ?
                Center(
                  child: CircularProgressIndicator(),
                )
                :loginButton,
            SizedBox(height: SizeConfig.blockSizeVertical * 5),
            signUpButton,
            forgotLabel
          ],
        ),
        );

    return Scaffold(
        key: _scaffoldKey,
        body:
        SingleChildScrollView(
          child: //in stack widgets are placed on top of each other================================================================
          Stack(children: [

            //it will make the staack scrollable ..............
            Container(
              height: SizeConfig.blockSizeVertical * 100,
            ),
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
                        height:SizeConfig.statusBarSize *2.5  ,
                      ),
                      SizedBox(
                          height: SizeConfig.blockSizeVertical * 15,
                          width: SizeConfig.blockSizeVertical * 15,
                          child: Image.asset(
                            LOGO,
                            fit: BoxFit.contain,
                          )),
//                      Divider(),
//                      Text("Log In",
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            fontSize: SizeConfig.screenHeight * 0.03,
//                            color: Colors.white,
//                            fontWeight: FontWeight.w500),
//                      ),
                    ],
                  ),
                )),

            //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
            Positioned(
                top: (SizeConfig.blockSizeVertical * 30 ) ,
                left: 25.0,
                right: 25.0,
                child: Card(
                    elevation: 8,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 60 ,
                      child: formUi,
                    )
                ),),
          ]),
        )
    );
  }
  
  void validation() async{
    if(passwordController.text.toString().isEmpty || passwordController.text.toString().isEmpty){
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

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      try{
        await Provider.of<AuthProvider>(context,listen: false)._InDatareceive(
            phone: phoneNumController.text.toString(),
            password: passwordController.text.toString());
        setState(() {
          _isLoading = false;
        });
        print("getting profile data");
        Map<String,dynamic> data = Provider.of<AuthProvider>(context, listen: false).getAData;
        print("got profile data");
        print("login ui ${data.toString()}");
        if(data["email_verified_at"] == null){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyEmail()
              ),
                  (Route<dynamic> route) => false
          );
          return;
        }

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()
            ),
                (Route<dynamic> route) => false
        );

      }catch(e){
        setState(() {
          _isLoading = false;
        });
        print(e.toString());
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
                      child: Text(msg[ERR_MSG_LOGIN],
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

