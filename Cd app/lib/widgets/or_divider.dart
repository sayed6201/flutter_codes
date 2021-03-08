import 'package:flutter/material.dart';
import 'package:crowdv/color_file.dart';
import 'package:crowdv/size_config/SizeConfig.dart';


class OrDivider extends StatelessWidget {
  var text ="OR";
  OrDivider(this.text);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.97,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Colors.black45,
                fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.w900,

              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Colors.black45,
        height: 2,
      ),
    );
  }
}