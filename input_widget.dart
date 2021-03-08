
/*
===========================================================================================
DatePicker
library: flutter_datetime_picker
===========================================================================================
*/

            FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      labelStyle: selectedCategoryTextStyle,
                                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                      hintText: 'Please select expense',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                  isEmpty: destinationDropdownValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: destinationDropdownValue,
                                      isDense: true,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          destinationDropdownValue = newValue;
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: destinationsLists.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),



/*
===========================================================================================
DatePicker
library: flutter_datetime_picker
===========================================================================================
*/
FlatButton(
    onPressed: () {
        DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(2000, 1, 1)
          maxTime: DateTime(2022, 12, 31),
          onChanged: (date) {print('change $date');},
          onConfirm: (date) {print('confirm $date');},
          currentTime: DateTime.now(), locale: LocaleType.en);},
    child: Text('Show DateTime Picker',)
);


-----------------------------------
Date + time picker
-----------------------------------
Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      elevation: 4.0,
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            theme: DatePickerTheme(
                                              containerHeight: 210.0,
                                            ),
                                            showTitleActions: true,
                                            minTime: DateTime(2000, 1, 1),
                                            maxTime: DateTime(2022, 12, 31),
                                            onConfirm: (date) {
                                          print('confirm $date');
                                          _date =
                                              '${date.year} - ${date.month} - ${date.day}';
                                          setState(() {});
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.date_range,
                                                        size: 18.0,
                                                        color: Colors.teal,
                                                      ),
                                                      Text(
                                                        " $_date",
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "  Change",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      elevation: 4.0,
                                      onPressed: () {
                                        DatePicker.showTimePicker(context,
                                            theme: DatePickerTheme(
                                              containerHeight: 210.0,
                                            ),
                                            showTitleActions: true,
                                            onConfirm: (time) {
                                          print('confirm $time');
                                          _time =
                                              '${time.hour} : ${time.minute} : ${time.second}';
                                          setState(() {});
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 18.0,
                                                        color: Colors.teal,
                                                      ),
                                                      Text(
                                                        " $_time",
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "  Change",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),