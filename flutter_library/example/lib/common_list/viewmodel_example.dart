import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_library/base/base_vm.dart';
import 'package:flutter_library/base/common_list/common_action.dart';
import 'package:flutter_library/model/data/result.dart';

import 'common_list_example.dart';

/// example test Base vm
class ViewModelExample extends BaseVM{
  final _Action action = _Action();

  @override
  void onInit() {
    /// example test Toast display
    showToast("init viewModel");
  }
}

/// example test common action
class _Action extends CommonAction<User> {
  bool a = false;

  /// func test loading call 4, cancel 4 -> display 1 cancel 1 ->right
  @override
  void onClickListener(User data) {
    super.onClickListener(data);
    /// example test loading dialog
    a = !a;
    if(a){
      manager.setResult(const Result.loading(loading: true));
      manager.setResult(const Result.loading(loading: true));
      manager.setResult(const Result.loading(loading: true));
      manager.setResult(const Result.loading(loading: true));
      Future.delayed(const Duration(seconds: 2),(){
        manager.setResult(const Result.loading(loading: false));
        manager.setResult(const Result.loading(loading: false));
        manager.setResult(const Result.loading(loading: false));
        manager.setResult(const Result.loading(loading: false));
      });
    }
  }

  @override
  void onLongClickListener(User data) {
    super.onLongClickListener(data);
    ///example test error
    manager.setResult(Result.fail(error: TimeoutException("Qua thoi gian")));
    debugPrint("Test exception: ${manager.toString()}");
  }
}