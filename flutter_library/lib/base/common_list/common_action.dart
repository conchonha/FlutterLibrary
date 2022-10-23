import 'package:flutter/cupertino.dart';

import '../../utils/navigator_services.dart';
import 'common_data.dart';

class CommonAction<T extends CommonData> implements IActionListener<T>{
  @protected
  final NavigatorServices navigator = NavigatorServices();

  CommonAction();

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
}

abstract class IActionListener<T extends CommonData>{
  void onClickListener(T data);
  void onLongClickListener(T data);
  void onCheckedListener(T data);
  void onNavigate(T data);
}