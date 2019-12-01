import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  //this value will not change after rendering as it is StatelessWidget
  final Function myFunction;
  final String anserText;

  Answer(this.myFunction, this.anserText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: RaisedButton(
          onPressed: myFunction,
          color: Colors.blue,
          child: Text(
              anserText,
              style: TextStyle(
                  color: Colors.white70
              ),
          ),
        ));
  }
}
