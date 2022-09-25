#import "FlutterLibraryPlugin.h"
#if __has_include(<flutter_library/flutter_library-Swift.h>)
#import <flutter_library/flutter_library-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_library-Swift.h"
#endif

@implementation FlutterLibraryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLibraryPlugin registerWithRegistrar:registrar];
}
@end
