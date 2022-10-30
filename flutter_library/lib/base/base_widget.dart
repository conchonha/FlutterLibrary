import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_vm.dart';

class BaseWidget<T extends BaseVM> extends StatelessWidget {
  final T viewModel;
  final Widget child;
  final void Function(BuildContext, T)? onCallBack;

  const BaseWidget(
      {required this.viewModel,
      required this.child,
      this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          viewModel.onInit();
        });

        onCallBack?.call(context, viewModel);

        return viewModel;
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
