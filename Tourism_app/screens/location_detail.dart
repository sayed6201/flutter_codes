import 'package:flutter/material.dart';
import 'package:flutter_app/models/location.dart';
import 'package:flutter_app/screens/widgets/text_section.dart';
import 'package:flutter_app/screens/widgets/image_banner.dart';


class LocationDetail extends StatelessWidget {
  final int _locationId;

  LocationDetail(this._locationId);

  @override
  Widget build(BuildContext context) {
    //don't call inside build function, it can be called many times
    final location = Location.fetchById(_locationId);


    return Scaffold(
      appBar: AppBar(
        title: Text('Location Detail'),
      ),
      body: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            ImageBanner(location.imagePath),

          ]..addAll(textSection(location)))
    );
  }

  //it will generate List of widgets
  List<Widget> textSection(Location location){

    return location.facts.map((fact)=> TextSection(fact.title, fact.text) ).toList();
    
  }
}


