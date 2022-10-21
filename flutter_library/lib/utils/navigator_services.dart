import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey();

class NavigatorServices {
  static final _instance = NavigatorServices._internal();

  NavigatorServices._internal();

  factory NavigatorServices(){
    return _instance;
  }

  push(Widget page) {
    Navigator.push(
        globalKey.getCurrentContext, MaterialPageRoute(builder: (ct) => page));
  }

  pushName(String name,{Object? argument}) {
    Navigator.pushNamed(globalKey.getCurrentContext, name,arguments: argument);
  }

  pushAndRemoveUtil(Widget page,String removeToName) {
    Navigator.pushAndRemoveUntil(
        globalKey.getCurrentContext,
        MaterialPageRoute(builder: (BuildContext context) => page),
        ModalRoute.withName(removeToName));
  }

  pushNameAndRemoveUtil(String name,removeToName,{Object? argument}) {
    Navigator.pushNamedAndRemoveUntil(
        globalKey.getCurrentContext, name, ModalRoute.withName(removeToName),arguments: argument);
  }

  pushReplacement(Widget page) {
    Navigator.pushReplacement(
        globalKey.getCurrentContext, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  pushReplacementNamed(String name,{Object? argument}) {
    Navigator.pushReplacementNamed(
        globalKey.getCurrentContext, name,arguments: argument);
  }

  pop() {
    Navigator.pop(
        globalKey.getCurrentContext);
  }

  popUntil(String name) {
    Navigator.popUntil(
        globalKey.getCurrentContext,ModalRoute.withName(name));
  }

  popAndPushNamed(String name,{Object? argument}) {
    Navigator.popAndPushNamed(
        globalKey.getCurrentContext,name,arguments: argument);
  }
}

extension GlobalKeyExt on GlobalKey{
  BuildContext get getCurrentContext{
    if (currentContext == null) {
      throw ("please add NavigatorServices.globalKey on main.dart ");
    }
    return currentContext!;
  }
}
