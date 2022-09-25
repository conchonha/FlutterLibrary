import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class BaseWidgetModel<T> extends Widget {
  @protected
  Widget build(BuildContext context, T widgetModel);
  @override
  DataProviderElement<T> createElement() => DataProviderElement<T>(this);
}

class DataProviderElement<T> extends ComponentElement {
  DataProviderElement(BaseWidgetModel widget) : super(widget);
  @override
  BaseWidgetModel get widget => super.widget as BaseWidgetModel<dynamic>;
  @override
  Widget build() => widget.build(this, Provider.of<T>(this));

  @override
  void update(BaseWidgetModel newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}