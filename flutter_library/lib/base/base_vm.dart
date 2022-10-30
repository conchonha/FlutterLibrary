import 'package:flutter/material.dart';
import 'package:flutter_library/model/data/result.dart';

import '../model/navigate_model.dart';
import '../utils/locator_library.dart';
import '../utils/programing_manager/programing_manager.dart';

abstract class BaseVM extends ChangeNotifier {
  @protected
  final manager = locatorLibrary<ProgramingManager>();

  @protected
  void onInit();

  @protected
  void navigate(NavigateModel navigateModel){
    manager.setResult(Result.navigate(navigateModel: navigateModel));
  }

  @protected
  void isLoading(bool value){
    manager.setResult(Result.loading(loading: value));
  }

  @protected
  void showToast(String message){
    manager.setResult(Result.showToast(message: message));
  }

  @protected
  void handleError(dynamic exception){
    manager.setResult(Result.fail(error: exception));
  }

  @override
  void dispose() {
    manager.cancelAll();
    super.dispose();
  }
}
