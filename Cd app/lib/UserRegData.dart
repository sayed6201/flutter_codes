import 'dart:core';
import 'package:flutter/cupertino.dart';


class UserRegData{

  String name;
  String phone;
  String password;
  String email;
  int role_id;
  String age;
  String address;
  String gender;
  String nid;

  UserRegData({
    @required name,
    @required phone,
    @required password,
    @required email,
    @required role_id,
    @required age,
    @required address,
    @required gender,
    @required nid,
  });

}