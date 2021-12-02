part of gt_onelogin_flutter_plugin;

typedef EventHandler = void Function(Map<String,dynamic>);

class GtOneloginFlutterPlugin {
  static const MethodChannel _channel = MethodChannel(_Constant.methodChannel);

/// ------------核心接口-----------
  //  初始化
  static init(String appId, [double? timeout]) {
    Map<String,dynamic> map = <String, dynamic>{};
    map[_Constant.appId] = appId;
    if (timeout != null) {
      map[_Constant.timeout] = timeout;
    }
    return _channel.invokeMethod(_Constant.init,map);
  }

  //拉起授权页
  static Future<Map<String,dynamic>> requestToken() async{
    return await _channel.invokeMethod(_Constant.requestToken);
  }

  //关闭授权页
  static dismissAuthView(){
    return _channel.invokeMethod(_Constant.dismissAuthView);
  }

/// -------------配置接口------------------
  //设置是否开启日志
  static setLogEnable(bool enable){
    return _channel.invokeMethod(_Constant.setLogEnable,enable);
  }

  //获取SDK版本号
  static Future<String> sdkVersion() async{
    return await _channel.invokeMethod(_Constant.sdkVersion);
  }

  //获取当前运营商
  static Future<CarrierType> getCurrentCarrier() async{
    int carrier = await _channel.invokeMethod(_Constant.carrier);
    return CarrierType.values[carrier];
  }

  //隐私条款是否勾选
  static Future<bool> isProtocolCheckboxChecked() async{
    return await _channel.invokeMethod(_Constant.isProtocolCheckboxChecked);
  }

  //预取号拿到的token是否还在有效期
  static Future<bool> isReady() async{
    return await _channel.invokeMethod(_Constant.isReady);
  }

}