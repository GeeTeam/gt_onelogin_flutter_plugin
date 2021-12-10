part of gt_onelogin_flutter_plugin;

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

  ///--------------系统虚拟按键----------------
  //Only for Android
  Color? systemNavBarBgColor;
  ///--------------标题栏----------------
  //标题栏：颜色
  Color? navigationBarColor;
  //Only for Android 标题栏：高度
  double? authNavHeight;
  //标题栏：隐藏
  bool? navHidden;
  //标题栏：文本
  String? navText;
  //标题栏：字体颜色
  Color?  navTextColor;
  //标题栏：字体大小
  int?    navTextSize;
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
  // Only for iOS slogan 文案
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
  //Only for Android Slogan  是否跳转到默认的隐私条款页面
  bool? isUseNormalWebActivity;
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

  //Only for iOS 服务条款页面导航栏是否隐藏
  bool? webNaviHidden;
  //Only for iOS 服务条款页面导航的背景颜色
  Color? webNaviBgColor;
  //隐私条款页面标题栏文字
  String? navWebViewText;
  //隐私条款页面标题栏字体颜色
  Color?  navWebViewTextColor;
  //隐私条款页面标题栏字体大小
  int?    navWebViewTextSize;

  Map<String,dynamic> toMap() {
    if (terms != null && (terms?.isNotEmpty ?? false)) {
      if (terms!.length > 3) {
        debugPrint("terms 参数最多限制为3个");
        // throw FlutterError("terms 参数最多限制为3个");
      }
    }

    return {
      _OLConstant.supportedinterfaceOrientations:supportedinterfaceOrientations?.index,
      _OLConstant.userinterfaceStyle:userinterfaceStyle?.index,
      _OLConstant.isDialogStyle:isDialogStyle,
      _OLConstant.dialogRect : dialogRect?.toMap(),
      _OLConstant.isWebDialogStyle : isWebDialogStyle,
      _OLConstant.dialogCornersRadius : dialogCornersRadius,
      _OLConstant.authViewBackgroundImage : authViewBackgroundImage,
      _OLConstant.backgroundColor : backgroundColor?.hexString,
      _OLConstant.statusBarBgColor : statusBarBgColor?.hexString,
      _OLConstant.statusBarStyle : statusBarStyle?.index,
      _OLConstant.systemNavBarBgColor: systemNavBarBgColor?.hexString,
      _OLConstant.navigationBarColor : navigationBarColor?.hexString,
      _OLConstant.authNavHeight : authNavHeight,
      _OLConstant. navHidden : navHidden,
      _OLConstant. navText : navText,
      _OLConstant. navTextColor :navTextColor?.hexString,
      _OLConstant.navTextSize :navTextSize,
      _OLConstant. navBackImage :navBackImage,
      _OLConstant. navBackImageRect :navBackImageRect?.toMap(),
      _OLConstant. navBackImageHidden :navBackImageHidden,
      _OLConstant. logoImage :logoImage,
      _OLConstant.logoImageRect :logoImageRect?.toMap(),
      _OLConstant.logoImageHidden :logoImageHidden,
      _OLConstant. logoCornerRadius :logoCornerRadius,
      _OLConstant.numberColor :numberColor?.hexString,
      _OLConstant. numberSize :numberSize,
      _OLConstant. numberRect :numberRect?.toMap(),
      _OLConstant. switchButtonText :switchButtonText,
      _OLConstant. switchButtonColor :switchButtonColor?.hexString,
      _OLConstant. switchTextSize :switchTextSize,
      _OLConstant. switchButtonHidden :switchButtonHidden,
      _OLConstant.switchButtonBackgroundColor :switchButtonBackgroundColor?.hexString,
      _OLConstant. switchButtonRect :switchButtonRect?.toMap(),
      _OLConstant. switchButtonBgImage :switchButtonBgImage,
      _OLConstant.authButtonImages :authButtonImages,
      _OLConstant. authButtonRect :authButtonRect?.toMap(),
      _OLConstant. authButtonCornerRadius :authButtonCornerRadius,
      _OLConstant. authBtnText :authBtnText,
      _OLConstant.authBtnColor :authBtnColor?.hexString,
      _OLConstant.authBtnTextSize :authBtnTextSize,
      _OLConstant. sloganText :sloganText,
      _OLConstant.sloganColor :sloganColor?.hexString,
      _OLConstant.sloganSize :sloganSize,
      _OLConstant. sloganRect :sloganRect?.toMap(),
      _OLConstant. termsRect :termsRect?.toMap(),
      _OLConstant. isUseNormalWebActivity :isUseNormalWebActivity,
      _OLConstant.termTextColor :termTextColor?.hexString,
      _OLConstant.termsClauseColor :termsClauseColor?.hexString,
      _OLConstant.termsClauseTextSize :termsClauseTextSize,
      _OLConstant. termsLineSpacingExtra :termsLineSpacingExtra,
      _OLConstant.termsLineSpacingMultiplier :termsLineSpacingMultiplier,
      _OLConstant. termsBookTitleMarkHidden :termsBookTitleMarkHidden,
      _OLConstant. termsUncheckedToastText :termsUncheckedToastText,
      _OLConstant.terms :terms?.map((e) => e.toMap()).toList(),
      _OLConstant.auxiliaryPrivacyWords :auxiliaryPrivacyWords,
      _OLConstant. uncheckedImage :uncheckedImage,
      _OLConstant. checkedImage :checkedImage,
      _OLConstant. defaultCheckBoxState :defaultCheckBoxState,
      _OLConstant. webNaviHidden :webNaviHidden,
      _OLConstant.webNaviBgColor :webNaviBgColor?.hexString,
      _OLConstant. navWebViewText :navWebViewText,
      _OLConstant. navWebViewTextColor :navWebViewTextColor?.hexString,
      _OLConstant.navWebViewTextSize :navWebViewTextSize,
    }..removeWhere((key, value) => value == null);
  }







}