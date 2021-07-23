import 'package:flutter/material.dart';

class DropoffDate {
  String date;
  List<Widget> options;

  DropoffDate(String date, List<Widget> options) {
    this.date = date;
    this.options = options;
  }
}
