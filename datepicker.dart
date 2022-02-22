=============================================================================================
Dissmissable: 
=============================================================================================
for disabling future dates just set lastDate to present date which disable every date after current date

 await showDatePicker(
  context: context,
  initialDate: _selectedDate,
  firstDate: DateTime(1850),
  lastDate: DateTime.now(),
);
and for diabling previous date set firstDate to current date which disable every date before current date

 await showDatePicker(
  context: context,
  initialDate: _selectedDate,
  firstDate:DateTime.now(),
  lastDate: DateTime(2050),
);




=============================================================================================
Dissmissable: 
=============================================================================================
Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedTestDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedTestDate)
      setState(() {
        selectedTestDate = picked;
        print("${selectedTestDate.toLocal()}".split(' ')[0]);
        setState(() {
          selectedTestdateString = "${selectedTestDate.toLocal()}".split(' ')[0];
        });
      });

  }


  Future<TimeOfDay?> datePicker2(){

    return showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
      helpText: 'Select Date',
      initialDate: selectedTestDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 14)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedTestDate = pickedDate;
//        selectedTestdateString = "${selectedTestDate.toLocal()}".split(' ')[0];
        selectedTestdateString = DateFormat('dd MM yyyy').format(selectedTestDate).replaceAll(" ", "/");;

        print(selectedTestdateString);
      });
    });
  }