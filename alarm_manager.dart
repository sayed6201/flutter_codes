
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nirvanaapp/reminder_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';



//------------------------------------------------------------------------------------------------------
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs



/// The [SharedPreferences] key to access the alarm fire count.
const String countKey = 'count';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

/// Global [SharedPreferences] object.
SharedPreferences prefs;

Future<void> main() async {
  // TODO(bkonyi): uncomment
  WidgetsFlutterBinding.ensureInitialized();

  // Register the UI isolate's SendPort to allow for communication from the
  // background isolate.
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
  prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(countKey)) {
    await prefs.setInt(countKey, 0);
  }
  runApp(AlarmManagerExampleApp());
}

/// Example app for Espresso plugin.
class AlarmManagerExampleApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _AlarmHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _AlarmHomePage extends StatefulWidget {
  _AlarmHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AlarmHomePageState createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<_AlarmHomePage> {
  int _counter = 0;
  // The background
  static SendPort uiSendPort;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    AndroidAlarmManager.initialize();

    // Register for events from the background isolate. These messages will
    // always coincide with an alarm firing.
    port.listen((_) async => await _incrementCounter());
  }

  Future<void> _incrementCounter() async {
    print('Increment counter!');

    // Ensure we've loaded the updated count from the background isolate.
    await prefs.reload();

    setState(() {
      _counter++;
    });
  }


  // The callback for our alarm
  static Future<void> callback() async {
    print('Alarm fired! ${DateTime.now().toString()}');
    _showNotificationWithDefaultSound();
    // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(countKey);
    await prefs.setInt(countKey, currentCount + 1);

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  final routes = <String, WidgetBuilder>{
    ReminderUpdate.tag: (context) => ReminderUpdate(),
  };


  @override
  Widget build(BuildContext context) {
    // TODO(jackson): This has been deprecated and should be replaced
    // with `headline4` when it's available on all the versions of
    // Flutter that we test.
    // ignore: deprecated_member_use
    final textStyle = Theme.of(context).textTheme.display1;
    return
      MaterialApp(
        navigatorKey: navigatorKey,
        routes: routes,
        home:Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Alarm fired $_counter times',
              style: textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total alarms fired: ',
                  style: textStyle,
                ),
                Text(
                  prefs.getInt(countKey).toString(),
                  key: ValueKey('BackgroundCountText'),
                  style: textStyle,
                ),
              ],
            ),
            RaisedButton(
              child: Text(
                'Schedule OneShot Alarm',
              ),
              key: ValueKey('RegisterOneShotAlarm'),
              onPressed: () async {
//                await AndroidAlarmManager.periodic(const Duration(se: 5), Random().nextInt(pow(2, 31)), callback);
                await AndroidAlarmManager.oneShotAt(
//                  const Duration(seconds: 5),
                DateTime.now(),
                  // Ensure we have a unique alarm ID.
                  123,
//                  Random().nextInt(pow(2, 31)),
                  callback,
                  exact: true,
                  wakeup: true,
                  allowWhileIdle: true,
                );
                print("time: ${DateTime.now().toString()}");
              },

            ),
            RaisedButton(
              child: Text(
                'Cancel',
              ),
//              key: ValueKey('cancelKey'),
              onPressed: () async {
                await AndroidAlarmManager.cancel(123);
              },
            ),
          ],
        ),
      ),
    )
      );
  }

  // Method 2
   static Future _showNotificationWithDefaultSound() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  new FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification:(String payload) async{
      navigatorKey.currentState.pushNamed(ReminderUpdate.tag);
//          await Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => ReminderUpdate()),
//          );
    }
    );

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

}