
import 'flutter_library_platform_interface.dart';

class FlutterLibrary {
  Future<String?> getPlatformVersion() {
    return FlutterLibraryPlatform.instance.getPlatformVersion();
  }
}
