
/*
===========================================================================================
App: Scanner App
Curved toolbar and menu bottoms
===========================================================================================
*/  
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';



class CatagoryScreen extends StatefulWidget {
  CatagoryScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {
  
  var _isInit = true;
  int isBtnSelected = 0;

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
//      await Provider.of<DataProvider>(context).getAllHistory();
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [

          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 250.0,
              left: 25.0,
              right: 25.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height:MediaQuery.of(context).size.height * 0.025 ),
                  Container(
                      height: (MediaQuery.of(context).size.height) * 0.6 ,
                      child: Container()
                  ),
                ],
              )),
          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height:30,
                    ),

                    //app-bar data=========================================
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                },
                              ),
                            )
                        ),
                        Expanded(
                          child: Text("Scanner App", style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                },
                              ),
                            )
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10,),

                    //menu data..........................................
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        buildButton(),
                        //divider.......................................
                        Container(
                          width: 1,
                          height: MediaQuery.of(context).size.height * 0.15,
                          color: Colors.white,
                        ),
                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
//                              color: Theme.of(context).primaryColor,
                              splashColor: Colors.blueGrey,
                              onTap: () {
                              },
                              child: Icon(Icons.photo_camera, size: 50, color: Colors.black38,),
                            ),
                            Text("Use Camera",
                              style:TextStyle(color: Colors.black12, fontSize: 15, fontWeight: FontWeight.w500),),

                            InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                              },
                              child: Icon(Icons.image, size: 50, color: Colors.black38,),
                            ),
                            Text("Use Gallery",
                              style:TextStyle(color: Colors.black12, fontSize: 15, fontWeight: FontWeight.w500),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
        ]));
  }

  Widget buildButton() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: primaryColor);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Choose Scanner", style:TextStyle(color: Colors.black12, fontSize: 20, fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: () {
            setState(() {
              isBtnSelected = 0;
            });
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isBtnSelected == 0
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: isBtnSelected == 0
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.pages,
                    color: isBtnSelected == 0
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Text Scanner',
                    style: isBtnSelected == 0
                        ? selectedTextColor
                        : unSelectedTextColor,
                  )
                ],
              )),
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: () {
            setState(() {
              isBtnSelected = 1;
            });
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isBtnSelected == 1
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: isBtnSelected == 1
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.settings_overscan,
                    color: isBtnSelected == 1
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Barcode scanner',
                    style: isBtnSelected == 1
                        ? selectedTextColor
                        : unSelectedTextColor,
                  )
                ],
              )),
        ),
      ],
    );

  }
  
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }

  @override
  void dispose() {
    super.dispose();
  }



}

