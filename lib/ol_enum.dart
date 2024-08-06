part of gt_onelogin_flutter_plugin;

enum OLNetworkInfo {
  none, //网络类型未知
  cellular, //仅移动蜂窝数据网络
  wifi, //仅 WIFI 网络
  cellularAndWifi //移动蜂窝数据网络及 WIFI 网络
}

enum OLCarrierType {
  unknow,
  cm, // 移动,
  cu, // 联通
  ct //电信
}

extension HexColor on Color {
  String get hexString => value.toRadixString(16);
}

enum OLLanguageType {
  simplifiedChinese, // 简体中文,默认
  traditionalChinese, // 繁体中文
  english // 英文
}

//仅供iOS使用
enum OLIOSInterfaceOrientation {
  portrait,
  landscape,
}

//仅供iOS使用
enum OLIOSUserInterfaceStyle {
  unspecified, // 不指定样式，跟随系统设置进行展示
  light, //  明亮
  dark, //  暗黑 仅对 iOS 13+ 系统有效
}

//仅供iOS使用
enum OLStatusBarStyle {
  notSet,
  lightContent, // iOS 7+, Light content, for use on dark backgrounds
  darkContent // iOS 13+, Dark content, for use on light backgrounds
}

enum ProtocolShakeStyle {
  none, // 不抖动
  shakeHorizontal, // 水平抖动
  shakeVertical, // 竖直抖动
}

enum OLTextAlignment {
  left, //Visually left aligned
  center, //Visually centered
  right, //Visually right aligned
  justified, //Fully-justified. The last line in a paragraph is natural-aligned. only for iOS
  natural //Indicates the default alignment
}

enum OLCustomWidgetType {
  view,
  imageView,
  textView,
  button
}
