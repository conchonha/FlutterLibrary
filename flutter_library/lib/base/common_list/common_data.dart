import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommonData {
  @ColumnInfo(name: null)
  @JsonKey(ignore: true)
  final DataType dataType;

  CommonData({
    this.dataType = DataType.TYPE_LIST_ARROW_PREVIEW,
  });
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
