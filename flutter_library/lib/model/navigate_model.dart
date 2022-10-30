import 'package:flutter/widgets.dart';

/// object support using in [NavigatorServices.dart]
class NavigateModel{
  final Widget? widget;
  final String? name;
  final dynamic argument;
  final String? routerNameRemove;
  final NavigateType? navigateType;

  NavigateModel({this.widget, this.name, this.argument, this.routerNameRemove,
    this.navigateType = NavigateType.PUSH_NAME});
}

enum NavigateType{
  PUSH,
  PUSH_NAME,
  PUSH_AND_REMOVE_UTIL,
  PUSH_NAME_AND_REMOVE_UTIL,
  PUSH_REPLACE_MENT,
  PUSH_REPLACE_MENT_NAME,
  POP,
  POP_UNTIL,
  POP_AND_PUSH_NAME
}