import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:crowdv/screens/catagory_screen.dart';
import 'package:crowdv/screens/home/home_notification.dart';
import 'package:crowdv/screens/reruiter_profile_view.dart';
import 'package:crowdv/screens/verify_email.dart';
import 'package:crowdv/screens/vol_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/color_file.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../string.dart';
import '../about_us.dart';
import '../home_data_screen.dart';
import 'home_history_page.dart';

//FCM imports
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//local notification
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';


class HomeScreen extends StatefulWidget {
  static const String tag = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  int _screenIndex = 0;

  var homeScaffoldKey = GlobalKey<ScaffoldState>();
  Map<String,dynamic> userProfileData = {};
  Map<String,dynamic> email = {};

  List<Widget> listOfScreen =  [
    RecruiterProfileView(),
    HistoryScreen(),
    CatagoryScreen(),
    NotificationSceen()
  ];

  //firebase FCM
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  static int i = 0;

  //local notification flutter
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettings;

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
      },
    );
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
//          onNotificationClick(payload);    // your call back to the UI
        });
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
      alert: false,
      badge: true,
      sound: true,
    );
  }

  Future<void> showNotification(Map<String, dynamic> message) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.Max,
      priority: Priority.High,
      autoCancel: false,
      playSound: true,
      timeoutAfter: 7000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']["body"], //null
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  var _isInitCheck = true;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }

  @override
  void initState() {
    super.initState();
    init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Future.delayed(Duration.zero).then((_){
      //FCM
      if (Platform.isIOS) {
        iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
          // save the token  OR subscribe to a topic here
          _saveDeviceToken();
        });
        _fcm.requestNotificationPermissions(IosNotificationSettings());
      }else{
        _saveDeviceToken();
        print("executed");
      }
    });
    //FCM
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }else{
      print("executed");
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        if(i%2==0) {
          print("onMessage: $message");
//          showDialog(
//            context: context,
//            builder: (context) => AlertDialog(
//              content: ListTile(
//                title: Text(message['notification']['title']),
//                subtitle: Text(message['notification']['body']),
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('Ok'),
//                  onPressed: () => Navigator.of(context).pop(),
//                ),
//              ],
//            ),
//          );

          showNotification(message);
        };
        i++;

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  // Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    String uid = Provider.of<AuthProvider>(context, listen: false).getAData["id"];
    if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){
      uid = "rec_"+uid;
    }else{
      uid = "vol_"+uid;
    }

    // FirebaseUser user = await _auth.currentUser();
    print("uid: $uid");

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid);
//          .collection('tokens')
//          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
    print("Token saved $uid - token: ${fcmToken}");
  }

  _tabSelectAction(int index) {
    _currentTab = index;

//    _pageController.animateToPage(index,
//        duration: Duration(milliseconds: 300), curve: Curves.ease);
    if (index == 0) {
      setState(() {
        _screenIndex = 0;
      });
      return;
    }
    if (index == 1) {
      setState(() {
        _screenIndex = 1;
      });
      return;
    }
    if (index == 2) {
      setState(() {
        _screenIndex = 2;
      });
      return;
    }
    if (index == 3 ) {
      setState(() {
        _screenIndex = 3;
      });
      return;
    }

  }

  Map<String,String> langMap = {};

  int totalUnreadNotification = 0;

  @override
  Widget build(BuildContext context) {

    if(Provider.of<AuthProvider>(context).getUserRoleID == VOLUNTEER_ROLE_ID){
      listOfScreen =
      [
//      HomeMainScreen(),
        VolunteerProfileView(),
        HistoryScreen(),
        CatagoryScreen(),
        NotificationSceen()
      ];
    }


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor.withOpacity(0.5)
    ));

    userProfileData = Provider.of<AuthProvider>(context).getAData;
    totalUnreadNotification = Provider.of<AuthProvider>(context).getTotalUnreadNotification;
    email = Provider.of<AuthProvider>(context).getdataNot;
    return  Scaffold(
//      appBar: AppBar(
//
//      ),
        body:
        email == null ?
        listOfScreen[_screenIndex] : email["login"] == "1" ? HomeDataLoaded() : listOfScreen[_screenIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentTab,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: _tabSelectAction,
          items: [
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.userAlt, size: 19,),
              title: Text("Profile"),
              activeColor: Theme.of(context).primaryColor,
            ),
            BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.history, size: 19,),
                title:
                Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID ?
                Text("History") :
                Text("Job History"),
                activeColor: Theme.of(context).primaryColor
            ),
            BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.search, size: 19,),
                title: Text("Search"),
                activeColor: Theme.of(context).primaryColor
            ),
//            if(Provider.of<AuthProvider>(context).getUserRoleID == REQRUITER_ROLE_ID)
            BottomNavyBarItem(
                icon:
                totalUnreadNotification == 0 ?
                Icon(FontAwesomeIcons.bell, size: 19,)
                :Icon(Icons.notifications_active, size: 19,),
                title: Text("Notification"),
                activeColor: Theme.of(context).primaryColor
            ),
          ],
        ),
//        drawer: _buildDrawer(context),
    );
  }

  Drawer _buildDrawer(context){
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      color: primaryColor
                  ),
                  padding: EdgeInsets.all(10.0),
                  child:Container(
                    child: Column(
                      //verticle axis
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Horizontal
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          LOGO,
                          width: SizeConfig.blockSizeHorizontal * 50,
                          height: SizeConfig.blockSizeVertical * 12,
                          fit: BoxFit.fitWidth,
                        ),
                        Text('',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ), ),
                          Text("",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ),
                ),
//                ListTile(
//                  leading: Icon(Icons.settings_input_composite),
//                  title: Text('Opportunities'),
//                  onTap: (){
//                    Navigator.of(context).pushNamed(
//                      CatagoryScreen.tag,
//                    );
//                    Navigator.pop(context);
//                  },
//                ),
//                ListTile(
//                  leading: Icon(Icons.history),
//                  title: Text('History'),
//                  onTap: (){
//                    setState(() {
//
//                    });
//                    Navigator.pop(context);
//                  },
//                ),
//                ListTile(
//                  leading: Icon(Icons.settings),
//                  title: Text('Settings'),
//                  onTap: (){
//                    setState(() {
//
//                    });
//                    Navigator.pop(context);
//                  },
//                ),
//                Divider(
//                  color: Colors.black45,
//                  indent: 16.0,
//                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About us'),
                  onTap: () async{
                    await Navigator.of(context).pushNamed(
                      AboutUsScreen.tag,
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.assignment_turned_in),
                  title: Text('Privacy'),
                  onTap: () async{
                    await Navigator.of(context).pushNamed(
                      AboutUsScreen.tag,
                    );
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Text("V 1.0.0")
        ],
      )
    );
  }
}
