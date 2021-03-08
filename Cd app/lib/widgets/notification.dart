import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crowdv/color_file.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/text_style.dart';
import 'package:provider/provider.dart';

Future<TimeOfDay> _selectTime(BuildContext context,
    {@required DateTime initialDate}) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
  );
}

Future<DateTime> _selectDateTime(BuildContext context,
    {@required DateTime initialDate}) {
  final now = DateTime.now();
  final newestDate = initialDate.isAfter(now) ? initialDate : now;

  return showDatePicker(
    context: context,
    initialDate: newestDate.add(Duration(seconds: 1)),
    firstDate: now,
    lastDate: DateTime(2100),
  );
}

Dialog showDateTimeDialog(
    BuildContext context, {
      @required ValueChanged<DateTime> onSelectedDate,
      @required DateTime initialDate,
    }) {
  final dialog = Dialog(
    child: DateTimeDialog(
        onSelectedDate: onSelectedDate, initialDate: initialDate),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}

class DateTimeDialog extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;

  const DateTimeDialog({
    @required this.onSelectedDate,
    @required this.initialDate,
    Key key,
  }) : super(key: key);
  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Choose Appointment Date & Time',
          style: heading_style.copyWith(color: Colors.black38, fontSize: SizeConfig.blockSizeVertical * 2.3),
        ),
        Divider(),
        SizedBox(height: SizeConfig.blockSizeVertical * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: primaryColor,
              child: Text(
                  DateFormat('dd-MM-yyyy').format(selectedDate),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final date = await _selectDateTime(context,
                    initialDate: selectedDate);
                if (date == null) return;

                setState(() {
                  selectedDate = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    selectedDate.hour,
                    selectedDate.minute,
                  );
                });

                widget.onSelectedDate(selectedDate);
              },
            ),
            const SizedBox(width: 8),
            RaisedButton(
              color: primaryColor,
              child: Text(
                  DateFormat('HH:mm').format(selectedDate),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final time =
                await _selectTime(context, initialDate: selectedDate);
                if (time == null) return;

                setState(() {
                  selectedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    time.hour,
                    time.minute,
                  );
                });

                widget.onSelectedDate(selectedDate);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        OutlineButton(
          child: Text(
              'Set',
//            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async{
            await Provider.of<AuthProvider>(context,listen: false)
                .setBookingDateTime(
                date: DateFormat('dd-MM-yyyy').format(selectedDate),
                time: DateFormat('HH:mm').format(selectedDate));
            Navigator.of(context).pop();
          },
          highlightColor: Colors.orange,
        ),
      ],
    ),
  );
}