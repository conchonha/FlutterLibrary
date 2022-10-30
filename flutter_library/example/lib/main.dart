import 'package:flutter/material.dart';
import 'package:flutter_library/utils/locator_library.dart';
import 'package:flutter_library/utils/programing_manager/programing_manager.dart';

import 'common_list/common_list_example.dart';
import 'package:oktoast/oktoast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorLibrary.setupLocatorLibrary();

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        navigatorKey: globalKey,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: CommonListExample(),
        ),
      ),
    );
  }
}

