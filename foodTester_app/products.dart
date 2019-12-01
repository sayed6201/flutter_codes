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

    return Expanded(

      child:ListView(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,

        children:
        _products.map((element) =>
            Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/food.jpg',fit: BoxFit.cover),
                  Text(element)
                ],),
            )
            
        ).toList()
        ,
      )
    );
  }

}