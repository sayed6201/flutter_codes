import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdv/size_config/SizeConfig.dart';

import '../text_style.dart';

class LoaderWidget extends StatelessWidget {
  String text;
  LoaderWidget({this.text = "Loading"});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 10,),
          Text("${this.text} ... ",
            style: big_style.copyWith(
              fontSize: SizeConfig.blockSizeVertical * 2
            )
            ,)
        ],
      ),
    );
  }
}
