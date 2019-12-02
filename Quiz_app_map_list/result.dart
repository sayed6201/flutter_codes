import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuizFunc;

  Result(this.resultScore, this.resetQuizFunc);

  //getter
  String get resultPhrase{
    var resultText = 'You did it';
    if(resultScore <= 8){
      resultText = '$resultScore You are awesome and innocent';
    }else if(resultScore <= 12){
      resultText = '$resultScore pretty likable';
    }else if(resultScore <= 16){
      resultText = '$resultScore you are strange';
    }else{
      resultText = '$resultScore you are bad !';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
     child: Column(
       children: <Widget>[
         Text(
           resultPhrase,
           textAlign: TextAlign.center,
           style: TextStyle(
               fontSize: 36,
               fontWeight: FontWeight.bold
           ),
         ),
         FlatButton(
           onPressed: resetQuizFunc,
           child: Text(
               'Restart Quiz',
             style: TextStyle(
               color: Colors.blue
             ),

           ),
         )
       ],
       
     ),
    );
  }
}
