import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/base/common_list/common_data.dart';
import 'package:flutter_library/base/common_list/common_list.dart';
import 'package:flutter_library/base/base_widget.dart';
import 'package:flutter_library_example/common_list/viewmodel_example.dart';
import 'package:provider/provider.dart';

/// example test commonData
class User extends CommonData {
  String name;

  User(this.name, DataType dataType) : super(dataType: dataType);
}

class CommonListExample extends StatelessWidget {
  CommonListExample({Key? key}) : super(key: key);

  final listUser = [
    User("A", DataType.TYPE_OTHER),
    User("B", DataType.TYPE_RADIO),
    User("C", DataType.TYPE_CHECKBOX),
    User("D", DataType.TYPE_OTHER),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///example test BaseWidget
      body: BaseWidget<ViewModelExample>(
        viewModel: ViewModelExample(),
        child: Consumer<ViewModelExample>(
          builder: (_, vm, child) => ListView.builder(
            itemBuilder: (ct, index) =>
                CommonListItem(listUser[index], vm.action, _CommonItemWidget()),
            itemCount: listUser.length,
          ),
        ),
      ),
    );
  }
}

///example test CommonItem
class _CommonItemWidget extends CommonItemWidget<User> {
  @override
  Widget typeRadio() {
    return RadioListTile(
      value: true,
      groupValue: null,
      onChanged: null,
      title: Text(commonData.name),
    );
  }

  @override
  Widget typeCheckBox() {
    return CheckboxListTile(
        value: true, onChanged: null, title: Text(commonData.name));
  }

  @override
  Widget typeOther() {
    return Text(commonData.name);
  }
}


