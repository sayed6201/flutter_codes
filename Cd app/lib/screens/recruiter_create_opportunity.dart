import 'package:crowdv/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/booking_screen.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class ReqruiterOpprtunityCreate extends StatefulWidget {

  static final String tag = "/ReqruiterOpprtunityCreate";

  @override
  _ReqruiterOpprtunityCreateState createState() => _ReqruiterOpprtunityCreateState();
}

class _ReqruiterOpprtunityCreateState extends State<ReqruiterOpprtunityCreate> {
  var _isInit = true;
  var _isLoading = true;
  var _isLoadingAdded = false;
  var _isLoadingDelete = false;
  var header_text = "Create Opportunity";
  List<dynamic> scheduleList = [];
  var _categoryName ;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String,dynamic> caregoryIdMap = {};


  var titleController = TextEditingController();
  var descriptionFiledController = TextEditingController();
  var locationController = TextEditingController();
  var endTimeController = TextEditingController();
  var startTimeController = TextEditingController();
  var totalHourController = TextEditingController();
  List<String> _selectedEligibilityList = [];
  List<dynamic> eligibilityList = [];

  var location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;


  
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        print("_serviceEnabled");
        if (!_serviceEnabled) {
          print("_serviceEnabled NOT");
          return;
        }
      }

      await Provider.of<GuestProvider>(context,listen: false).fetchExpertCatagoryList();
      print("isloading $_isLoading");
      await Provider.of<AuthProvider>(context,listen: false).fetchEligibilityList();
      caregoryIdMap = Provider.of<GuestProvider>(context,listen: false).getCategoryMap;
      _isInit = false;
      setState(() {
        _categoryName =  caregoryIdMap.keys.toList()[0].toString();
        _isLoading = false;
        print("isloading $_isLoading");
        eligibilityList =  Provider.of<AuthProvider>(context,listen: false).allFetchEMap;
      });

    }
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
//  Future<Map<String, double>> _getLocation() async {
//    var currentLocation = <String, double>{};
//    try {
//      currentLocation = await location.getLocation();
//    } catch (e) {
//      currentLocation = null;
//    }
//    return currentLocation;
//  }

  @override
  Widget build(BuildContext context) {

//    setState(() {
//      header_text = "${doctorData.length ?? ""} Experts found";
//    });
    print("eligibilityList-length-ui:  ${eligibilityList.length}");


    //name++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final title = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidate: true,
      controller: titleController,
      validator: (val) {
        if (val.isEmpty) {
          return "Add description";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Title',
        icon: Icon(Icons.date_range),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //description++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final descriptionFiled = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidate: true,
      maxLines: 3,
      controller: descriptionFiledController,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Write Description',
        icon: Icon(Icons.timer),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //endtime++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final endTime = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidate: true,
      controller: endTimeController,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Ending time: 20:00',
        icon: Icon(Icons.timelapse),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //startTime++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final startTime = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidate: true,
      controller: startTimeController,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Starting time: 10:00 ',
        icon: Icon(Icons.timelapse),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //location++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final location = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidate: true,
      controller: locationController,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Location',
        icon: Icon(Icons.location_on),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //Totalhour++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final totalHour = TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      autovalidate: true,
      controller: totalHourController,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter total Hour',
        icon: Icon(Icons.timelapse),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //registration Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final button = Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 0),
        child: RaisedButton(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed:validation,
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              "Add Opportunity",
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );


    final formUi = Form(
      key: _formKey,
      autovalidate: true,
      child:
      Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: title,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: descriptionFiled,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: location,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: totalHour,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: startTime,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: endTime,
          ),


          SizedBox(height: SizeConfig.blockSizeVertical * 5.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              margin: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal * 10),
              child: Text('Choose Eligibility', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            ),
          ),

          _isLoading ?
              Center(
                child: LoaderWidget(
                  text: "Loading data",
                ),
              )
              :
         Wrap(
           children: <Widget>[
             ListView.builder(
               padding: EdgeInsets.symmetric(vertical: 0),
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   childAspectRatio: 9,
//                   crossAxisSpacing: 0,
//                   mainAxisSpacing: 0,
//                 ),
                 itemCount: eligibilityList.length,
                 itemBuilder: (ctx, index){
                   return  CheckboxListTile(
                     dense: true,
                     value: _selectedEligibilityList.contains(eligibilityList[index]["id"].toString()) ? true : false,
                     onChanged: (v){
                       if(mounted){
                         setState(() {
                           print("v: $v");
                           if(_selectedEligibilityList.contains(eligibilityList[index]["id"].toString())){
                             _selectedEligibilityList.remove(eligibilityList[index]["id"].toString());
                           }else{
                             _selectedEligibilityList.add(eligibilityList[index]["id"].toString());
                           }
                           print("added list: ${_selectedEligibilityList.toString()}");
                           print("added len: ${_selectedEligibilityList.length}");
                         });
                       }
                     },
                     title:  Text(eligibilityList[index]["eligibility_name"], style: TextStyle(fontSize: 13),),
                     controlAffinity: ListTileControlAffinity.leading,
//                     subtitle: new Text('Subtitle'),
//                     secondary:  Icon(Icons.bookmark, color: primaryColor,),
                     activeColor: Colors.red,
                   );
                 }
             )
           ],
         ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal * 10),
              child: Text('Select Category', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          if(caregoryIdMap != null)
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Theme.of(context).primaryColor)
                  ),
                  child: DropdownButton<String>(
                    value: caregoryIdMap == null ? null : _categoryName ,
                    icon: Icon(Icons.arrow_drop_down),
                    hint: Text("Select Category"),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.deepPurple
                    ),
//                underline: Container(
//                  height: 1,
//                  color: Theme.of(context).primaryColor,
//                ),
                    onChanged: (String newValue) {
                      setState(() {
                        _categoryName = newValue;
                        print("selected $_categoryName");
                        print("selected id ${caregoryIdMap[_categoryName]}");
                      });
                    },
                    items: caregoryIdMap.keys.toList()
//                <String>[SELECT_CATEGORY_TEXT, 'Male', 'Female', 'Others']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                )
//            nidField,
            ),

          SizedBox(height: SizeConfig.blockSizeVertical * 3.0),


          SizedBox(height: SizeConfig.blockSizeVertical * 4),

          _isLoadingAdded ?
          Center(
            child: CircularProgressIndicator(),
          )
              :button,
          SizedBox(height: SizeConfig.blockSizeVertical * 5),

        ],
      ),
    );
    
    return Scaffold(
        body: Stack(children: [

          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
                child: Column(
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                    children : <Widget>[
                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        "Add opportunity detail",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black38
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color:Colors.blue,
                                                        border: Border.all(color: Colors.blue),
                                                        borderRadius: BorderRadius.circular(100),
                                                      ),
                                                      child: Icon(Icons.create, color: Colors.white,),)
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Divider(color: Colors.black38,),
                                                ),
                                                formUi
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                      Divider(),
                                    ]
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  ],
                ),
              )
          ),

          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: SizeConfig.blockSizeVertical * 15,
                width: double.infinity,
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
                      height: SizeConfig.statusBarSize,
                    ),
                    //app-bar data=========================================
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )),
                        Expanded(
                          child: Text(
                            header_text,
                            textAlign: TextAlign.center,
                            style: heading_style.copyWith(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight, child: Text(" ")))
                      ],
                    ),
//                    Divider(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          header_text,
//                          style: heading_style.copyWith(
//                            fontSize: SizeConfig.blockSizeVertical * 2,
//                          ),
//                        ),
//                      ],
//                    )
                  ],
                ),
              )),
        ]),
    );
  }

  void validation() async{
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(msg[ERR_TITLE]),
            content: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 50.0,
                          child: Image.asset(
                            ERROR,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Your Location Access is not granted",
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
        return;
      }
    }

    _locationData = await location.getLocation();

    print( "Lat: "+_locationData.latitude.toString() + "- Lon:" + _locationData.longitude.toString());

    if (_formKey.currentState.validate()) {
      print("validation success");
      try{
          setState(() {
            _isLoadingAdded = true;
          });
          String eligibiliDataID = "";
          if(_selectedEligibilityList.length < 2) {
            eligibiliDataID = _selectedEligibilityList[0];
          }else{
            eligibiliDataID = _selectedEligibilityList.join(',');
          }

          print("validation started $eligibiliDataID");

          await Provider.of<AuthProvider>(context,listen: false).createOpportunity(
              title: titleController.text.toString().trim(),
              des: descriptionFiledController.text.toString(),
              location: locationController.text.toString(),
              start_time: startTimeController.text.toString().trim(),
              end_time: endTimeController.text.toString().trim(),
              categories_id: caregoryIdMap[_categoryName].toString().trim(),
              eligibility_id:eligibiliDataID,
              hour: totalHourController.text.toString(),
              latitude: _locationData.latitude.toString() ,
              longtitude: _locationData.longitude.toString()
          );

          await Provider.of<AuthProvider>(context,listen: false).fetchOpportunityLists();

          setState(() {
            _isLoadingAdded = false;
          });

          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: Text(msg[SUCCESS_TITLE]),
              content: Wrap(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 50.0,
                            child: Image.asset(
                              SUCCESS,
                              fit: BoxFit.contain,
                            )),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Opportunity, Successfully",
                          textAlign: TextAlign.center,),
                      )
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
//                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );

        } catch(e){
        setState(() {
          _isLoadingAdded = false;
        });
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(msg[ERR_TITLE]),
            content: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 50.0,
                          child: Image.asset(
                            ERROR,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(e.toString(),
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      }
    else{
        print("validation falied");
        setState(() {
          _isLoadingAdded = false;
        });
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(msg[ERR_TITLE]),
            content: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 50.0,
                          child: Image.asset(
                            ERROR,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(msg[CRED_FILL],
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }

  Future<void> deleteSchedule({@required id}) async{

      print("deleteSchedule called");
      try{
        setState(() {
          _isLoadingDelete = true;
        });

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Processing"),
            content: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Deleting schedule ...",
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
          ),
        );

        await Provider.of<AuthProvider>(context,listen: false).deleteExpertSchedule(
            scheduleID: id
        );

        await Provider.of<GuestProvider>(context,listen: false).fetchExpertSchedule(
            expertId: Provider.of<AuthProvider>(context,listen: false).getAData["id"].toString()
        );

        setState(() {
          _isLoadingDelete = false;
        });

        Navigator.of(context).pop();

      } catch(e){
        setState(() {
          _isLoadingDelete = false;
        });
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(msg[ERR_TITLE]),
            content: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 50.0,
                          child: Image.asset(
                            ERROR,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(e.toString(),
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }

  }
  
}
