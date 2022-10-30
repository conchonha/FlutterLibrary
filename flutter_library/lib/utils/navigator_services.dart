import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/model/navigate_model.dart';
import 'package:flutter_library/utils/programing_manager/programing_manager.dart';
import 'package:path/path.dart';

class NavigatorServices {
  void push(NavigateModel navigateModel){
    switch(navigateModel.navigateType){
      case NavigateType.PUSH:
        _push(navigateModel.widget);
        break;
      case NavigateType.PUSH_NAME:
        _pushName(navigateModel.name,argument: navigateModel.argument);
        break;
      case NavigateType.POP:
        _pop();
        break;
      case NavigateType.POP_AND_PUSH_NAME:
        _popAndPushNamed(navigateModel.name,argument: navigateModel.argument);
        break;
      case NavigateType.PUSH_AND_REMOVE_UTIL:
        _pushAndRemoveUtil(navigateModel.widget, navigateModel.routerNameRemove);
        break;
      case NavigateType.PUSH_NAME_AND_REMOVE_UTIL:
        _pushNameAndRemoveUtil(navigateModel.name, navigateModel.routerNameRemove,argument: navigateModel.argument);
        break;
      case NavigateType.PUSH_REPLACE_MENT:
        _pushReplacement(navigateModel.widget);
        break;
      case NavigateType.PUSH_REPLACE_MENT_NAME:
        _pushReplacementNamed(navigateModel.name,argument: navigateModel.argument);
        break;
      case NavigateType.POP_UNTIL:
        _popUntil(navigateModel.name);
        break;
      default:
        throw("Navigate service method not found");
    }
  }

  void _push(Widget? page) {
    if(page == null) throw("Navigate service error with page not found");
    Navigator.push(
        globalKey.getCurrentContext, MaterialPageRoute(builder: (ct) => page));
  }

  void _pushName(String? name,{Object? argument}) {
    if(name == null) throw("Navigate service error with router not found");
    Navigator.pushNamed(globalKey.getCurrentContext, name,arguments: argument);
  }

  void _pushAndRemoveUtil(Widget? page,String? removeToName) {
    if(removeToName == null || page == null) throw("Navigate service error with page or removeToName not found");
    Navigator.pushAndRemoveUntil(
        globalKey.getCurrentContext,
        MaterialPageRoute(builder: (BuildContext context) => page),
        ModalRoute.withName(removeToName));
  }

  void _pushNameAndRemoveUtil(String? name,String? removeToName,{Object? argument}) {
    if(name == null || removeToName == null) throw("Navigate service error with routerName or removeToName not found");
    Navigator.pushNamedAndRemoveUntil(
        globalKey.getCurrentContext, name, ModalRoute.withName(removeToName),arguments: argument);
  }

  void _pushReplacement(Widget? page) {
    if(page == null) throw("Navigate service error with page not found");
    Navigator.pushReplacement(
        globalKey.getCurrentContext, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  void _pushReplacementNamed(String? name,{Object? argument}) {
    if(name == null) throw("Navigate service error with name not found");
    Navigator.pushReplacementNamed(
        globalKey.getCurrentContext, name,arguments: argument);
  }

  void _pop() {
    Navigator.pop(
        globalKey.getCurrentContext);
  }

  void _popUntil(String? name) {
    if(name == null) throw("Navigate service error with router not found");
    Navigator.popUntil(
        globalKey.getCurrentContext,ModalRoute.withName(name));
  }

  void _popAndPushNamed(String? name,{Object? argument}) {
    if(name == null) throw("Navigate service error with router not found");
    Navigator.popAndPushNamed(
        globalKey.getCurrentContext,name,arguments: argument);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    return toString() == other.toString();
  }
}
