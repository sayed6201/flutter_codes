

/*
===========================================================================================
App: Nutrient_app
Custonmized Button....
===========================================================================================
*/
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



              RaisedButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)
                  ),
                  child: Text("Apply", style: TextStyle(color: Colors.white),),
                  color: primaryColor,
                  onPressed:
                  )