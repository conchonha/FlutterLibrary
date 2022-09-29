import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_library/services/api.dart';

import '../utils/navigator_services.dart';


abstract class BaseVM extends ChangeNotifier {
  Set<StreamSubscription> managerStream = HashSet();

  @protected
  final NavigatorServices navigator = NavigatorServices();

  @protected
  final API api = API();

  bool isShowLoading = false;
  VoidCallback? onLoading;
  VoidCallback? onHideLoading;
  void Function(String)? onError;

  @protected
  void onInit();

  @protected
  void viewAppear() {
    //Todo something
  }

  @protected
  void viewDisAppear() {
    //Todo something
  }

  void popupLoading() {
    isShowLoading = true;
    onLoading?.call();
  }

  void hideLoading() {
    if (isShowLoading) {
      isShowLoading = false;
      onHideLoading?.call();
    }
  }

  void showError(String message) {
    onError?.call(message);
  }

  void showHandleFailed() {
    onError?.call("Xử lý thất bại. Vui lòng thử lại");
  }

  void addStreamListener<T>(Stream<T> stream, Function(T) result,
      {Function? onErr, Function? onDone}) {
    managerStream.add(
        stream.listen((event) {
          result.call(event);
        }, onError: onErr,
            onDone: onDone?.call())
    );
  }

  @override
  void dispose() {
    for (var element in managerStream) {
      element.cancel();
    }
    super.dispose();
  }
}
