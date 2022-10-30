import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/utils/navigator_services.dart';
import 'package:flutter_library/utils/programing_manager/programing_manager.dart';

import '../../res/dimens.dart';

class LoadingDialog {
  int _countApi = 0;

  /// show or hide loading dialog
  void loadDialog(bool value){
    if(value){
      _popupLoading();
      return;
    }
    _hideLoading();
  }

  /// Example: have 10 api call on 10 different thread => [_popupLoading] or [_hideLoading] call 10 again
  /// => [_popupLoading] show 10 [_hideLoading] hide 10
  /// => [_countApi] handle issue
  void _popupLoading() {
    if (_countApi == 0) {
      debugPrint('onLoading called()');
      _showLoaderDialog();
    }
    ++_countApi;
    debugPrint('popupLoading called() with: $_countApi');
  }

  /// Example: have 10 api call on 10 different thread => [_popupLoading] or [_hideLoading] call 10 again
  /// => [_popupLoading] show 10 [_hideLoading] hide 10
  /// => [_countApi] handle issue
  void _hideLoading() {
    --_countApi;
    if (_countApi == 0) {
      Navigator.of(globalKey.getCurrentContext).pop(_showLoaderDialog);
    }
    debugPrint('hideLoading called() with: $_countApi');
  }

  /// show loading dialog
  void _showLoaderDialog() {
    debugPrint("showLoaderDialog");
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: globalKey.getCurrentContext,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// func [confirmDialog] show dialog confirm yes/no option and return true or false when close dialog
  Future<bool?> confirmDialog(String title, {String? message,String? ok, String? cancel}) async {
    return await showDialog<bool>(
        context: globalKey.getCurrentContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: AppDP.dp_15),
            ),
            children: <Widget>[
              if(message != null)
                Text(message),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      ok ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(cancel ?? ""),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    return toString() == other.toString();
  }
}
