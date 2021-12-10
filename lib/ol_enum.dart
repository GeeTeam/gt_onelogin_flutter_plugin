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

enum OLStatusBarStyle { notSet, lightContent, darkContent }
