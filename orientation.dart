  
/*
===========================================================================================
curved_navigation_bar library usage
===========================================================================================
*/

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return new MaterialApp(...);
    }
}

------------------
Update
-------------------

This solution mightn't work for some IOS devices as mentioned in the updated flutter documentation on Oct 2019.

They Advise to fixed the orientation by setting UISupportedInterfaceOrientations in Info.plist like this

<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>