import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_library/utils/navigator_services.dart';

class SnackBarBuilder {
  static void snackBarNotification(String message,
      Color backgroundColor, Color textColor,
      {Widget? iconWidget}) {
    Flushbar(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      maxWidth: MediaQuery.of(globalKey.getCurrentContext).size.width * 0.7,
      blockBackgroundInteraction: false,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //borderRadius: 15.0,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontFamily: 'YuGothic',
        ),
      ),
      icon: iconWidget,
      duration: const Duration(seconds: 2),
      isDismissible: false,
      backgroundColor: backgroundColor,
    ).show(globalKey.getCurrentContext);
  }
}
