import 'package:flutter/cupertino.dart';
import 'package:flutter_library/utils/locator_library.dart';
import '../../utils/programing_manager/programing_manager.dart';
import 'common_data.dart';

class CommonAction<T extends CommonData> implements IActionListener<T>{
  @protected
  final manager = locatorLibrary<ProgramingManager>();

  @override
  void onCheckedListener(T data) {
    debugPrint("onCheckedListener: $data");
  }

  @override
  void onClickListener(T data) {
    debugPrint("onClickListener: $data");
  }

  @override
  void onLongClickListener(T data) {
    debugPrint("onLongClickListener: $data");
  }

  @override
  void onNavigate(T data) {
    debugPrint("onNavigate: $data");
  }

  @override
  void onDelete(T data) {
    debugPrint("onDelete: $data");
  }

  @override
  void onUpdate(T data) {
    debugPrint("onUpdate: $data");
  }
}

abstract class IActionListener<T extends CommonData>{
  void onClickListener(T data);
  void onLongClickListener(T data);
  void onCheckedListener(T data);
  void onNavigate(T data);
  void onDelete(T data);
  void onUpdate(T data);
}