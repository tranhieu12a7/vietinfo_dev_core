import Flutter
import UIKit

public class SwiftVietinfoDevCorePlugin: NSObject, FlutterPlugin {
    
public static func register(with registrar: FlutterPluginRegistrar) {
   let channel = FlutterMethodChannel(name: "vietinfo_dev_core", binaryMessenger: registrar.messenger())
   let instance = SwiftVietinfoDevCorePlugin()
   registrar.addMethodCallDelegate(instance, channel: channel)
 }

 public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   if (call.method == "getDownloadsDirectory") {
    getDownloadsDirectory(result: result)
   }
   else if (call.method == "getPlatformVersion") {
        result("iOS " + UIDevice.current.systemVersion)
   }
   else {
    result(FlutterMethodNotImplemented)
   }
 }
    
    func getDownloadsDirectory(result : @escaping FlutterResult) {
        let path = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)
        let documentsDirectory = path[0]
        result(documentsDirectory.path)
    }

}
