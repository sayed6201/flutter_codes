import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crowdv/screens/auth_screens/login_screen.dart';
import 'package:crowdv/screens/home/home_screen.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../string.dart';
import 'auth_screens/sign_up.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> animation2;
  AnimationController animationController;
  AnimationController animationController2;
  var _isLoading = true;
  var _isinit = true;
  bool ok = false;

  Map<String,dynamic> data;

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(begin: -100, end: -20).animate(animationController2)
      ..addListener(() {
        setState(() {});
      });
    animation2 = Tween<double>(begin: 140, end: 0).animate(animationController2)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    animationController2.forward();

    super.initState();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userCacheLoading();
    });
    Future.delayed(Duration.zero).then((_) {
      userCacheLoading();
    });

  }

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> userCacheLoading() async {
    if(_isinit){
      setState(() {
        _isLoading = true;
      });
      await Provider.of<AuthProvider>(context,listen: false).getSharePreferenceCache();
      if(Provider.of<AuthProvider>(context,listen: false).isLoggedIn){
        try{
          print("splash screen inside try");
          await Provider.of<AuthProvider>(context, listen: false)._InDatareceive(
              phone: Provider.of<AuthProvider>(context,listen: false).getUserCreds[PHONE],
              password: Provider.of<AuthProvider>(context,listen: false).getUserCreds[PASSWORD]
          );
          print("splash screen login success");
        }catch(e){
          print("splash screen login fail");
          await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(isLoggesin: false);
        }
      }
      setState(() {
        _isLoading = false;
      });
      _isinit = false;
    }

    Future.delayed(
        const Duration(seconds: 2),
            (){
          if(ok){
            if(data["email_verified_at"] == null){
              Navigator.of(context).pushReplacement(_nonverified());
              return;
            }
            print("splash home ok: $ok");
            Navigator.of(context).pushReplacement(_createRouteLoggesIn());
          }else{
            print("splash not home ok: $ok");
            Navigator.of(context).pushReplacement(_createRouteNOtLogges());
          }
        }
    );
  }



  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    ok = Provider.of<AuthProvider>(context).isLoggedIn;

    data = Provider.of<AuthProvider>(context, listen: false).getAData;
    print("got profile data");
    print("login ui ${data.toString()}");


    return Scaffold(
        backgroundColor: Colors.transparent,
        body:

//      Stack(
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: AssetImage(SPLASH_SCREEN_IMG),
//                    fit: BoxFit.cover)),
//          ),
//          Align(
//            alignment: AlignmentDirectional(0.0, 0.7),
//            child: AnimatedBuilder(animation: animation, builder: (BuildContext context, Widget chile){
//              return Transform.translate(
//                offset: Offset(0, animation.value),
//                child: Container(
//                  padding: const EdgeInsets.all(8.0),
//                  child: const Text('call4tours.com', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
//                ),
//              );
//            }),
//          ),
//          Align(
//            alignment: AlignmentDirectional.bottomCenter,
//            child: RaisedButton(
//              onPressed: () {
//                animationController.forward();
//              },
//              child: Text('Go'),
//              color: Colors.red,
//              textColor: Colors.yellowAccent,
//              shape: BeveledRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(20))),
//            ),
//          )
//        ],
//      )


        Container(
//        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.7 -10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.blue,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.mirror),
            ),
//        decoration: BoxDecoration(
//        gradient: LinearGradient(
//        colors: [
//          Theme.of(context).primaryColor.withOpacity(0.9),
//          Colors.orange
//        ],
//        ) ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0,animation2.value),
                  child: SizedBox(
                      height:  SizeConfig.safeBlockVertical * 30,
                      width: SizeConfig.safeBlockVertical * 30,
                      child: Image.asset(
                        LOGO,
                        fit: BoxFit.fitWidth,
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Transform.translate(
                  offset: Offset(0,animation.value),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(' ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            )
        )
    );
  }


  Route _createRouteNOtLogges() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UserChooseScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.slowMiddle;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _nonverified() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => VerifyEmail(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.slowMiddle;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRouteLoggesIn() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.slowMiddle;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}

