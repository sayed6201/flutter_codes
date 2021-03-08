//string to double conversion....
double.parse(amountController.text),


//string conversion
DateTime.now().toString();


//double rounding
1.toStringAsFixed(3);  // 1.000
(4321.12345678).toStringAsFixed(3);  // 4321.123
(4321.12345678).toStringAsFixed(5);  // 4321.12346
123456789012345678901.toStringAsFixed(3);  // 123456789012345683968.000
1000000000000000000000.toStringAsFixed(3); // 1e+21
5.25.toStringAsFixed(0); // 5



---------------------Curent time flutter------------------------------
		  DateTime now = DateTime.now();
          String formattedDate = DateFormat('kk:mm').format(now);
          print('Time : ${formattedDate}');


-----------------------Current date time-------------------------------

		  DateFormat format = new DateFormat("HH:mm:ss");
          DateTime time = format.parse("3:02:00");
          time.toLocal();


-----------------------Objext to json conversion-------------------------------
		JsonEncoder.withIndent(' ').convert(_paymentToken?.toJson() ?? {}),