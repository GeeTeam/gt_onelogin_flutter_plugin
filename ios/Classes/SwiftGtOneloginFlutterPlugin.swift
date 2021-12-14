import Flutter
import UIKit
import OneLoginSDK

public class SwiftGtOneloginFlutterPlugin: NSObject, FlutterPlugin {
    let iosLog = "| Geetest | OneLogin iOS | "
    var channel:FlutterMethodChannel!
    
  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: OLConstant.methodChannel, binaryMessenger: registrar.messenger())
    let instance = SwiftGtOneloginFlutterPlugin()
      instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case OLConstant.`init`:
          setup(call: call, result: result)
      case OLConstant.requestToken:
          requestToken(call: call, result: result)
      case OLConstant.dismissAuthView:
          dismissAuthView(call: call, result: result)
      case OLConstant.setLogEnable:
          setLogEnable(call: call, result: result)
      case OLConstant.carrier:
          getCurrentCarrier(call: call, result: result)
      case OLConstant.sdkVersion:
          sdkVersion(call: call, result: result)
      case OLConstant.isProtocolCheckboxChecked:
          isProtocolCheckboxChecked(call: call, result: result)
      case OLConstant.isAvailable:
          isAvailable(call: call, result: result)
      case  OLConstant.destroy:
          result(true)
      default:
          result(FlutterMethodNotImplemented)
      }
  }
}

//核心接口
extension SwiftGtOneloginFlutterPlugin {
    func setup(call:FlutterMethodCall,result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String:Any],let appId = arguments[OLConstant.appId] as? String,!appId.isEmpty  else {
            result(FlutterError(code: call.method, message: (iosLog+"appId 参数必传"), details: nil))
            return
        }
        OneLoginPro.register(withAppID: appId)
        OneLogin.preGetToken(completion: { _ in
            
        })
        if let timeout = arguments[OLConstant.timeout] as? Int {
            OneLoginPro.setRequestTimeout(TimeInterval(timeout*1000))
        }
        result(true)
    }
    
    func requestToken(call:FlutterMethodCall,result: @escaping FlutterResult) {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        var authModel = OLAuthViewModel()
        if let authModelDict = call.arguments as? [String:Any]  {
            authModel = OLUIConfiguration(dict: authModelDict).toAuthViewModel()
        }
        uiConfigureEvent(authModel)
        OneLoginPro.requestToken(with: vc!, viewModel: authModel) { res in
            guard let dict = res as? [String:Any],!dict.isEmpty,let status = dict["status"] as? Int,status == 500,let errorCode = dict["errorCode"] as? String,errorCode == "-20302" || errorCode == "-20303" else{
                
                if let dict = res as? [String:Any] {
                    var dictNew:[AnyHashable:Any] = [:]
                    dict.forEach({ (key: AnyHashable, value: Any) in
                        dictNew[key] = value
                    })
                    if let status = dict["status"] as? Int, status == 200,let process_id = dictNew["processID"] as? String,let appId = dictNew["appID"] as? String {
                        dictNew["process_id"] = process_id
                        dictNew["app_id"] = appId
                        dictNew.removeValue(forKey: "appID")
                        dictNew.removeValue(forKey: "processID")
                        result(dictNew)
                        return
                    }
                    
                }
                
                result(res)
                return
            }
        }
    }
    
    func uiConfigureEvent(_ authModel:OLAuthViewModel) {
        authModel.clickAuthButtonBlock = {[weak self] in
              self?.channel.invokeMethod(OLConstant.onAuthButtonClick, arguments: nil)
        }
        authModel.clickCheckboxBlock = {[weak self] (isChecked) in
            self?.channel.invokeMethod(OLConstant.onTermCheckBoxClick, arguments: isChecked)
        }
        authModel.clickBackButtonBlock = { [weak self] in
            self?.channel.invokeMethod(OLConstant.onBackButtonClick, arguments: nil)
        }
        authModel.clickSwitchButtonBlock = {[weak self] in
            self?.channel.invokeMethod(OLConstant.onSwitchButtonClick, arguments: nil)
        }
    }
    
    func dismissAuthView(call:FlutterMethodCall,result: @escaping FlutterResult) {
        OneLoginPro.dismissAuthViewController {
            result(true)
        }
    }
    
}

//配置接口
extension SwiftGtOneloginFlutterPlugin {
    func setLogEnable(call:FlutterMethodCall,result: @escaping FlutterResult) {
        guard let isEnable = call.arguments as? Bool else{
            result(FlutterError(code: call.method, message: "参数必传", details: nil))
            return
        }
        OneLoginPro.setLogEnabled(isEnable)
        OneLoginPro.setCMLogEnabled(isEnable)
        result(true)
    }
    
    func getCurrentCarrier(call:FlutterMethodCall,result: @escaping FlutterResult) {
        guard let info = OneLoginPro.currentNetworkInfo(),let carrierName = info.carrierName,let carrierType = OLCarrierType.init(rawValue: carrierName) else{
            result(OLCarrierType.unknow.intValue)
            return
        }
        result(carrierType.intValue)
    }
    
    func sdkVersion(call:FlutterMethodCall,result: @escaping FlutterResult) {
        result(OneLoginPro.sdkVersion)
    }
    
    func isProtocolCheckboxChecked(call:FlutterMethodCall,result: @escaping FlutterResult) {
        result(OneLoginPro.isProtocolCheckboxChecked)
    }
    
    func isAvailable(call:FlutterMethodCall,result: @escaping FlutterResult) {
        result(OneLoginPro.isPreGetTokenResultValidate())
    }
}
