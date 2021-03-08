import 'dart:convert';
import 'dart:ui';

import 'package:crowdv/color_file.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/string.dart';
import 'package:crowdv/text_style.dart';
import 'package:crowdv/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class CertificatePage extends StatefulWidget {

  static const tag = "/certificatePage";

  @override
  _CertificatePageState createState() => new _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  GlobalKey globalKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String,dynamic> profielData = {};
  var _isLoading = false;
  var _isLoadingScreen = true;
  PermissionStatus permissionStatus;
  String hour = "0.0";
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage(pixelRatio: 5.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
    await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
      name: "CrowdV_Certificate"
    );
    print(result);


    final snackBar = SnackBar(content: Text('Certificate Saved in you gallary'),
      duration: Duration(seconds: 10),
      backgroundColor: primaryColor,
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
        },
      ),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes() async {

      try{
        setState(() {
          _isLoading = true;
        });
        var pngBytes = await _capturePng();
        var bs64 = base64Encode(pngBytes);
        print(pngBytes);
        print(bs64);
        setState(() {
          _isLoading = false;
        });

      }catch(e){
        setState(() {
          _isLoading = false;
        });
      final snackBar = SnackBar(
        content: Text('Opps! Something went wrong'),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
          },
        ),);
      _scaffoldKey.currentState.showSnackBar(snackBar);

      print(e.toString());
      }
//    }

  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isInit){
        hour = await Provider.of<AuthProvider>(context, listen: false).fetchVolTotalHour();

      setState(() {
        _isInit = false;
        _isLoadingScreen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    profielData = Provider.of<AuthProvider>(context).getAData;
    print("total hour $hour");

    return
      Scaffold(
        key: _scaffoldKey,
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: SizeConfig.safeBlockVertical * 5,),
            Container(
                child:
                _isLoadingScreen ?
                Center(
                      child: LoaderWidget(
                        text: "Fetching Information ...",
                      ),
                    )
                    :
                _isLoading ?
                Center(
                  child: LoaderWidget(
                    text: "Saving Certificate ...",
                  ),
                )
                    :
                RepaintBoundary(
                    key: globalKey,
                    child:Center(
                        child: Card(
                            elevation: 8,
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
//                                      Padding(
//                                        padding: EdgeInsets.only(top: 0,bottom: 0),
//                                        child: SizedBox(
//                                            height: SizeConfig.blockSizeVertical * 30,
//                                            width: SizeConfig.blockSizeVertical * 30,
//                                            child: Image.asset(
//                                              LOGO_CER,
//                                              fit: BoxFit.contain,
//                                            )),
//                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 5),
                                      Text("Volunteering Certificate",
                                          textAlign: TextAlign.start,
                                          style: heading_style.copyWith(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900
                                          )),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
                                      Text("Is hereby granted to",
                                          textAlign: TextAlign.end,
                                          style: heading_style.copyWith(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w900
                                          )
                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                      Text("${profielData["volunteer_name"].toString().toUpperCase()}",
                                          textAlign: TextAlign.start,
                                          style: heading_style.copyWith(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                          )),
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                        children: <Widget>[
//                                          Expanded(
//                                            child: Column(
//                                              children: <Widget>[
//
//                                              ],
//                                            ),
//                                          ),
//                                          Container(
//                                            width: 2,
//                                            height: SizeConfig.blockSizeVertical * 7,
//                                            color: Colors.grey,
//                                          ),
//                                          Expanded(
//                                            child: Column(
//                                              children: <Widget>[
////                                                Text("This Certifies ",
////                                                    textAlign: TextAlign.start,
////                                                    style: heading_style.copyWith(
////                                                        fontSize: 20,
////                                                        color: Colors.grey,
////                                                        fontWeight: FontWeight.w400
////                                                    )),
//                                                Text("${profielData["volunteer_name"].toString().toUpperCase()}",
//                                                    textAlign: TextAlign.start,
//                                                    style: heading_style.copyWith(
//                                                        fontSize: 20,
//                                                        color: Colors.grey,
//                                                        fontWeight: FontWeight.w400
//                                                    )),
//                                              ],
//                                            ),
//                                          )
//                                        ],
//                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 5),
                                      Text(
                                        "To certify that they have completed to satisfaction \n${hour ?? 0.0} Hours of community services by using the CrowdV platform.",
                                        textAlign: TextAlign.center,
                                        style: heading_style.copyWith(
                                            color: Colors.black,
                                          fontSize: 16
                                        ),
                                      ),

                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: SizedBox(
                                                height: SizeConfig.blockSizeVertical * 10,
                                                width: SizeConfig.blockSizeVertical * 25,
                                                child: Image.asset(
                                                  LOGO_CER,
                                                  fit: BoxFit.contain,
                                                )),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(top: 0,bottom: 0),
                                                  child: SizedBox(
                                                      height: SizeConfig.blockSizeVertical * 5,
                                                      width: SizeConfig.blockSizeVertical * 15,
                                                      child: Image.asset(
                                                        SIGNATURE,
                                                        fit: BoxFit.contain,
                                                      )),
                                                ),
                                                Text(
                                                  "M. mizanur rahman",
                                                  textAlign: TextAlign.center,
                                                  style: heading_style.copyWith(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                SizedBox(height: 2,),
                                                Text(
                                                  "CEO CrowdV\n",
                                                  textAlign: TextAlign.center,
                                                  style: heading_style.copyWith(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
//                                          SizedBox(
//                                        height: SizeConfig.blockSizeVertical * 10,
//                                        width: SizeConfig.blockSizeVertical * 15,
//                                        child: Image.asset(
//                                          CDI_LOGO,
//                                          fit: BoxFit.contain,
//                                        ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                        )
                    )
                )
            ),
          ],
        ),
        floatingActionButton:
        FloatingActionButton(
          onPressed: _printPngBytes,
          child: Icon(Icons.save,color: Colors.white,),
        ),
      );
  }

}