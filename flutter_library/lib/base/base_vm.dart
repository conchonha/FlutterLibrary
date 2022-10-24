import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
    ++countApi;
    debugPrint('popupLoading called() with: $countApi');
  }

  void hideLoading() {
    --countApi;
    if (countApi <= 0) {
      onHideLoading?.call();
    }
    debugPrint('hideLoading called() with: $countApi');
  }

  void callApi<T>(Future<T> callApi, Function(T) onSuccess,
      {bool? closeLoading = true}) {
    if(closeLoading == true){
      popupLoading();
    }
    callApi.then((value) {
      debugPrint("Call api success: $value");
      hideLoading();
      onSuccess.call(value);
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(error.toString(),position: ToastPosition.bottom);
      // showError(error.toString());
    });
  }

  void showError(String message) {
    debugPrint("show error: $message");
    onError?.call(message);
  }

  void addStreamListener<T>(Stream<T> stream, Function(T) result,
      { Function? onDone}) {
    managerStream.add(stream.listen((event) {
      result.call(event);
    }, onError: (error){
        showError("Stream listener error: ${error.toString()}");
    }, onDone: onDone?.call()));
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
