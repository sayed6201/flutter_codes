/*
===========================================================================================
Location model
===========================================================================================
*/

import 'location_fact.dart';

class Location{
  final int id;
  String name;
  String imagePath;
  final List<LocationFact> facts;

  Location(this.id,this.name, this.imagePath, this.facts);

  static Location fetchById(int locationId) {

    List<Location> locations = Location.fetchAll();

    for(var i=0;i<locations.length;i++){
      if(locations[i].id == locationId){
        return locations[i];
      }
    }
    return null;
  }

  static List<Location> fetchAll() {
    return [
      Location(1,'Kiyomizu-dera', 'assets/images/china.jpg', [
        LocationFact('Summary',
            'While we could go on Kiyomizu-dera about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm.'),
        LocationFact('How to Get There',
            'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.'),
      ]),
      Location(2,'Arashiyama Bamboo Grove', 'assets/images/crp.jpg', [
        LocationFact('Summary',
            'While we could go on Arashiyama Bamboo Grove about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm.'),
        LocationFact('How to Get There',
            'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.'),
      ]),
      Location(3,'Mount Fuji', 'assets/images/img1.jpg', [
        LocationFact('Summary',
            'While we could go on Mount Fuji about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm.'),
        LocationFact('How to Get There',
            'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.'),
      ]),
    ];
  }
}