import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorServices {
  static final _instance = NavigatorServices._internal();
  GlobalKey<NavigatorState>? globalKey;

  NavigatorServices._internal();

  factory NavigatorServices(){
    return _instance;
  }

   void initNavigator(GlobalKey<NavigatorState> navigator) {
    globalKey = navigator;
  }

  push(Widget page) {
    _checkGlobalState();
    Navigator.push(
        globalKey!.currentContext!, MaterialPageRoute(builder: (ct) => page));
  }

  pushName(String name,{Object? argument}) {
    _checkGlobalState();
    Navigator.pushNamed(globalKey!.currentContext!, name,arguments: argument);
  }

  pushAndRemoveUtil(Widget page,String removeToName) {
    _checkGlobalState();
    Navigator.pushAndRemoveUntil(
        globalKey!.currentContext!,
        MaterialPageRoute(builder: (BuildContext context) => page),
        ModalRoute.withName(removeToName));
  }

  pushNameAndRemoveUtil(String name,removeToName,{Object? argument}) {
    _checkGlobalState();
    Navigator.pushNamedAndRemoveUntil(
        globalKey!.currentContext!, name, ModalRoute.withName(removeToName),arguments: argument);
  }

  pushReplacement(Widget page) {
    _checkGlobalState();
    Navigator.pushReplacement(
        globalKey!.currentContext!, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  pushReplacementNamed(String name,{Object? argument}) {
    _checkGlobalState();
    Navigator.pushReplacementNamed(
        globalKey!.currentContext!, name,arguments: argument);
  }

  pop() {
    _checkGlobalState();
    Navigator.pop(
        globalKey!.currentContext!);
  }

  popUntil(String name) {
    _checkGlobalState();
    Navigator.popUntil(
        globalKey!.currentContext!,ModalRoute.withName(name));
  }

  popAndPushNamed(String name,{Object? argument}) {
    _checkGlobalState();
    Navigator.popAndPushNamed(
        globalKey!.currentContext!,name,arguments: argument);
  }

  _checkGlobalState() {
    if (globalKey == null) {
      throw ("please add NavigatorServices.initNavigator on main.dart ");
    }
  }
}
