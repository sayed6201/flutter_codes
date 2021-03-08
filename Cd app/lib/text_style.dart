
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:crowdv/size_config/SizeConfig.dart';

final TextStyle heading_style = const TextStyle(
    color: Colors.white70,
    fontWeight: FontWeight.w700);

final TextStyle big_style = const TextStyle(
    color: Colors.black38,
    fontWeight: FontWeight.w700);

final TextStyle fadedTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Color(0x99FFFFFF),
);

final TextStyle whiteHeadingTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle categoryTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle selectedCategoryTextStyle = categoryTextStyle.copyWith(
  color: Color(0xFFFF4700),
);

final TextStyle eventTitleTextStyle = TextStyle(
  fontSize: SizeConfig.blockSizeVertical *  0.015,
  fontWeight: FontWeight.bold,
  color: Color(0xFF000000),
);

final TextStyle eventWhiteTitleTextStyle = TextStyle(
  fontSize: SizeConfig.screenHeight * 0.025,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle eventLocationTextStyle = TextStyle(
  fontSize: SizeConfig.screenHeight *  0.015,
  color: Color(0xFF000000),
);

final TextStyle guestTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w800,
  color: Color(0xFF000000),
);

final TextStyle punchLine1TextStyle = TextStyle(
  fontSize: SizeConfig.screenHeight * 0.02,
  fontWeight: FontWeight.w800,
  color: Colors.white,
);
final TextStyle descriptionTextStyle = TextStyle(
  fontSize: SizeConfig.screenHeight *  0.02,
  color: Colors.white,
);
final TextStyle punchLine2TextStyle = punchLine1TextStyle.copyWith(color: Color(0xFF000000));



