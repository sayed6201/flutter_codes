/*
===========================================================================================
(1)ListView: image to text app
list viewscrolling in App
===========================================================================================
*/

Positioned(
          top: 250.0,
          left: 25.0,
          right: 25.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //History Tag ================================================================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 90.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: Color(0xFF7A9BEE)),
                    child: Align(
                      child: Text("History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            color: Colors.white,
                          )),
                    )
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              //listview scrolling inside limited height
              Container(
                height: (MediaQuery.of(context).size.width) ,
                child: ListView(
                  children: <Widget>[
                    HostoryRowWidget(),
                    HostoryRowWidget(),
                    HostoryRowWidget()
                  ],
                ),
              ),
            ],
          )),