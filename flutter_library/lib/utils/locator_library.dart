import 'package:flutter_library/utils/programing_manager/programing_manager.dart';
import 'package:flutter_library/utils/shared_prefs.dart';
import 'package:get_it/get_it.dart';

import 'custom_exception.dart';
import 'dialog/loading_dialog.dart';
import 'navigator_services.dart';

/// using [locatorLibrary] registerLazySingleton
GetIt locatorLibrary = GetIt.instance;

class LocatorLibrary {
  /// function [setupLocatorLibrary] register instance with [locatorLibrary]
  static Future<void> setupLocatorLibrary({Function(GetIt)? register}) async {
    locatorLibrary.registerLazySingleton(() => SharedPrefs());
    locatorLibrary.registerLazySingleton(() => LoadingDialog());
    locatorLibrary.registerLazySingleton(() => CustomExceptions());
    locatorLibrary.registerLazySingleton(() => NavigatorServices());
    locatorLibrary.registerLazySingleton(() => ProgramingManager());

    register?.call(locatorLibrary);
    await _initSyncObject();
  }

  /// function [removeInstance] using remove instance of object register
  static void removeInstance(Object object) {
    locatorLibrary.unregister(instance: object);
  }

  /// function [removeAll] using remove all instance of object register
  static Future removeAll() async {
    await locatorLibrary.reset();
  }

  static Future _initSyncObject() async {
    await locatorLibrary<SharedPrefs>().initialise();
  }
}
