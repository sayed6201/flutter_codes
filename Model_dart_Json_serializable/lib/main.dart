import 'dart:convert';

import 'package:flutter/material.dart';
import 'modals/user.dart';

const NESTED_JSON =
    '[{"name":"User One","phone":"7777777777","email":"userone@gmail.com","subscription":true,"address":{"street":"Some Street","landmark":"Some Landmark","city":"Some City","state":"Some City"}},{"name":"User Two","phone":"8888888888","email":"usertwo@gmail.com","subscription":true,"address":{"street":"Some Street","landmark":"Some Landmark","city":"Some City","state":"Some City"}},{"name":"User Three","phone":"9999999999","email":"userthree@gmail.com","subscription":true,"address":{"street":"Some Street","landmark":"Some Landmark","city":"Some City","state":"Some City"}},{"name":"User Four","phone":"4444444444","email":"userfour@gmail.com","subscription":true,"address":{"street":"Some Street","landmark":"Some Landmark","city":"Some City","state":"Some City"}}]';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<List<User>> getDataFromFakeServer() async {
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = jsonDecode(NESTED_JSON);
      List<User> users = data.map((data) => User.fromJson(data)).toList();
      return users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(title: Text("Json Serialization"),),
        body: Container(
          child: FutureBuilder<List<User>>(
              future: getDataFromFakeServer(),
              builder: (context, data) {
                if (data.connectionState != ConnectionState.waiting && data.hasData) {
                  var userList = data.data;
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        var userData = userList[index];
                        return ExpansionTile(
                          key: Key("$index"),
                          title: Text(userData.name ?? ""),
                          subtitle: Text(userData.email ?? ""),

                          children: <Widget>[
                            Container(
                              color: Colors.grey.withAlpha(55),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Street: ${userData.address.street}"),
                                    SizedBox(height: 5,),
                                    Text("Landmark: ${userData.address.landmark}"),
                                    SizedBox(height: 5,),
                                    Text("City: ${userData.address.city}"),
                                    SizedBox(height: 5,),
                                    Text("State: ${userData.address.state}"),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
