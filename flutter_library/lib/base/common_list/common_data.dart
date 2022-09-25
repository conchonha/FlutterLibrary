import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonData {
  String title;
  String subTitle;
  DataType dataType;
  Color leadingColor;
  bool isChecked;

  CommonData(
      {this.title = "",
      this.subTitle = "",
      this.dataType = DataType.TYPE_LIST_ARROW_PREVIEW,
      this.leadingColor = const Color(0xFF06102B),
      this.isChecked = false});
}

enum DataType {
  TYPE_LIST_ARROW,
  TYPE_LIST_ARROW_PREVIEW,
  TYPE_CHECKBOX,
  TYPE_CHECKBOX_PREVIEW,
  TYPE_RADIO,
  TYPE_RADIO_PREVIEW,
  TYPE_OTHER
}
