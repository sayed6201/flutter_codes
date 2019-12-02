import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  //sinxe all properties are final, object can't be changed
  const Category({
    @required this.id,
    @required this.title,
    @required this.color
  });
}