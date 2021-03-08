=====================================================================
Radio Button
=====================================================================
void onScannerSelected(String scanner) {
    setState(() {
      _selectedScanner = scanner;
    });
  }

Widget buildSelectScannerRowWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: RadioListTile<String>(
              title: Text('Text Recognition'),
              groupValue: _selectedScanner,
              value: TEXT_SCANNER,
              onChanged: onScannerSelected,
            )
        ),
        Expanded(
          child: RadioListTile<String>(
            title: Text('Barcode Scanner'),
            groupValue: _selectedScanner,
            value: BARCODE_SCANNER,
            onChanged: onScannerSelected,
          ),
        )
      ],
    );
  }


=====================================================================
Customized Radio Button......
=====================================================================
  Widget buildButton() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isBtnSelected = 0;
              });

              Navigator.of(context).push(
                // With MaterialPageRoute, you can pass data between pages,
                // but if you have a more complex app, you will quickly get lost.
                MaterialPageRoute(
                  builder: (context) => SearchHotel(),
                ),
              );
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isBtnSelected == 0
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: isBtnSelected == 0
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: isBtnSelected == 0
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Search',
                      style: isBtnSelected == 0
                          ? selectedTextColor
                          : unSelectedTextColor,
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isBtnSelected = 1;
              });
              Navigator.of(context).push(
                // With MaterialPageRoute, you can pass data between pages,
                // but if you have a more complex app, you will quickly get lost.
                MaterialPageRoute(
                  builder: (context) => SearchLocation(),
                ),
              );
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isBtnSelected == 1
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: isBtnSelected == 1
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.room_service,
                      color: isBtnSelected == 1
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hotels',
                      style: isBtnSelected == 1
                          ? selectedTextColor
                          : unSelectedTextColor,
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isBtnSelected = 2;
              });
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isBtnSelected == 2
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: isBtnSelected == 2
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.card_giftcard,
                      color: isBtnSelected == 2
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Offers',
                      style: isBtnSelected == 2
                          ? selectedTextColor
                          : unSelectedTextColor,
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isBtnSelected = 3;
              });
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isBtnSelected == 3
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: isBtnSelected == 3
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.flight_takeoff,
                      color: isBtnSelected == 3
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Apply for visa',
                      textAlign: TextAlign.center,
                      style: isBtnSelected == 3
                          ? selectedTextColor
                          : unSelectedTextColor,
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isBtnSelected = 4;
              });
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isBtnSelected == 4
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: isBtnSelected == 4
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.lightbulb_outline,
                      color: isBtnSelected == 4
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Travel tips',
                      style: isBtnSelected == 4
                          ? selectedTextColor
                          : unSelectedTextColor,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }



=====================================================================
Customized Radio Button......
=====================================================================
    Widget buildSearchType() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isSearchSelected = 0;
              });

//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) => SearchHotel(),
//                ),
//              );
            },
            child:
            Wrap(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isSearchSelected == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: isSearchSelected == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: isSearchSelected == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hotels',
                          style: isSearchSelected == 0
                              ? selectedTextColor
                              : unSelectedTextColor,
                        )
                      ],
                    )
                )
              ],
            )
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSearchSelected = 1;
              });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) => SearchLocation(),
//                ),
//              );
            },
            child: Wrap(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isSearchSelected == 1
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: isSearchSelected == 1
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.hotel,
                          color: isSearchSelected == 1
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hotels',
                          style: isSearchSelected == 1
                              ? selectedTextColor
                              : unSelectedTextColor,
                        )
                      ],
                    )
                )
              ],
                ),
          ),
        ],
      ),
    );
  }