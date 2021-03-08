
import 'package:crowdv/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/expert_medicine_post.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';
import 'expert_suggestion_screen.dart';
import 'dart:io';

class PictureUploadScreen extends StatefulWidget {

  static final String tag = "/PictureUploadScreen";

  @override
  _PictureUploadScreenState createState() => _PictureUploadScreenState();
}

class _PictureUploadScreenState extends State<PictureUploadScreen> {

  var _isInit = true;
  var _isLoading = true;
  var header_text = "Update Picture";
  File _image;


  PermissionStatus permissionStatus;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      print("isloading $_isLoading");
//      await Provider.of<AuthProvider>(context,listen: false).fetchMemberMedicineHistory();
      _isInit = false;
      if(mounted){
        setState(() {
          _isLoading = false;
          print("isloading $_isLoading");
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


//    bookingHistoryIds = Provider.of<AuthProvider>(context).getSelectedBokingDataId;


//    print("medicineList-length-ui:  ${medicineList.length}");


    return
      Scaffold(
          body:
          //in stack widgets are placed on top of each other================================================================
          Stack(children: [
            //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
            SingleChildScrollView(
              child:Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15, bottom: SizeConfig.blockSizeVertical * 5),
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 5
                ),
                child:
                Center(
                  child:
                  Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.blockSizeVertical * 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      height: SizeConfig.blockSizeVertical * 45,
                      width: SizeConfig.blockSizeHorizontal * 45,
                      child:SizedBox(
                          height: SizeConfig.blockSizeVertical * 40,
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child:
                          _image == null ?
                          Image.asset(
                            PROFILE_IMG,
                            fit: BoxFit.cover,
                          )
                              :
                          Image.file(
                            _image,
                            fit: BoxFit.contain,
                          )
                      ),
                    ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      _isLoading ?
                      Center(
                        child: LoaderWidget(
                          text: "Getting image",
                        ),
                      ):
                      RaisedButton(
                        color: primaryColor,
                        onPressed: _getImage,
                        child:Text("Choose Image", style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                )
              ),
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
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
//                      Column(
//                        children: <Widget>[
//                          Text(
//                            header_text,
//                            style: heading_style.copyWith(
//                              fontSize: SizeConfig.blockSizeVertical * 2,
//                            ),
//                          ),
////                    Container(
////                      margin: EdgeInsets.only(
////                          top: SizeConfig.blockSizeVertical * 0.5),
////                      child: Icon(
////                        FontAwesomeIcons.search,
////                        color: Colors.white70,
////                      ),
////                    ),
//                        ],
//                      )
                    ],
                  ),
                )),
          ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: uploadPicture,
          child: Icon(Icons.cloud_upload),
        ),
      );
  }

  Future _getImage() async {
    setState(() {
      _isLoading = true;
    });
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _isLoading = false;
      _image = image;
    });
  }

  void uploadPicture() async{
    if(_image != null)
    try{
      showDialog(
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
                    child: SizedBox(height: 50.0, child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Uploading picture",
                      textAlign: TextAlign.center,
                    ),
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
      await Provider.of<AuthProvider>(context, listen: false).uploadPicture(
          imageFile: _image
      );
      await Provider.of<AuthProvider>(context, listen: false).userProfileData();
      Navigator.of(context).pop();
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
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Picture Set Successfully",
                    textAlign: TextAlign.center,
                  ),
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
//                                                                            Navigator.pushAndRemoveUntil(
//                                                                              context,
//                                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
//                                                                              ModalRoute.withName(UserChooseScreen.tag),
//                                                                            );
            },
          )
        ],
      ),
    );
    }catch(e){
      Navigator.of(context).pop();
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Text("Failed !"),
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
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                     "Opps! Picture Could not set",
                      textAlign: TextAlign.center,
                    ),
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
