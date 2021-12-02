part of gt_onelogin_flutter_plugin;

typedef EventHandler = void Function(Map<String, dynamic>?);

class GtOneloginFlutterPlugin {
  final MethodChannel _channel;
  static const String flutterLog = "| Geetest | Flutter | ";

  GtOneloginFlutterPlugin.private(MethodChannel channel) : _channel = channel;
  static final GtOneloginFlutterPlugin _instance =
      GtOneloginFlutterPlugin.private(const MethodChannel(_Constant.methodChannel));
  factory GtOneloginFlutterPlugin() => _instance;

  /// ------------核心接口-----------
  //  初始化
  init(String appId, [double? timeout]) {
    Map<String, dynamic> map = <String, dynamic>{};
    map[_Constant.appId] = appId;
    if (timeout != null) {
      map[_Constant.timeout] = timeout;
    }
    return _channel.invokeMethod(_Constant.init, map);
  }

  //拉起授权页
  Future<Map<String, dynamic>> requestToken() async {
    return await _channel.invokeMethod(_Constant.requestToken);
  }

  //关闭授权页
  dismissAuthView() {
    return _channel.invokeMethod(_Constant.dismissAuthView);
  }

  /// -------------配置接口------------------
  //设置是否开启日志
  setLogEnable(bool enable) {
    return _channel.invokeMethod(_Constant.setLogEnable, enable);
  }

  //获取SDK版本号
  Future<String> sdkVersion() async {
    return await _channel.invokeMethod(_Constant.sdkVersion);
  }

  //获取当前运营商
  Future<OLCarrierType> getCurrentCarrier() async {
    int carrier = await _channel.invokeMethod(_Constant.carrier);
    return OLCarrierType.values[carrier];
  }

  //隐私条款是否勾选
  Future<bool> isProtocolCheckboxChecked() async {
    return await _channel.invokeMethod(_Constant.isProtocolCheckboxChecked);
  }

  //预取号拿到的token是否还在有效期
  Future<bool> isReady() async {
    return await _channel.invokeMethod(_Constant.isReady);
  }

  //Only for android ,销毁SDK
  destroy() {
    return _channel.invokeMethod(_Constant.destroy);
  }

  /// -------------add listener------------------

  //点击返回按钮
  EventHandler? _onBackButtonClick;
  //点击登录按钮
  EventHandler? _onAuthButtonClick;
  //点击切换账号
  EventHandler? _onSwitchButtonClick;
  //点击服务条款
  EventHandler? _onTermItemClick;
  //点击服务条款的选择框
  EventHandler? _onTermCheckBoxClick;

  addEventListener(
      EventHandler onBackButtonClick,
      EventHandler onAuthButtonClick,
      EventHandler onSwitchButtonClick,
      EventHandler onTermItemClick,
      EventHandler onTermCheckBoxClick) {
    print(flutterLog + "addEventListener");
    _onBackButtonClick = onBackButtonClick;
    _onAuthButtonClick = onAuthButtonClick;
    _onSwitchButtonClick = onSwitchButtonClick;
    _onTermItemClick = onTermItemClick;
    _onTermCheckBoxClick = onTermCheckBoxClick;

    _channel.setMethodCallHandler(_handler);
  }

  Future<dynamic> _handler(MethodCall call) async {
    print(flutterLog + "receive native method : " + call.method +
        " args: " + call.arguments);
    switch (call.method) {
      case _Constant.onBackButtonClick:
        return _onBackButtonClick!(call.arguments?.cast<String, dynamic>());
      case _Constant.onAuthButtonClick:
        return _onAuthButtonClick!(call.arguments?.cast<String, dynamic>());
      case _Constant.onSwitchButtonClick:
        return _onSwitchButtonClick!(call.arguments?.cast<String, dynamic>());
      case _Constant.onTermItemClick:
        return _onTermItemClick!(call.arguments?.cast<String, dynamic>());
      case _Constant.onTermCheckBoxClick:
        return _onTermCheckBoxClick!(call.arguments?.cast<String, dynamic>());
    }
  }
}
