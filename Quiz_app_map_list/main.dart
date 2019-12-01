import 'package:flutter/material.dart';

//keep Question.dart class public
import './Question.dart';
import './answer.dart';

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

  // This widget is the root of your application.
  var _questions = [
    {
      'QuestionText': 'What\'s your favourite color?',
      'Answers': ['blue', 'red', 'black', 'white']
    },
    {
      'QuestionText': 'What\'s your favourite animal?',
      'Answers': ['lion', 'elephant', 'zebra', 'cow']
    },
    {
      'QuestionText': 'What\'s your favourite teacher?',
      'Answers': ['Max', 'sayed', 'salman', 'sair']
    },
  ];

  void _clikcAction() {
    if (_index <= 2) {
      setState(() {
        _index++;
      });
    } else {
      setState(() {
        _index = 0;
      });
    }
    print(_index);
    if (_index < 3) print(_questions.elementAt(_index));
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
          body: Column(
            children: <Widget>[
              Question(_questions[_index]['QuestionText']),
          //... will make the list a single widget
          ...(_questions[_index]['Answers'] as List<String> ).map((answer){
                return Answer(_clikcAction,answer);
              }).toList()
            ],
          )),
    );
  }
}
