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
