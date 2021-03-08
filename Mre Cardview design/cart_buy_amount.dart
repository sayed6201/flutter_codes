 

/*
===========================================================================================
App: Nutrient_app
Cart, uantity, buy
===========================================================================================
*/
 Positioned(
          top: 250.0,
          left: 25.0,
          right: 25.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Food name, ================================================================================================
              Text("anc",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              //Price Tag ================================================================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("1232",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                          color: Colors.grey)),
                  //Devider ================================================================================================
                  Container(height: 25.0, color: Colors.grey, width: 1.0),
                  //numbers section ================================================================================================
                  Container(
                    width: 125.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: Color(0xFF7A9BEE)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Color(0xFF7A9BEE)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Text('2',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 15.0)),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Color(0xFF7A9BEE),
                                size: 20.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                  height: 150.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildInfoCard('WEIGHT', '300', 'G'),
                      SizedBox(width: 10.0),
                      _buildInfoCard('CALORIES', '267', 'CAL'),
                      SizedBox(width: 10.0),
                      _buildInfoCard('VITAMINS', 'A, B6', 'VIT'),
                      SizedBox(width: 10.0),
                      _buildInfoCard('AVAIL', 'NO', 'AV')
                    ],
                  )),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)),
                      color: Colors.black),
                  height: 50.0,
                  child: Center(
                    child: Text('\$52.00',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Montserrat')),
                  ),
                ),
              )
            ],
          )),