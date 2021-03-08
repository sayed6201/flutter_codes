import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crowdv/color_file.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/text_style.dart';
import 'package:crowdv/widgets/notification.dart';
import 'package:provider/provider.dart';

class DateTimePickerWidget2 extends StatefulWidget {
  @override
  _DateTimePickerWidget2State createState() => _DateTimePickerWidget2State();
}

class _DateTimePickerWidget2State extends State<DateTimePickerWidget2> {
  DateTime selectedDate = DateTime.now();
  String dateTime ="No date selcted";
  Map<String,dynamic> dateMap = {};

//  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  @override
  Widget build(BuildContext context) {

    dateMap = Provider.of<AuthProvider>(context).getBookingDateTime;
    if(dateMap["date"] != null || dateMap["date"] != null ){
      dateTime = "Date : ${dateMap["date"]} - Time: ${dateMap["date"] }";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(dateTime, style: heading_style.copyWith(color: Colors.black38),),
        RaisedButton(
          color: primaryColor,
          child: Text('Choose new date & time', style: heading_style,),
          onPressed: () async {
            showDateTimeDialog(context, initialDate: selectedDate,
                onSelectedDate: (selectedDate) {
                  setState(() {
//                    this.selectedDate = selectedDate;
////                    dateTime = dateFormat.format(this.selectedDate);
////                    print("my data: $selectedDate");
                  });
                });
          },
        ),
      ],
    );
  }
}