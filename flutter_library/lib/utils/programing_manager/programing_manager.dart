import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_library/utils/dialog/loading_dialog.dart';
import 'package:flutter_library/utils/navigator_services.dart';
import 'package:rxdart/rxdart.dart';

import '../custom_exception.dart';
import '../locator_library.dart';
import '../../model/data/result.dart';
import 'package:oktoast/oktoast.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey();

class ProgramingManager {
  final _exception = locatorLibrary<CustomExceptions>();
  final _dialogManager = locatorLibrary<LoadingDialog>();
  final _navigate = locatorLibrary<NavigatorServices>();

  final _result = PublishSubject<Result>();
  final _managerStream = HashMap<int, StreamSubscription>();

  Stream<Result> get result => _result.stream;

  /// receive Result for handle [ResultFail,loadDialog,ResultNavigate,ResultShowToast]
  void setResult<T>(Result<T> result) {
    _result.sink.add(result);
  }

  /// when register with [locatorLibrary] first call listener observer [_result]
  ProgramingManager() {
    _managerStream[result.hashCode] = result.listen((event) {
      if (event is ResultFail) {
        _dialogManager.confirmDialog("Exception:",
            message: _exception.getException(event.error));
      } else if (event is ResultLoading) {
        _dialogManager.loadDialog(event.loading);
      } else if (event is ResultNavigate) {
        _navigate.push(event.navigateModel);
      } else if (event is ResultShowToast) {
        showToast(event.message, position: ToastPosition.bottom);
      } else {
        throw "ProgramingManager not found method";
      }
    });
  }

  /// func call api
  Future<void> callApi<T>(Future<T> callApi, Function(T) onSuccess,
      {bool? closeLoading = true}) async {
    if (closeLoading == true) {
      setResult(const Result.loading(loading: true));
    }

    callApi.then((value) => onSuccess.call(value)).onError((error, stackTrace) {
      if (closeLoading == true) {
        setResult(const Result.loading(loading: false));
      }
      setResult(Result.fail(error: error));
    });
  }

  /// listener stream / cancel stream
  void addStreamListener<T>(Stream<T> stream, Function(T) result,
      {Function? onDone}) {
    _managerStream[stream.hashCode] = stream.listen((event) {
      result.call(event);
    }, onError: (error) {
      setResult(Result.fail(error: error));
    }, onDone: onDone?.call());
  }

  ///cancel all stream listener except [result]
  void cancelAll() {
    for (int i = 1; i < _managerStream.values.length; i++) {
      _managerStream.values.elementAt(i).cancel();
    }
  }

  ///cancel element stream with stream.hashCode <=> key
  void cancelElement(int hashCodeOfStream) {
    _managerStream[hashCodeOfStream]?.cancel();
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    return toString() == other.toString();
  }
}

extension GlobalKeyExt on GlobalKey {
  /// get current context from [GlobalKey] and handle exception
  /// if [globalKey] = null please add [globalKey] on [MaterialApp] with property navigatorKey: globalKey
  BuildContext get getCurrentContext {
    if (currentContext == null) {
      throw ("please add NavigatorServices.globalKey on main.dart ");
    }
    return currentContext!;
  }
}
