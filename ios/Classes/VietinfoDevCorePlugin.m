#import "VietinfoDevCorePlugin.h"
#if __has_include(<vietinfo_dev_core/vietinfo_dev_core-Swift.h>)
#import <vietinfo_dev_core/vietinfo_dev_core-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vietinfo_dev_core-Swift.h"
#endif

@implementation VietinfoDevCorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVietinfoDevCorePlugin registerWithRegistrar:registrar];
}
@end
