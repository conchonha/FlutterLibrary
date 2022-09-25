import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/snackbar_builder.dart';
import 'base_vm.dart';

class BaseWidget<T extends BaseVM> extends StatelessWidget {
  final T viewmodel;
  final Widget child;
  final void Function(BuildContext, T)? onCallBack;
  final void Function(BuildContext)? onSuccess;

  BaseWidget(
      {required this.viewmodel,
      required this.child,
      this.onCallBack,
      this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) {
        viewmodel.onInit();

        viewmodel.onLoading = () {
          print("onLoading");
        };

        viewmodel.onHideLoading = () {
          print("onHideLoading");
          Navigator.of(context).pop();
        };

        viewmodel.onError = (mss) {
          print("onError");
          SnackBarBuilder.snackBarNotification(
            context,
            mss,
            Colors.red,
            Colors.white,
          );
        };

        onCallBack?.call(context, viewmodel);

        return viewmodel;
      },
      builder: (ct, _) => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: child,
      ),
    );
  }
}
