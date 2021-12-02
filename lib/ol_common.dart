part of gt_onelogin_flutter_plugin;


class _Constant{
  ///方法通道名称
  static const methodChannel = "com.geetest.one_login_plugin";

  ///方法名称
  static const methodNames = "$methodChannel/methodNames";
  //初始化
  static const init = "$methodNames/init";
  static const requestToken = "$methodNames/requestToken";
  static const dismissAuthView = "$methodNames/dismissAuthView";
  static const sdkVersion = "$methodNames/sdkVersion";
  static const carrier = "$methodNames/carrier";
  static const isProtocolCheckboxChecked = "$methodNames/isProtocolCheckboxChecked";
  static const isReady = "$methodNames/isReady";
  static const setLogEnable = "$methodNames/setLogEnable";
  static const destroy = "$methodNames/destroy";



  ///方法参数
  static const methodParameters = "$methodChannel/methodParameters";
  static const appId = "$methodParameters/appId";
  static const timeout = "$methodParameters/timeout";


}