import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  //this value will not change after rendering as it is StatelessWidget
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
      questionText,
      style: TextStyle(
        fontSize: 30.0,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
