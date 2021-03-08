=============================================================================================
ROW: Expanded
Taking equal place of a parent 
=============================================================================================

Widget buildSelectImageRowWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child:
              RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    onPickImageSelected(CAMERA_SOURCE);
                  },
                  child: const Text('Camera')
              ),
            )
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child:
              RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    onPickImageSelected(GALLERY_SOURCE);
                  },
                  child: const Text('Gallery')
              ),
            )
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child:
              RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    onPickImageSelected(GALLERY_SOURCE);
                  },
                  child: const Text('Gallery')
              ),
            )
        )
      ],
    );
  }



=============================================================================================
ROW: Align
Positioning item at the end .................
=============================================================================================

          Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.image),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          textData[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          textData[index].des,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: null,
                              color: Colors.blue,
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: null,
                              color: Colors.blue,
                              icon: Icon(Icons.share),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ),