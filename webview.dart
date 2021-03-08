import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatefulWidget {
  String url = "";
  WebViewScreen({@required this.url});
  @override
  _WebViewScreenState createState() => new _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  String token;

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
          if(state.url.toString().contains("https://call4tours.com/en/login")) Navigator.of(context).pop();
        });

    // Add a listener to on url changed+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          print("URL changed: $url");
          //if(url.contains("https://call4tours.com/en/login")) Navigator.of(context).pop();

//          if (url.startsWith(Constants.redirectUri)) {
//            RegExp regExp = new RegExp("#access_token=(.*)");
//            this.token = regExp.firstMatch(url)?.group(1);
//            print("token $token");
//
//            //saveToken(token);
//            Navigator.of(context).pushNamedAndRemoveUntil(
//                "/home", (Route<dynamic> route) => false);
//            flutterWebviewPlugin.close();
//          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return new WebviewScaffold(
        url: widget.url,
        appBar: new AppBar(
          title: new Text("Make Payment"),
        ));
  }
}