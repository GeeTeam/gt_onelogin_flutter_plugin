import Flutter
import UIKit
import OneLoginSDK

public class SwiftGtOneloginFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "gt_onelogin_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftGtOneloginFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      print("\(call.method)")
      switch call.method {
      case OLConstant.`init`:
          setup(call: call, result: result)
      case OLConstant.requestToken:
          fallthrough
      case OLConstant.dismissAuthView:
          dismissAuthView(call: call, result: result)
      case OLConstant.setLogEnable:
          setup(call: call, result: result)
      case OLConstant.carrier:
          getCurrentCarrier(call: call, result: result)
      case OLConstant.sdkVersion:
          sdkVersion(call: call, result: result)
      case OLConstant.isProtocolCheckboxChecked:
          isProtocolCheckboxChecked(call: call, result: result)
      case OLConstant.isReady:
          isReady(call: call, result: result)
      default:
          result(FlutterMethodNotImplemented)
      }
  }
}

//核心接口
extension SwiftGtOneloginFlutterPlugin{
    func setup(call:FlutterMethodCall,result: @escaping FlutterResult){
        guard let arguments = call.arguments as? [String:Any],let appId = arguments[OLConstant.appId] as? String,!appId.isEmpty  else {
            result(FlutterError(code: call.method, message: "appId 参数必传", details: nil))
            return
        }
        OneLoginPro.register(withAppID: appId)
        result(true)
    }
    
    func requestToken(call:FlutterMethodCall,result: @escaping FlutterResult){
        
    }
    
    func dismissAuthView(call:FlutterMethodCall,result: @escaping FlutterResult){
        OneLoginPro.dismissAuthViewController {
            result(true)
        }
        
    }
    
}

//配置接口
extension SwiftGtOneloginFlutterPlugin{
    func setLogEnable(call:FlutterMethodCall,result: @escaping FlutterResult){
        guard let isEnable = call.arguments as? Bool else{
            result(FlutterError(code: call.method, message: "参数必传", details: nil))
            return
        }
        OneLoginPro.setLogEnabled(isEnable)
        OneLoginPro.setCMLogEnabled(isEnable)
        result(true)
    }
    
    func getCurrentCarrier(call:FlutterMethodCall,result: @escaping FlutterResult){
        guard let info = OneLoginPro.currentNetworkInfo(),let carrierName = info.carrierName,let carrierType = OLCarrierType.init(rawValue: carrierName) else{
            result(OLCarrierType.unknow.intValue)
            return
        }
        
        result(carrierType.intValue)
    }
    
    func sdkVersion(call:FlutterMethodCall,result: @escaping FlutterResult){
        result(OneLoginPro.sdkVersion)
    }
    
    func isProtocolCheckboxChecked(call:FlutterMethodCall,result: @escaping FlutterResult){
        result(OneLoginPro.isProtocolCheckboxChecked)
    }
    
    func isReady(call:FlutterMethodCall,result: @escaping FlutterResult){
        result(OneLoginPro.isPreGetTokenResultValidate())
    }
}
