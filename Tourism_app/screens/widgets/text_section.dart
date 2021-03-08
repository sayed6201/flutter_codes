import 'package:flutter/material.dart';
// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.



class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  static const double _hPad = 16.0;

  TextSection(this._title,this._body);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad,32.0,_hPad,4.0),
          child: Text(_title, style: Theme.of(context).textTheme.title),
    ),

        Container(
          padding: const EdgeInsets.fromLTRB(_hPad,10.0,_hPad,_hPad),
          child: Text(_body, style: Theme.of(context).textTheme.body1),
    )
      ],
  );
}
}

