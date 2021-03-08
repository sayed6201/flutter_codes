=====================================================================
Search bar
=====================================================================
          Stack(children: <Widget>[
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: 400.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).primaryColor
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Where would you\nlike to go?',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: TextField(
                          onChanged: (text) {},
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 14.0),
                            suffixIcon: Material(
                              elevation: 2.0,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return;
                                  }));
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          child: StreamBuilder(
//                        stream: homeScreenBloc.isFlightSelectedStream,
                            initialData: true,
                            builder: (context, snapshot) {
                              print('in flight - ${snapshot.data}');
                              return ChoiceChip(Icons.flight_takeoff, "Flights",
                                  snapshot.data);
                            },
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          child: StreamBuilder(
//                        stream: homeScreenBloc.isFlightSelectedStream,
                            initialData: true,
                            builder: (context, snapshot) {
                              print('in hotel - ${!snapshot.data}');
                              return ChoiceChip(
                                  Icons.hotel, "Hotels", !snapshot.data);
                            },
                          ),
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),




=====================================================================
Custom background curved for container
=====================================================================

import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width * .5, size.height - 30.0);
    var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    
    var secondEndPoint = Offset(size.width, size.height - 80.0);
    var secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;


}