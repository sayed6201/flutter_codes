/*
===========================================================================================
(1)List
===========================================================================================
*/

// screens/location_detail/location_detail.dart
import 'package:flutter/material.dart';
import '../../models/location.dart';
import 'image_banner.dart';
import 'text_section.dart';
class LocationDetail extends StatelessWidget {
  @override                                                                
  Widget build(BuildContext context) {               
    // simply fetch the first location we have         
    // NOTE: we'll be moving this to a scoped_model later
    final locations = Location.fetchAll();
    final location = locations.first; 
return Scaffold(                                                   
      appBar: AppBar(                                             
        title: Text(location.name),                        
      ),                                                                      
      body: Column(      

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [                                                                    
            ImageBanner(location.imagePath),                     
          ]..addAll(textSections(location))),                            
    );                                                                                        
  }                                                                                            
List<Widget> textSections(Location location) {                                                         
    return location.facts.map((fact) => TextSection(fact.title, fact.text)).toList();
  }                                                                                                                                        
}




/*
===========================================================================================
(2)List
===========================================================================================
*/
import 'package:flutter/material.dart';

//properties has to be immutable, because it is StatelessWidget
class Products extends StatelessWidget{

  final List<String> _products;

  Products(this._products){
   print('Product Widget Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('Product Widget build');
    return Column(
      children:
      _products.map((element) =>
          Card(
            child: Column(children: <Widget>[
              Image.asset('assets/food.jpg'),
              Text(element)
            ],),
          )
      ).toList()
      ,
    );
  }

}




/*
===========================================================================================
(3)List
===========================================================================================
*/
// locations/locations.dart

import 'package:flutter/material.dart';
import 'package:flutter_app/models/location.dart';
import '../main.dart';


class Locations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // NOTE: we'll be moving this to a scoped_model later
    final locations = Location.fetchAll();

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),

      body: ListView(

        children: locations.map((location) => GestureDetector(

          child: Text(location.name),

          onTap: ()=> _onLocationTap(context, location.id) ,

        )).toList(),

      ),
    );
  }

  void _onLocationTap(BuildContext context, int locationId){

    //LocationDetail constructor requires locationId, now in switch-case locationId will be passed
    Navigator.pushNamed(context, LocationDetailRoute, arguments: {"id": locationId} );

  }
}


/*
===========================================================================================
(3)Map => list
===========================================================================================
*/

#[1]-----------------------------------------------------------------

final var questions = const [
    {
      'QuestionText': 'What\'s your favourite color?',
      'Answers': [{'text':'blue', 'score': ''}, 'red', 'black', 'white'}]
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
        Question(questions[questionIndex]['QuestionText']),

        //... will make the list a single widget
        ...(questions[questionIndex]['Answers'] as List<String> ).map((answer){
          return Answer(answerQuestionFunc,answer);
        }).toList()
      ],
    );
  }
}

[2]-----------------------------------------------------------------
final var questions = const [
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
  ]
