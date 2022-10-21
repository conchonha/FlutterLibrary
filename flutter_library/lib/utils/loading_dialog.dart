import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/utils/navigator_services.dart';

class LoadingDialog {
  static void showLoadingDialog() {
    showDialog(
        context: globalKey.getCurrentContext,
        barrierDismissible: true,
        builder: (context) => const Dialog(
          elevation: 0,
              backgroundColor: Colors.transparent,
              child: CircularProgressIndicator(),
            ));
  }

  static void showLoaderDialog(){
    debugPrint("showLoaderDialog");
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:globalKey.getCurrentContext,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(globalKey.getCurrentContext).pop(showLoadingDialog);
  }
}
