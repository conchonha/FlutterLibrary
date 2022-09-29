import 'package:flutter/material.dart';

import 'common_action.dart';
import 'common_data.dart';

class CommonListItem<T extends CommonData, V extends CommonItemWidget> extends StatelessWidget {
  T commonData;
  CommonAction<T> iAction;

  late final V widget;
  late final BuildContext context;


  CommonListItem(this.commonData, this.iAction, {Key? key}) : super(key: key){
    widget = CommonItemWidget<T>(iAction) as V;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return InkWell(
      onTap: () {
        iAction.onCheckedListener(commonData);
      },
      onLongPress: () {
        iAction.onLongClickListener(commonData);
      },
      child: _getWidgetType,
    );
  }

  Widget get _getWidgetType {
    switch (commonData.dataType) {
      case DataType.TYPE_LIST_ARROW:
        return widget.typeListArrow();
      case DataType.TYPE_LIST_ARROW_PREVIEW:
        return  widget.typeListArrowPreview();
      case DataType.TYPE_CHECKBOX:
        return  widget.typeCheckBox();
      case DataType.TYPE_CHECKBOX_PREVIEW:
        return widget.typeCheckBoxPreview();
      case DataType.TYPE_RADIO:
        return widget.typeRadio();
      case DataType.TYPE_RADIO_PREVIEW:
        return widget.typeRadioPreview();
      case DataType.TYPE_OTHER:
        return widget.typeOther();
      default:
        return const SizedBox.shrink();
    }
  }
}

 class CommonItemWidget<T extends CommonData>{
  CommonAction<T> iAction;

  CommonItemWidget(this.iAction);

  @protected
  Widget typeListArrow() => const SizedBox.shrink();

  @protected
  Widget typeListArrowPreview() => const SizedBox.shrink();

  @protected
  Widget typeCheckBox() => const SizedBox.shrink();

  @protected
  Widget typeCheckBoxPreview() => const SizedBox.shrink();

  @protected
  Widget typeRadio() => const SizedBox.shrink();

  @protected
  Widget typeRadioPreview() => const SizedBox.shrink();

  @protected
  Widget typeOther() => const SizedBox.shrink();
}
