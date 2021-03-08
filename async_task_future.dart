=============================================================================================
FutureBuilder: Listview.Builder
Note:
loading async task or future List<Map> to Listview...............
=============================================================================================

import 'package:flutter/material.dart';
import 'package:flutter_app_text_converter/models/TextData.dart';
import 'package:sqflite/sqlite_api.dart';
import './helper/DatabaseHelper.dart';

class HistoryListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryListWidgetState();
}

class HistoryListWidgetState extends State<HistoryListWidget> {
//  List<Map> textData = [
//    {
//      'id': 't1',
//      'title': 'book',
//      'imgUri': "098",
//      'des': "took a galley of type and scrambled it to make a type specimen book",
//    },
//    {
//      'id': 't1',
//      'title': 'documnet 2',
//      'imgUri': "098",
//      'des': "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots",
//    }
//  ];
//
//  @override
//  initState() {
//    super.initState();
//    // Add listeners to this class
//    query();
//  }

  Future<List<Map>> query() async {
    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;
    // get all rows
    List<Map> textData = await db.query(DatabaseHelper.table);
    // print the results
    textData.forEach((row) => print(row));
    // {_id: 1, name: Bob, age: 23}
    // {_id: 2, name: Mary, age: 32}
    // {_id: 3, name: Susan, age: 12}
    return textData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: query(),
      builder: (context, snapShot) {
        return Scaffold(
            appBar: AppBar(
              title: Text('History'),
            ),
            body: snapShot.data == null ?
                //print('project snapshot data is: ${projectSnap.data}');
                Container()
                :
                ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Row(
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
                                    snapShot.data[index]['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapShot.data[index]['des'],
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
                                        color: Colors.red,
                                        icon: Icon(Icons.delete),
                                      ),
                                      IconButton(
                                        onPressed: null,
                                        color: Colors.blue,
                                        icon: Icon(Icons.share),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: snapShot.data.length,
                  )
        );
      },
    );
  }
}
