import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorServices {
  static final _instance = NavigatorServices._internal();
  GlobalKey<NavigatorState>? _globalKey;

  NavigatorServices._internal();

  factory NavigatorServices(){
    return _instance;
  }

   void initNavigator(GlobalKey<NavigatorState> navigator) {
    _globalKey = navigator;
  }

  push(Widget page) {
    _checkGlobalState();
    Navigator.push(
        _globalKey!.currentContext!, MaterialPageRoute(builder: (ct) => page));
  }

  pushName(String name,{Object? argument}) {
    _checkGlobalState();
    Navigator.pushNamed(_globalKey!.currentContext!, name,arguments: argument);
  }

  pushAndRemoveUtil(Widget page,String removeToName) {
    _checkGlobalState();
    Navigator.pushAndRemoveUntil(
        _globalKey!.currentContext!,
        MaterialPageRoute(builder: (BuildContext context) => page),
        ModalRoute.withName(removeToName));
  }

  pushNameAndRemoveUtil(String name,removeToName,{Object? argument}) {
    _checkGlobalState();
    Navigator.pushNamedAndRemoveUntil(
        _globalKey!.currentContext!, name, ModalRoute.withName(removeToName),arguments: argument);
  }

  pushReplacement(Widget page) {
    _checkGlobalState();
    Navigator.pushReplacement(
        _globalKey!.currentContext!, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  pushReplacementNamed(String name,{Object? argument}) {
    _checkGlobalState();
    Navigator.pushReplacementNamed(
        _globalKey!.currentContext!, name,arguments: argument);
  }

  pop() {
    _checkGlobalState();
    Navigator.pop(
        _globalKey!.currentContext!);
  }

  popUntil(String name) {
    _checkGlobalState();
    Navigator.popUntil(
        _globalKey!.currentContext!,ModalRoute.withName(name));
  }

  popAndPushNamed(String name,{Object? argument}) {
    _checkGlobalState();
    Navigator.popAndPushNamed(
        _globalKey!.currentContext!,name,arguments: argument);
  }

  _checkGlobalState() {
    if (_globalKey == null) {
      throw ("please add NavigatorServices.initNavigator on main.dart ");
    }
  }
}
