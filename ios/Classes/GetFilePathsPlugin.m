#import "GetFilePathsPlugin.h"
#if __has_include(<get_file_paths/get_file_paths-Swift.h>)
#import <get_file_paths/get_file_paths-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "get_file_paths-Swift.h"
#endif

@implementation GetFilePathsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGetFilePathsPlugin registerWithRegistrar:registrar];
}
@end
