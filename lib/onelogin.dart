part of gt_onelogin_flutter_plugin;

typedef EventHandler = void Function(Map<String,dynamic>);

class GtOneloginFlutterPlugin {
  static const MethodChannel _channel = MethodChannel(_Constant.methodChannel);

  ///  初始化
  static init(String appId, [double? timeout]) {
    Map<String,dynamic> map = <String, dynamic>{};
    map[_Constant.appId] = appId;
    if (timeout != null) {
      map[_Constant.timeout] = timeout;
    }
    return _channel.invokeMethod(_Constant.init,map);
  }

  ///拉起授权页
  static Future<Map<String,dynamic>> requestToken() async{
    return await _channel.invokeMethod(_Constant.requestToken);
  }

  ///关闭授权页
  static dismissAuthView(){
    return _channel.invokeMethod(_Constant.dismissAuthView);
  }


}