------------------------------------------------------------------------------------
Listview overflow
Note: 
# Use Expanded to give the remainig heihgt
------------------------------------------------------------------------------------
Expanded 
  - ListView


------------------------------------------------------------------------------------
Listview
Note: 
# has infinite height
# Shrinkwrap: true
------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 70.0,
          backgroundColor: Colors.transparent,
          child: Image.asset('images/calltrips.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome Calltrips',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit condimentum mauris id tempor. Praesent eu commodo lacus. Praesent eget mi sed libero eleifend tempor. Sed at fringilla ipsum. Duis malesuada feugiat urna vitae convallis. Aliquam eu libero arcu.',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final searchEt = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      validator: (val) {
        if (val.isEmpty) {
          return "must be filled";
        } else {
          return null;
        }
      },
      onSaved: (String val) {},
      decoration: InputDecoration(
        hintText: 'Destination',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final searchbar = Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: IconButton(icon: Icon(Icons.search), onPressed: null),
          ),
          Container(
            width: 170.0,
            child: searchEt,
          ),
          Container(
              child: IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: null,
                  color: Colors.blueGrey)),
        ],
      ),
    );

    final searchButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: null,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Search', style: TextStyle(color: Colors.white)),
      ),
    );

    final body = Container(
        width: double.infinity,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          //LinearGradient, SweepGradient .. gives gradient bsackground color
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.deepPurple,
          ]),
        ),
        child: ListView(
            shrinkWrap: false,

            padding: EdgeInsets.only(left: 5.0, right: 5.0),

            children: <Widget>[
              alucard,
              SizedBox(height: 8.0),
              Center(child: welcome,),
              Center(child: lorem,),
              SizedBox(height: 48.0),
              searchbar,
              SizedBox(height: 48.0),
              searchButton
            ]

        )
    );


    return Scaffold(
    body: body,
    );
  }
}


------------------------------------------------------------------------------------
Listview traversing using for loop
------------------------------------------------------------------------------------
child: Row(
              children: <Widget>[
                for (final guest in guests)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: Image.asset(
                        guest.imagePath,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),


/*
===========================================================================================
(1)List Traverse-------------------------------
===========================================================================================
*/

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        prod.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${prod.quantity}x \$${prod.price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
                    .toList(),
              ),
            )



            