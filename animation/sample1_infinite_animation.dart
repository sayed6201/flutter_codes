=============================================================================================
AnimationController, CurvedAnimation, 

tween: 
------
Changing the value range and even the type of the output value (e.g. to a Color) is possible with a Tween. There are many pre-built ones such as ColorTween or TextStyleTween.
=============================================================================================

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(AnimationPage());

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

/*
manage animation in initstate
-------------------------------
*/
  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 5),
      //from SingleTickerProviderStateMixin
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.bounceInOut,
      reverseCurve: Curves.decelerate,
    );

    animation = Tween<double>(
        begin: 0,
        end: 2 * math.pi, ,
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Transform.rotate(
          angle: animation.value,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: Icon(
              Icons.flight_takeoff,
              color: Colors.blue,
              size: 150,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}

