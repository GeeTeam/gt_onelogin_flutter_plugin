part of gt_onelogin_flutter_plugin;

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
