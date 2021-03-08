
/*
===========================================================================================
ENUM
----
used to convert text into number...
===========================================================================================
*/

DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ; 




/*
===========================================================================================
ENUM
----
used to convert text into number...
===========================================================================================
*/

Datetime currentDateTime = DateTime.now();

//Converting datetine into convienient format-----------------------------------------------
ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy').format(
              order.dateTime
            )),
            trailing: IconButton(
              onPressed: (){},
              icon: Icon(Icons.expand_more),
            ),
          )

/*
===========================================================================================
ENUM
----
used to convert text into number...
===========================================================================================
*/

dateociker
date_range_picker: ^1.0.5

Usage #
-----------
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
...
new MaterialButton(
    color: Colors.deepOrangeAccent,
    onPressed: () async {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
          context: context,
          initialFirstDate: new DateTime.now(),
          initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
          firstDate: new DateTime(2015),
          lastDate: new DateTime(2020)
      );
      if (picked != null && picked.length == 2) {
          print(picked);
      }
    },
    child: new Text("Pick date range")
)