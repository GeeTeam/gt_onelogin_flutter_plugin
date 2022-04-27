part of gt_onelogin_flutter_plugin;

class _OLConstant {
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
  static const isProtocolCheckboxChecked =
      "$methodNames/isProtocolCheckboxChecked";
  static const isAvailable = "$methodNames/isAvailable";
  static const setLogEnable = "$methodNames/setLogEnable";
  static const destroy = "$methodNames/destroy";
  static const renewPreGetToken = "$methodNames/renewPreGetToken";
  static const deletePreResultCache = "$methodNames/deletePreResultCache";
  static const setProtocolCheckState = "$methodNames/setProtocolCheckState";

  ///native事件回调flutter方法名称
  static const onBackButtonClick = "$methodNames/onBackButtonClick";
  static const onAuthButtonClick = "$methodNames/onAuthButtonClick";
  static const onSwitchButtonClick = "$methodNames/onSwitchButtonClick";
  static const onTermCheckBoxClick =
      "$methodNames/onTermCheckBoxClick"; //点击服务条款的选择框

  ///方法参数
  static const methodParameters = "$methodChannel/methodParameters";
  static const appId = "$methodParameters/appId";
  static const timeout = "$methodParameters/timeout";

  static const termsItemTitle = "$methodParameters/termsItemTitle";
  static const termsItemUrl = "$methodParameters/termsItemUrl";

  static const rectWidth = "$methodParameters/rectWidth";
  static const rectHeight = "$methodParameters/rectHeight";
  static const rectX = "$methodParameters/rectX";
  static const rectY = "$methodParameters/rectY";

  ///  UI配置参数
  //Only for iOS 授权页面支持的横竖屏方向
  static const supportedinterfaceOrientations =
      "$methodParameters/supportedinterfaceOrientations";
  //Only for iOS 授权页面界面样式
  static const userinterfaceStyle = "$methodParameters/userinterfaceStyle";

  ///--------------弹窗----------------
  //是否是弹框样式
  static const isDialogStyle = "$methodParameters/isDialogStyle";
  //弹窗size，位置
  static const dialogRect = "$methodParameters/dialogRect";
  //弹窗圆角
  static const dialogCornersRadius = "$methodParameters/dialogCornersRadius";
  //服务条款页面是否使用弹窗样式
  static const isWebDialogStyle = "$methodParameters/isWebDialogStyle";

  ///--------------多语言----------------
  static const languageType = "$methodParameters/languageType";

  ///--------------背景----------------
  //设置背景图片
  static const authViewBackgroundImage =
      "$methodParameters/authViewBackgroundImage";
  //Only for iOS 设置背景颜色
  static const backgroundColor = "$methodParameters/backgroundColor";

  ///--------------状态栏----------------
  //Only for Android 状态栏颜色
  static const statusBarBgColor = "$methodParameters/statusBarBgColor";
  //状态栏样式
  static const statusBarStyle = "$methodParameters/statusBarStyle";

  ///--------------系统虚拟按键----------------
  //Only for Android
  static const systemNavBarBgColor = "$methodParameters/systemNavBarBgColor";

  ///--------------标题栏----------------
  // 导航栏标题距离屏幕左边的间距。默认为36，隐私条款导航栏保持一致
  static const navTextMargin = "$methodParameters/navTextMargin";
  //标题栏：颜色
  static const navigationBarColor = "$methodParameters/navigationBarColor";
  //Only for Android 标题栏：高度
  static const authNavHeight = "$methodParameters/authNavHeight";
  //标题栏：隐藏
  static const navHidden = "$methodParameters/navHidden";
  //标题栏：文本
  static const navText = "$methodParameters/navText";
  //标题栏：字体颜色
  static const navTextColor = "$methodParameters/navTextColor";
  //标题栏：字体大小
  static const navTextSize = "$methodParameters/navTextSize";
  //返回按钮图片
  static const navBackImage = "$methodParameters/navBackImage";
  //返回按钮图片 size 位置
  static const navBackImageRect = "$methodParameters/navBackImageRect";
  //返回按钮是否隐藏
  static const navBackImageHidden = "$methodParameters/navBackImageHidden";

  ///--------------logo----------------
  //logo 图片
  static const logoImage = "$methodParameters/logoImage";
  //logo size 位置
  static const logoImageRect = "$methodParameters/logoImageRect";
  //logo：是否隐藏
  static const logoImageHidden = "$methodParameters/logoImageHidden";
  //Only for iOS logo圆角，默认为0
  static const logoCornerRadius = "$methodParameters/logoCornerRadius";

  ///--------------号码----------------
  //号码栏字体颜色
  static const numberColor = "$methodParameters/numberColor";
  //号码栏字体大小
  static const numberSize = "$methodParameters/numberSize";
  //号码栏 size 位置
  static const numberRect = "$methodParameters/numberRect";

  ///--------------切换账号按钮----------------
  // 切换账号按钮文本
  static const switchButtonText = "$methodParameters/switchButtonText";
  // 切换账号按钮字体颜色
  static const switchButtonColor = "$methodParameters/switchButtonColor";
  // 切换账号按钮字体大小
  static const switchTextSize = "$methodParameters/switchTextSize";
  // 切换账号按钮是否隐藏
  static const switchButtonHidden = "$methodParameters/switchButtonHidden";
  //Only for iOS  切换账号按钮背景颜色
  static const switchButtonBackgroundColor =
      "$methodParameters/switchButtonBackgroundColor";
  // 切换账号按钮size  位置
  static const switchButtonRect = "$methodParameters/switchButtonRect";
  //Only for Android 切换账号背景图片
  static const switchButtonBgImage = "$methodParameters/switchButtonBgImage";

  ///--------------一键登录按钮----------------
  //[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
  static const authButtonImages = "$methodParameters/authButtonImages";
  //授权按钮的size 位置
  static const authButtonRect = "$methodParameters/authButtonRect";
  //Only for iOS 授权按钮圆角
  static const authButtonCornerRadius =
      "$methodParameters/authButtonCornerRadius";
  //授权按钮文字
  static const authBtnText = "$methodParameters/authBtnText";
  //授权按钮文字颜色
  static const authBtnColor = "$methodParameters/authBtnColor";
  //授权按钮字体大小
  static const authBtnTextSize = "$methodParameters/authBtnTextSize";

  ///--------------SLogan----------------
  // slogan 文案
  static const sloganText = "$methodParameters/sloganText";
  // slogan文字颜色
  static const sloganColor = "$methodParameters/sloganColor";
  // slogan字体大小
  static const sloganSize = "$methodParameters/sloganSize";
  //slogan size 位置
  static const sloganRect = "$methodParameters/sloganRect";

  ///--------------隐私条款----------------
  //隐私条款 位置及大小
  static const termsRect = "$methodParameters/termsRect";
  //隐私条款基础文字颜色
  static const termTextColor = "$methodParameters/termTextColor";
  //隐私条款文本：隐私条款协议文字颜色
  static const termsClauseColor = "$methodParameters/termsClauseColor";
  //隐私条款文本：隐私条款字体大小
  static const termsClauseTextSize = "$methodParameters/termsClauseTextSize";
  //隐私条款文本：隐私条款文字行间距
  static const termsLineSpacingExtra =
      "$methodParameters/termsLineSpacingExtra";
  //隐私条款文本：隐私条款文字行间距的倍数
  static const termsLineSpacingMultiplier =
      "$methodParameters/termsLineSpacingMultiplier";
  //隐私条款文本：隐私条款名称是否显示书名号
  static const termsBookTitleMarkHidden =
      "$methodParameters/termsBookTitleMarkHidden";
  //未同意隐私条款的提示文字
  static const termsUncheckedToastText =
      "$methodParameters/termsUncheckedToastText";
  //隐私条款对象数组
  static const terms = "$methodParameters/terms";
  //除隐私条款外的其他文案,连接字符串
  static const auxiliaryPrivacyWords =
      "$methodParameters/auxiliaryPrivacyWords";

  //隐私条款CheckBox：未选中下按钮的图片地址
  static const uncheckedImage = "$methodParameters/uncheckedImage";
  //隐私条款CheckBox：选中下按钮的图片地址
  static const checkedImage = "$methodParameters/checkedImage";
  //隐私条款CheckBox：选择框是否默认勾选
  static const defaultCheckBoxState = "$methodParameters/defaultCheckBoxState";

  //Only for iOS 服务条款页面导航栏是否隐藏
  static const webNaviHidden = "$methodParameters/webNaviHidden";
  //Only for iOS 服务条款页面导航的背景颜色
  static const webNaviBgColor = "$methodParameters/webNaviBgColor";
  //隐私条款页面标题栏文字
  static const navWebViewText = "$methodParameters/navWebViewText";
  //隐私条款页面标题栏字体颜色
  static const navWebViewTextColor = "$methodParameters/navWebViewTextColor";
  //隐私条款页面标题栏字体大小
  static const navWebViewTextSize = "$methodParameters/navWebViewTextSize";
  //隐私条款抖动动画样式
  static const protocolShakeStyle = "$methodParameters/protocolShakeStyle";
}
