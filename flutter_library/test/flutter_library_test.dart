import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_library/flutter_library.dart';
import 'package:flutter_library/flutter_library_platform_interface.dart';
import 'package:flutter_library/flutter_library_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLibraryPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterLibraryPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLibraryPlatform initialPlatform = FlutterLibraryPlatform.instance;

  test('$MethodChannelFlutterLibrary is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLibrary>());
  });

  test('getPlatformVersion', () async {
    FlutterLibrary flutterLibraryPlugin = FlutterLibrary();
    MockFlutterLibraryPlatform fakePlatform = MockFlutterLibraryPlatform();
    FlutterLibraryPlatform.instance = fakePlatform;
  
    expect(await flutterLibraryPlugin.getPlatformVersion(), '42');
  });
}
