

/*
===========================================================================================
App: Nutrient_app
Custonmized Button....
===========================================================================================
*/
Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)),
                      color: Colors.black),
                  height: 50.0,
                  child: Center(
                    child: Text('\$52.00',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Montserrat')),
                  ),
                ),
              )



              RaisedButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)
                  ),
                  child: Text("Apply", style: TextStyle(color: Colors.white),),
                  color: primaryColor,
                  onPressed:
                  )



}



/*
===========================================================================================
App: Realstate App
Custonmized Button.... for nav drawer,setting, scrollable options....
===========================================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutterapppractice_sayed/utils/constants.dart';

class BorderIcon extends StatelessWidget{

  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderIcon(
      {Key key,
        @required this.child,
        this.padding,
        this.width,
        this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding ?? EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: COLOR_WHITE,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: COLOR_GREY,
          width: 2
        )
      ),
      child: Center(child: child,),
    );
  }


}