import 'package:flutter/material.dart';
import './Question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  //this value will not change after rendering as it is StatelessWidget
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestionFunc;

  Quiz({@required this.questions, @required this.answerQuestionFunc, @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Question(questions[questionIndex]['questionText']),

        //... will make the list a single widget
        ...(questions[questionIndex]['answers'] as List<Map<String,Object>> ).map((answer){
          return Answer(() => answerQuestionFunc(answer['score']),answer['text']);
        }).toList()
      ],
    );
  }
}
