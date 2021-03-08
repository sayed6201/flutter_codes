/*
===========================================================================================
App: Food_nuteration, image to text converter
===========================================================================================
*/

Stack(children: [
//                    //base container, over which all widgets are placed=============================================================
//                    Container(
//                        height: MediaQuery.of(context).size.height,
//                        width: MediaQuery.of(context).size.width,
//                        color: Colors.transparent),
      //Curved container, ================================================================================================
//                    Positioned(
//                        top: 75.0,
//                        child: Container(
//                            decoration: BoxDecoration(
////                                borderRadius: BorderRadius.only(
////                                  topLeft: Radius.circular(45.0),
////                                  topRight: Radius.circular(45.0),
////                                ),
//                                color: Colors.white),
//                            height: MediaQuery.of(context).size.height - 100.0,
//                            width: MediaQuery.of(context).size.width)
//                    ),
      //Image container, ================================================================================================
      Positioned(
          top: 20.0,
          left: (MediaQuery.of(context).size.width / 2) - 100.0,
          child: Text('imagenae')),
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

      //App-bar ++++++++++++++++++++++++++++++++++++++++
      Positioned(
          top: 0.0,
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "My app",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45.0),
                bottomRight: Radius.circular(45.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
          )),
    ]));


/*
===========================================================================================
Local app cardview design
img:local
===========================================================================================
*/
Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            //Stack: to position and display item on top of each other:::::::::::::::::::::::::::::::::::::::::::::::::::::::
            Stack(
              children: <Widget>[
                //ClipRRect: for image display and radius cropping:::::::::::::::::::::::::::::::::::::::::::::::::::::::
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                //Positioned: only available inside stack :::::::::::::::::::::::::::::::::::::::::::::::::::::::
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    //osetting container bg color transperent......
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.schedule,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.work,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),