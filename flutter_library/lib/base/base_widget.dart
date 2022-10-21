import 'package:flutter/material.dart';
import 'package:flutter_library/utils/loading_dialog.dart';
import 'package:provider/provider.dart';

import '../utils/snackbar_builder.dart';
import 'base_vm.dart';

class BaseWidget<T extends BaseVM> extends StatelessWidget {
  final T viewmodel;
  final Widget child;
  final void Function(BuildContext, T)? onCallBack;

  const BaseWidget(
      {required this.viewmodel,
      required this.child,
      this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) {
        viewmodel.onInit();

        viewmodel.onLoading = () {
          debugPrint('onLoading called()');
          LoadingDialog.showLoaderDialog();
        };

        viewmodel.onHideLoading = () {
          debugPrint("onHideLoading called()");
          Navigator.of(context).pop();
        };

        viewmodel.onError = (mss) {
          debugPrint("showError: mss = $mss");
          SnackBarBuilder.snackBarNotification(
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
