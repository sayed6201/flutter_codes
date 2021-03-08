<<<<<<< HEAD
/*
===========================================================================================
Local app cardview design
===========================================================================================
*/
=======
=============================
from home pc
=============================

>>>>>>> a75e7e152ffa214982c48856643019475e5394ac
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_text_converter/styleguide.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'datahost/event_details_page.dart';
import 'detailwidget.dart';
import './helper/DatabaseHelper.dart';
import 'HistoryListWidget.dart';
//import 'package:custom_radio/custom_radio.dart';

const String TEXT_SCANNER = 'TEXT_SCANNER';
const String BARCODE_SCANNER = 'BARCODE_SCANNER';

//const String testDevice = "576098eb-4371-4106-80fe-df04dc0ff070";
const String bannerUnitId = "ca-app-pub-3940256099942544/6300978111";
const String interstetialUnitId = "ca-app-pub-3940256099942544/1033173712";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
      builder: (BuildContext context, Widget child){
        var mediaquery = MediaQuery.of(context);
        var paddingBottom = 50.0;
        if(mediaquery.orientation == Orientation.landscape){
          paddingBottom = 0.0;
        }
          return Padding(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: child,
          );
      },
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String CAMERA_SOURCE = 'CAMERA_SOURCE';
  static const String GALLERY_SOURCE = 'GALLERY_SOURCE';

  final dbHelper = DatabaseHelper.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File _file;
  String _selectedScanner = TEXT_SCANNER;
//  testDevice != null ? <String>[testDevice] :
//  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    testDevices: null,
//    nonPersonalizedAds: true,
//    keywords: <String>['Game', 'Mario'],
//  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    birthday: DateTime.now(),
    childDirected: false,
//    designedForFamilies: false,
//    gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );


  BannerAd craeteBannarAd(){
     return myBanner
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,);
  }



  InterstitialAd myInterstitial() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          _interstitialAd..load();
        } else if (event == MobileAdEvent.closed) {
          _interstitialAd = myInterstitial()..load();
        }
      },
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8236503696981252~5724618092");
    //Change appId With Admob Id
    _bannerAd = craeteBannarAd();
    _interstitialAd = myInterstitial()..load();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final columns = List<Widget>();
//    columns.add(buildRowTitle(context, 'Select Scanner Type'));
    columns.add(buildSelectScannerRowWidget(context));
//    columns.add(buildRowTitle(context, 'Pick Image'));
//    columns.add(buildSelectImageRowWidget(context));

//    if (_file == null) {
//      columns.add(buildRowTitle(context, 'Pick Image'));
//      columns.add(buildSelectImageRowWidget(context));
//    } else {
//      columns.add(buildImageRow(context, _file));
//      columns.add(buildDeleteRow(context));
//    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Scanner App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                _interstitialAd
                  ..load()
                  ..show();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EventDetailsPage()),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children:columns,
          ),
        )),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.only(left: 31),
//              child: Align(
//                alignment: Alignment.bottomLeft,
//                child: FloatingActionButton(
//                  onPressed: () {
//                    onPickImageSelected(CAMERA_SOURCE);
//                  },
//                  child: Icon(Icons.camera_alt),
//                ),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(left: 31),
//              child: Align(
//                alignment: Alignment.bottomRight,
//                child: FloatingActionButton(
//                  onPressed: () {
//                    onPickImageSelected(GALLERY_SOURCE);
//                  },
//                  child: Icon(Icons.photo_library),
//                ),
//              ),
//            ),
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      // With MaterialPageRoute, you can pass data between pages,
                      // but if you have a more complex app, you will quickly get lost.
                      MaterialPageRoute(
                        builder: (context) => HistoryListWidget(),
                      ),
                    );
                  },
                  child: Icon(Icons.list),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildRowTitle(BuildContext context, String title) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline,
      ),
    ));
  }

  Widget buildSelectImageRowWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                color: Theme.of(context).primaryColor,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  onPickImageSelected(CAMERA_SOURCE);
                },
                icon: Icon(Icons.camera_alt),
                iconSize: 100,
              ),
            )),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      color: Theme.of(context).primaryColor,
                      splashColor: Colors.blueGrey,
                      onPressed: () {
                        onPickImageSelected(GALLERY_SOURCE);
                      },
                      icon: Icon(Icons.photo_library),
                      iconSize: 100,
                    ))),
          ],
        ),

      ],
    );
  }

  Widget buildSelectScannerRowWidget(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: Image.asset(
                "assets/event_images/ok.PNG",
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Choose Scanner Type',
                          style: eventTitleTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
//                        FittedBox(
//                          child: Row(
//                            children: <Widget>[
//                              Icon(Icons.location_on),
//                              SizedBox(
//                                width: 5,
//                              ),
//                              Text(
//                                "down",
//                                style: eventLocationTextStyle,
//                              ),
//                            ],
//                          ),
//                        ),
                      ],
                    ),
                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Text(
//                      "up",
//                      textAlign: TextAlign.right,
//                      style: eventLocationTextStyle.copyWith(
//                        fontWeight: FontWeight.w900,
//                      ),
//                    ),
//                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: RadioListTile<String>(
                  title: Text('Text Scanner'),
                  groupValue: _selectedScanner,
                  value: TEXT_SCANNER,
                  onChanged: onScannerSelected,
                )),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Barcode Scanner'),
                    groupValue: _selectedScanner,
                    value: BARCODE_SCANNER,
                    onChanged: onScannerSelected,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      onPickImageSelected(CAMERA_SOURCE);
                    },
                    icon: Icon(Icons.camera_alt),
                    iconSize: 100,
                  ),
                )),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          color: Theme.of(context).primaryColor,
                          splashColor: Colors.blueGrey,
                          onPressed: () {
                            onPickImageSelected(GALLERY_SOURCE);
                          },
                          icon: Icon(Icons.photo_library),
                          iconSize: 100,
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildImageRow(BuildContext context, File file) {
    return SizedBox(
        height: 500.0,
        child: Image.file(
          file,
          fit: BoxFit.fitWidth,
        ));
  }

  Widget buildDeleteRow(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            splashColor: Colors.blueGrey,
            onPressed: () {
              setState(() {
                _file = null;
              });
              ;
            },
            child: const Text('Delete Image')),
      ),
    );
  }

  void onScannerSelected(String scanner) {
    setState(() {
      _selectedScanner = scanner;
    });
  }

  void onPickImageSelected(String source) async {
    var imageSource;
    if (source == CAMERA_SOURCE) {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final scaffold = _scaffoldKey.currentState;

    try {
      final file = await ImagePicker.pickImage(source: imageSource);
      print(file.toString());
      if (file == null) {
        throw Exception('File is not available');
      }

      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => DetailWidget(file, _selectedScanner)),
      );
    } catch (e) {
      print(e.toString());
//      scaffold.showSnackBar(SnackBar(
//        content: Text(e.toString()),
//      ));
    }
  }
}
