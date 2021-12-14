part of gt_onelogin_flutter_plugin;

typedef EventHandler<T> = void Function(T);

class GtOneloginFlutterPlugin {
  final MethodChannel _channel = const MethodChannel(_OLConstant.methodChannel);
  static const String flutterLog = "| Geetest | Flutter | ";


  GtOneloginFlutterPlugin(String appId, [int? timeout]) {
    try {
      Map<String, dynamic> map = <String, dynamic>{};
      map[_OLConstant.appId] = appId;
      if (timeout != null) {
        map[_OLConstant.timeout] = timeout;
      }
      _channel.invokeMethod(_OLConstant.init,map);
    }catch (e) {
      debugPrint(flutterLog + e.toString());
    }
   }

  /// ------------核心接口-----------
  //拉起授权页
  Future<Map<String, dynamic>> requestToken([OLUIConfiguration? configuration]) async {
    Map map = await _channel.invokeMethod(_OLConstant.requestToken,configuration?.toMap());
    return LinkedHashMap.from(map);
  }

  //关闭授权页
  dismissAuthView() {
    return _channel.invokeMethod(_OLConstant.dismissAuthView);
  }

  /// -------------配置接口------------------
  //设置是否开启日志
  setLogEnable(bool enable) {
    return _channel.invokeMethod(_OLConstant.setLogEnable, enable);
  }

  //获取SDK版本号
  Future<String> sdkVersion() async {
    return await _channel.invokeMethod(_OLConstant.sdkVersion);
  }

  //获取当前运营商
  Future<OLCarrierType> getCurrentCarrier() async {
    int carrier = await _channel.invokeMethod(_OLConstant.carrier);
    return OLCarrierType.values[carrier];
  }

  //隐私条款是否勾选
  Future<bool> isProtocolCheckboxChecked() async {
    return await _channel.invokeMethod(_OLConstant.isProtocolCheckboxChecked);
  }

  //预取号拿到的token是否还在有效期
    Future<bool> isAvailable() async {
    return await _channel.invokeMethod(_OLConstant.isAvailable);
  }

  //Only for android ,销毁SDK
  destroy() {
    return _channel.invokeMethod(_OLConstant.destroy);
  }

  /// -------------add listener------------------

  //点击返回按钮
  EventHandler<void>? _onBackButtonClick;
  //点击登录按钮
  EventHandler<void>? _onAuthButtonClick;
  //点击切换账号
  EventHandler<void>? _onSwitchButtonClick;
  //点击服务条款的选择框
  EventHandler<bool>? _onTermCheckBoxClick;

  addEventListener(
      {EventHandler<void>? onBackButtonClick,
      EventHandler<void>? onAuthButtonClick,
      EventHandler<void>? onSwitchButtonClick,
      EventHandler<bool>? onTermCheckBoxClick}) {
    debugPrint(flutterLog + "addEventListener");
    _onBackButtonClick = onBackButtonClick;
    _onAuthButtonClick = onAuthButtonClick;
    _onSwitchButtonClick = onSwitchButtonClick;
    _onTermCheckBoxClick = onTermCheckBoxClick;

    _channel.setMethodCallHandler(_handler);
  }
  Future<dynamic> _handler(MethodCall call) async {
    switch (call.method) {
      case _OLConstant.onBackButtonClick:
        return _onBackButtonClick?.call(null);
      case _OLConstant.onAuthButtonClick:
        return _onAuthButtonClick?.call(null);
      case _OLConstant.onSwitchButtonClick:
        return _onSwitchButtonClick?.call(null);
      case _OLConstant.onTermCheckBoxClick:
        return _onTermCheckBoxClick?.call(call.arguments as bool);
      default:
        return null;
    }
  }
}