

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/text_style.dart';

class NoData extends StatelessWidget {

  String text;
  NoData({this.text = "No data found"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.hourglass_empty,
            color: Colors.black38,
            size: SizeConfig.blockSizeVertical * 10,),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Text("$text",style: big_style.copyWith(
              fontSize: SizeConfig.blockSizeVertical * 2
          ),)
        ],
      ),
    ) ;
  }
}
