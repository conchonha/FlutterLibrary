import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => const Dialog(
          elevation: 0,
              backgroundColor: Colors.transparent,
              child: CircularProgressIndicator(),
            ));
  }

  static void showLoaderDialog(BuildContext context){
    print("showLoaderDialog");
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop(showLoadingDialog);
  }
}
