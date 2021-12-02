#import "GtOneloginFlutterPlugin.h"
#if __has_include(<gt_onelogin_flutter_plugin/gt_onelogin_flutter_plugin-Swift.h>)
#import <gt_onelogin_flutter_plugin/gt_onelogin_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gt_onelogin_flutter_plugin-Swift.h"
#endif

@implementation GtOneloginFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGtOneloginFlutterPlugin registerWithRegistrar:registrar];
}
@end
