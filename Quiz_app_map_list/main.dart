import 'package:flutter/material.dart';

//keep Question.dart class public
import './Question.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

//this app is executed when the app runs...
void main() {
  //MyApp(): initializes object..
  runApp(MyApp());
}

//Myapp is a widget
//every widget needs to extend statelss/stateful widget...
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<StatefulWidget> {
  var _index = 0;
  var _totalScore = 0;

  // This widget is the root of your application.
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
      ],
    },
  ];

  void _resetQuiz(){
    setState(() {
      _totalScore = 0;
      _index = 0;
    });
  }
  void _clikcAction(int score) {
    _totalScore += score;
    print('your score: $_totalScore');
      setState(() {
        _index++;
      });
    print(_index);
    if (_index < _questions.length) print('more questions');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('My app'),
          ),
          body: _index < _questions.length ?
              Quiz(
                answerQuestionFunc: _clikcAction,
                questionIndex: _index,
                questions: _questions,
              ): Result(_totalScore, _resetQuiz)

      ),
    );
  }
}
