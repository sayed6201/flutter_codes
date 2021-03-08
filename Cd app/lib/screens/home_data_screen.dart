
import 'package:flutter/material.dart';
import 'package:crowdv/widgets/home_widget_loder.dart';

class HomeDataLoaded extends StatefulWidget {
  static final String tag = '/NOT_LOGGED_IN_USER';
  @override
  _HomeDataLoadedState createState() => _HomeDataLoadedState();
}

class _HomeDataLoadedState extends State<HomeDataLoaded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeWidgetLoader(),
    );
  }
}
