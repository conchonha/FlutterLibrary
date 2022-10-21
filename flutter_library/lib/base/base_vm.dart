import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import '../utils/navigator_services.dart';
import '../utils/shared_prefs.dart';

abstract class BaseVM extends ChangeNotifier {
  Set<StreamSubscription> managerStream = HashSet();
  int countApi = 0;

  @protected
  final NavigatorServices navigator = NavigatorServices();

  @protected
  SharedPrefs sharedPrefs = SharedPrefs();

  VoidCallback? onLoading;
  VoidCallback? onHideLoading;
  void Function(String)? onError;

  @protected
  void onInit();

  void popupLoading() {
    if (countApi == 0) {
      onLoading?.call();
    }
    countApi++;
  }

  void hideLoading() {
    --countApi;
    if (countApi <= 0) {
      onHideLoading?.call();
    }
  }

  void callApi<T>(Future<T> callApi, Function(T) onSuccess,
      {bool? closeLoading = true}) {
    popupLoading();
    callApi.then((value) {
      debugPrint("Call api success: $value");
      hideLoading();
      onSuccess.call(value);
    }).onError((error, stackTrace) {
      hideLoading();
      showError(error.toString());
    });
  }

  void showError(String message) {
    debugPrint("show error: $message");
    onError?.call(message);
  }

  void addStreamListener<T>(Stream<T> stream, Function(T) result,
      {Function? onErr, Function? onDone}) {
    managerStream.add(stream.listen((event) {
      result.call(event);
    }, onError: onErr, onDone: onDone?.call()));
  }

  @override
  void dispose() {
    debugPrint("dispose called()");
    for (var element in managerStream) {
      element.cancel();
    }
    super.dispose();
  }
}
