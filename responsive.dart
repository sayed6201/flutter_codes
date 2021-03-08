 /*
===========================================================================================
Text responsive
-----------------
used to convert text into number...
===========================================================================================
*/

return new MaterialApp(
  builder: (context, child) {
    return MediaQuery(
      child: child,
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    );
  });



  seemore :   
  https://stackoverflow.com/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size/49806752


 /*
===========================================================================================
Responsive class
-----------------
Text, height,width responsive class
===========================================================================================
*/

  import 'package:flutter/cupertino.dart';

/*
  Usage:
  height: SizeConfig.safeBlockVertical * 10, //10 for example
  width: SizeConfig.safeBlockHorizontal * 10, //10 for example
  -----------------------------------------
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    }
 */

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double statusBarSize;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    statusBarSize = _mediaQueryData.padding.top;

    blockSizeHorizontal = screenWidth/100;
    blockSizeVertical = screenHeight/100;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - _safeAreaVertical)/100;
  }
}