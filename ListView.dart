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
