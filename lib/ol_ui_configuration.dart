part of 'gt_onelogin_flutter_plugin.dart';

class OLUIConfiguration {
  //Only for iOS 授权页面支持的横竖屏方向
  OLIOSInterfaceOrientation? supportedinterfaceOrientations;
  //Only for iOS 授权页面界面样式
  OLIOSUserInterfaceStyle? userinterfaceStyle;

  ///--------------弹窗----------------
  //是否是弹框样式
  bool? isDialogStyle;
  //弹窗size，位置
  OLRect? dialogRect;
  //Only for Android 服务条款页面是否使用弹框样式
  bool? isWebDialogStyle;
  //弹窗圆角
  double? dialogCornersRadius;
  //是否需要通过点击弹窗的背景区域以关闭授权页面
  bool? isDialogClosedWhenTapBackground;

  ///--------------多语言配置----------------
  OLLanguageType? languageType;

  ///--------------背景----------------
  //设置背景图片
  String? authViewBackgroundImage;
  //Only for iOS 设置背景颜色
  Color? backgroundColor;

  ///--------------状态栏----------------
  //Only for Android 状态栏颜色
  Color? statusBarBgColor;
  //状态栏样式
  OLStatusBarStyle? statusBarStyle;

  ///--------------背景侵入状态栏区域----------------
  //Only for Android
  bool? bgLayoutInStatusBar;

  ///--------------标题栏----------------
  // 导航栏标题距离屏幕左边的间距。默认为36，隐私条款导航栏保持一致
  double? navTextMargin;
  //标题栏：颜色
  Color? navigationBarColor;
  //Only for Android 标题栏：高度
  double? authNavHeight;
  //标题栏：隐藏
  bool? navHidden;
  //标题栏：文本
  String? navText;
  //标题栏：字体颜色
  Color? navTextColor;
  //标题栏：字体大小
  int? navTextSize;
  //返回按钮图片
  String? navBackImage;
  //返回按钮图片 size 位置
  OLRect? navBackImageRect;
  //返回按钮是否隐藏
  bool? navBackImageHidden;

  ///--------------logo----------------
  //logo 图片
  String? logoImage;
  //logo size 位置
  OLRect? logoImageRect;
  //logo：是否隐藏
  bool? logoImageHidden;
  //Only for iOS logo圆角，默认为0
  double? logoCornerRadius;

  ///--------------号码----------------
  //号码栏字体颜色
  Color? numberColor;
  //号码栏字体大小
  int? numberSize;
  //号码栏 size 位置
  OLRect? numberRect;

  ///--------------切换账号按钮----------------
  // 切换账号按钮文本
  String? switchButtonText;
  // 切换账号按钮字体颜色
  Color? switchButtonColor;
  // 切换账号按钮字体大小
  int? switchTextSize;
  // 切换账号按钮是否隐藏
  bool? switchButtonHidden;
  //Only for iOS  切换账号按钮背景颜色
  Color? switchButtonBackgroundColor;
  // 切换账号按钮size  位置
  OLRect? switchButtonRect;
  //Only for Android 切换账号背景图片
  String? switchButtonBgImage;

  ///--------------一键登录按钮----------------
  //[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
  List<String>? authButtonImages;
  //授权按钮的size 位置
  OLRect? authButtonRect;
  //Only for iOS 授权按钮圆角
  double? authButtonCornerRadius;
  //授权按钮文字
  String? authBtnText;
  //授权按钮文字颜色
  Color? authBtnColor;
  //授权按钮字体大小
  int? authBtnTextSize;

  ///--------------SLogan----------------
  String? sloganText;
  // slogan文字颜色
  Color? sloganColor;
  // slogan字体大小
  int? sloganSize;
  //slogan size 位置
  OLRect? sloganRect;

  ///--------------隐私条款----------------
  //隐私条款 位置及大小
  OLRect? termsRect;
  //隐私条款基础文字颜色
  Color? termTextColor;
  //隐私条款文本：隐私条款协议文字颜色
  Color? termsClauseColor;
  //隐私条款文本：隐私条款字体大小
  int? termsClauseTextSize;
  //隐私条款文本：隐私条款文字行间距
  double? termsLineSpacingExtra;
  //隐私条款文本：隐私条款文字行间距的倍数
  double? termsLineSpacingMultiplier;
  //隐私条款文本：隐私条款名称是否显示书名号
  bool? termsBookTitleMarkHidden;
  //未同意隐私条款的提示文字
  String? termsUncheckedToastText;
  //是否显示未同意隐私条款的提示文字
  bool? termsUncheckedEnableToast;
  //隐私条款对象数组
  List<OLTermsPrivacyItem>? terms;
  //除隐私条款外的其他文案,连接字符串
  List<String>? auxiliaryPrivacyWords;

  //隐私条款CheckBox：未选中下按钮的图片地址
  String? uncheckedImage;
  //隐私条款CheckBox：选中下按钮的图片地址
  String? checkedImage;
  //隐私条款CheckBox：选择框是否默认勾选
  bool? defaultCheckBoxState;
  //隐私条款勾选框大小及位置，请不要设置勾选框的横向偏移，整体隐私条款的横向偏移，请通过 termsRect 设置
  OLRect? checkBoxRect;

  ///--------------服务条款----------------
  //Only for iOS 服务条款页面导航栏是否隐藏
  bool? webNaviHidden;
  //Only for iOS 服务条款页面导航的背景颜色
  Color? webNaviBgColor;
  //隐私条款页面标题栏文字
  String? navWebViewText;
  //隐私条款页面标题栏字体颜色
  Color? navWebViewTextColor;
  //隐私条款页面标题栏字体大小
  int? navWebViewTextSize;

  // 隐私条款抖动动画样式
  ProtocolShakeStyle? protocolShakeStyle;

  ///--------------授权弹窗----------------
  //未勾选同意协议时是否弹出授权弹窗
  bool? willAuthDialogDisplay;
  //点击授权弹窗外是否关闭授权弹窗
  bool? canCloseAuthDialogFromTapGesture;
  //授权弹窗宽、高、起始点位置
  OLRect? authDialogRect;
  //授权弹窗是否显示在屏幕下方
  bool? isAuthDialogBottom;
  //授权弹窗背景颜色
  Color? authDialogBgColor;
  //授权弹窗标题文字
  String? authDialogTitleText;
  //授权弹窗标题颜色
  Color? authDialogTitleColor;
  //授权弹窗字体大小
  int? authDialogTitleSize;
  //授权弹窗富文本字体大小
  int? authDialogContentFontSize;
  //授权弹窗不同意按钮文字
  String? authDialogDisagreeBtnText;
  //授权弹窗不同意按钮字体大小
  int? authDialogDisagreeBtnFontSize;
  //授权弹窗不同意按钮文字颜色
  Color? authDialogDisagreeBtnColor;
  //Only for iOS 授权弹窗不同意按钮的背景图片, @[正常状态的背景图片, 高亮状态的背景图片]。默认正常状态为灰色, 高亮状态为深灰色。
  List<String>? authDialogDisagreeBtnImages;
  //Only for Android 授权弹窗不同意按钮的背景图片
  String? authDialogDisagreeBtnBg;
  //授权弹窗同意按钮文字
  String? authDialogAgreeBtnText;
  //授权弹窗同意按钮字体大小
  int? authDialogAgreeBtnFontSize;
  //授权弹窗同意按钮文字颜色
  Color? authDialogAgreeBtnColor;
  //Only for iOS 授权弹窗同意按钮的背景图片, @[正常状态的背景图片, 高亮状态的背景图片]。默认正常状态为蓝色纯色, 高亮状态为灰蓝色。
  List<String>? authDialogAgreeBtnImages;
  //Only for Android 授权弹窗同意按钮的背景图片
  String? authDialogAgreeBtnBg;
  //授权弹窗圆角，默认为10。
  double? authDialogCornerRadius;

  ///--------------自定义组件----------------
  List<OLCustomWidget>? customWidgets;

  Map<String, dynamic> toMap() {
    if (terms != null && (terms?.isNotEmpty ?? false)) {
      if (terms!.length > 3) {
        debugPrint("terms 参数最多限制为3个");
        // throw FlutterError("terms 参数最多限制为3个");
      }
    }

    return {
      _OLConstant.supportedinterfaceOrientations:
          supportedinterfaceOrientations?.index,
      _OLConstant.userinterfaceStyle: userinterfaceStyle?.index,
      _OLConstant.isDialogStyle: isDialogStyle,
      _OLConstant.dialogRect: dialogRect?.toMap(),
      _OLConstant.isWebDialogStyle: isWebDialogStyle,
      _OLConstant.dialogCornersRadius: dialogCornersRadius,
      _OLConstant.isDialogClosedWhenTapBackground:
          isDialogClosedWhenTapBackground,
      _OLConstant.languageType: languageType?.index ?? 0,
      _OLConstant.authViewBackgroundImage: authViewBackgroundImage,
      _OLConstant.backgroundColor: backgroundColor?.hexString,
      _OLConstant.statusBarBgColor: statusBarBgColor?.hexString,
      _OLConstant.statusBarStyle: statusBarStyle?.index,
      _OLConstant.bgLayoutInStatusBar: bgLayoutInStatusBar,
      _OLConstant.navTextMargin: navTextMargin,
      _OLConstant.navigationBarColor: navigationBarColor?.hexString,
      _OLConstant.authNavHeight: authNavHeight,
      _OLConstant.navHidden: navHidden,
      _OLConstant.navText: navText,
      _OLConstant.navTextColor: navTextColor?.hexString,
      _OLConstant.navTextSize: navTextSize,
      _OLConstant.navBackImage: navBackImage,
      _OLConstant.navBackImageRect: navBackImageRect?.toMap(),
      _OLConstant.navBackImageHidden: navBackImageHidden,
      _OLConstant.logoImage: logoImage,
      _OLConstant.logoImageRect: logoImageRect?.toMap(),
      _OLConstant.logoImageHidden: logoImageHidden,
      _OLConstant.logoCornerRadius: logoCornerRadius,
      _OLConstant.numberColor: numberColor?.hexString,
      _OLConstant.numberSize: numberSize,
      _OLConstant.numberRect: numberRect?.toMap(),
      _OLConstant.switchButtonText: switchButtonText,
      _OLConstant.switchButtonColor: switchButtonColor?.hexString,
      _OLConstant.switchTextSize: switchTextSize,
      _OLConstant.switchButtonHidden: switchButtonHidden,
      _OLConstant.switchButtonBackgroundColor:
          switchButtonBackgroundColor?.hexString,
      _OLConstant.switchButtonRect: switchButtonRect?.toMap(),
      _OLConstant.switchButtonBgImage: switchButtonBgImage,
      _OLConstant.authButtonImages: authButtonImages,
      _OLConstant.authButtonRect: authButtonRect?.toMap(),
      _OLConstant.authButtonCornerRadius: authButtonCornerRadius,
      _OLConstant.authBtnText: authBtnText,
      _OLConstant.authBtnColor: authBtnColor?.hexString,
      _OLConstant.authBtnTextSize: authBtnTextSize,
      _OLConstant.sloganText: sloganText,
      _OLConstant.sloganColor: sloganColor?.hexString,
      _OLConstant.sloganSize: sloganSize,
      _OLConstant.sloganRect: sloganRect?.toMap(),
      _OLConstant.termsRect: termsRect?.toMap(),
      _OLConstant.termTextColor: termTextColor?.hexString,
      _OLConstant.termsClauseColor: termsClauseColor?.hexString,
      _OLConstant.termsClauseTextSize: termsClauseTextSize,
      _OLConstant.termsLineSpacingExtra: termsLineSpacingExtra,
      _OLConstant.termsLineSpacingMultiplier: termsLineSpacingMultiplier,
      _OLConstant.termsBookTitleMarkHidden: termsBookTitleMarkHidden,
      _OLConstant.termsUncheckedToastText: termsUncheckedToastText,
      _OLConstant.termsUncheckedEnableToast: termsUncheckedEnableToast,
      _OLConstant.terms: terms?.map((e) => e.toMap()).toList(),
      _OLConstant.auxiliaryPrivacyWords: auxiliaryPrivacyWords,
      _OLConstant.uncheckedImage: uncheckedImage,
      _OLConstant.checkedImage: checkedImage,
      _OLConstant.defaultCheckBoxState: defaultCheckBoxState,
      _OLConstant.webNaviHidden: webNaviHidden,
      _OLConstant.webNaviBgColor: webNaviBgColor?.hexString,
      _OLConstant.navWebViewText: navWebViewText,
      _OLConstant.navWebViewTextColor: navWebViewTextColor?.hexString,
      _OLConstant.navWebViewTextSize: navWebViewTextSize,
      _OLConstant.protocolShakeStyle: protocolShakeStyle?.index ?? 0,
      _OLConstant.checkBoxRect: checkBoxRect?.toMap(),
      _OLConstant.willAuthDialogDisplay: willAuthDialogDisplay,
      _OLConstant.canCloseAuthDialogFromTapGesture:
          canCloseAuthDialogFromTapGesture,
      _OLConstant.authDialogRect: authDialogRect?.toMap(),
      _OLConstant.isAuthDialogBottom: isAuthDialogBottom,
      _OLConstant.authDialogBgColor: authDialogBgColor?.hexString,
      _OLConstant.authDialogTitleText: authDialogTitleText,
      _OLConstant.authDialogTitleColor: authDialogTitleColor?.hexString,
      _OLConstant.authDialogTitleSize: authDialogTitleSize,
      _OLConstant.authDialogContentFontSize: authDialogContentFontSize,
      _OLConstant.authDialogDisagreeBtnText: authDialogDisagreeBtnText,
      _OLConstant.authDialogDisagreeBtnFontSize: authDialogDisagreeBtnFontSize,
      _OLConstant.authDialogDisagreeBtnColor:
          authDialogDisagreeBtnColor?.hexString,
      _OLConstant.authDialogDisagreeBtnImages: authDialogDisagreeBtnImages,
      _OLConstant.authDialogDisagreeBtnBg: authDialogDisagreeBtnBg,
      _OLConstant.authDialogAgreeBtnText: authDialogAgreeBtnText,
      _OLConstant.authDialogAgreeBtnFontSize: authDialogAgreeBtnFontSize,
      _OLConstant.authDialogAgreeBtnColor: authDialogAgreeBtnColor?.hexString,
      _OLConstant.authDialogAgreeBtnImages: authDialogAgreeBtnImages,
      _OLConstant.authDialogAgreeBtnBg: authDialogAgreeBtnBg,
      _OLConstant.authDialogCornerRadius: authDialogCornerRadius,
      _OLConstant.customWidgetsParameter:
          customWidgets?.map((e) => e.toMap()).toList()
    }..removeWhere((key, value) => value == null);
  }
}
