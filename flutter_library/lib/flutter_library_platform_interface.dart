import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_library_method_channel.dart';

abstract class FlutterLibraryPlatform extends PlatformInterface {
  /// Constructs a FlutterLibraryPlatform.
  FlutterLibraryPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLibraryPlatform _instance = MethodChannelFlutterLibrary();

  /// The default instance of [FlutterLibraryPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLibrary].
  static FlutterLibraryPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLibraryPlatform] when
  /// they register themselves.
  static set instance(FlutterLibraryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
