import 'dart:convert';
import 'dart:ui';

import 'package:crowdv/color_file.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/string.dart';
import 'package:crowdv/text_style.dart';
import 'package:crowdv/widgets/loader_widget.dart';
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
  PermissionStatus permissionStatus;
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
  Widget build(BuildContext context) {

    profielData = Provider.of<AuthProvider>(context).getUserProfileData;

    return
      Scaffold(
        key: _scaffoldKey,
        body: Container(
          child:
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
                            padding: EdgeInsets.all(20),
                            color: primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 10,bottom: 5),
                                  child: SizedBox(
                                      height: SizeConfig.blockSizeVertical * 15,
                                      width: SizeConfig.blockSizeVertical * 15,
                                      child: Image.asset(
                                        LOGO,
                                        fit: BoxFit.contain,
                                      )),
                                ),
                                Text(
                                  "This is to certify that Mr ${profielData["volunteer_name"]} \n has worked with CrowdV, \n and are satisfied with his performance",
                                  textAlign: TextAlign.center,
                                  style: heading_style,
                                ),

                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
//                            SizedBox(
//                                height: SizeConfig.blockSizeVertical * 10,
//                                width: SizeConfig.blockSizeVertical * 15,
//                                child: Image.asset(
//                                  CERTIFIED,
//                                  fit: BoxFit.contain,
//                                )),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Mr mizanur rahman",
                                          textAlign: TextAlign.center,
                                          style: heading_style.copyWith(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                        SizedBox(height: 2,),
                                        Text(
                                          "CEO & MD CrowdV\n",
                                          textAlign: TextAlign.center,
                                          style: heading_style.copyWith(
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical * 10,
                                        width: SizeConfig.blockSizeVertical * 15,
                                        child: Image.asset(
                                          CERTIFIED,
                                          fit: BoxFit.contain,
                                        ))
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
        floatingActionButton:
        FloatingActionButton(
          onPressed: _printPngBytes,
          child: Icon(Icons.save,color: Colors.white,),
        ),
      );
  }

}