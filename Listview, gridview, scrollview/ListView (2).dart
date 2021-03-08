

/*
===========================================================================================
LIstview notes
===========================================================================================
*/


1) Make not scrollable=> physics: const NeverScrollableScrollPhysics()
2) Make wrap content=> Wrap(children:[Listview])


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

        // (...) will make the list a single widget
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



/*
===========================================================================================
(4) ListView.Builder()
NOTE:
#gives good performance....
===========================================================================================
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$${transactions[index].amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}


ListView.builder---------------------------------------------------------------------------------------------

      ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: _transportData.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                // With MaterialPageRoute, you can pass data between pages,
                // but if you have a more complex app, you will quickly get lost.
                MaterialPageRoute(
                  builder: (context) => HotelDetailsPage(),
                ),
              );
            },
            child: TransportList(
              item: _transportData[index],
            ),
          );
        },
      ),