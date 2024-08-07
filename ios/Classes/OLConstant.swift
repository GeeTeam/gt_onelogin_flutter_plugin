//
//  Constant.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/2.
//

import Foundation
struct OLConstant {
    ///方法通道名称
    static let methodChannel = "com.geetest.one_login_plugin";

    ///方法名称
    static let methodNames = "\(methodChannel)/methodNames";
    //初始化
    static let `init` = "\(methodNames)/init";
    static let requestToken = "\(methodNames)/requestToken";
    static let dismissAuthView = "\(methodNames)/dismissAuthView";
    static let sdkVersion = "\(methodNames)/sdkVersion";
    static let carrier = "\(methodNames)/carrier";
    static let isProtocolCheckboxChecked = "\(methodNames)/isProtocolCheckboxChecked";
    static let isAvailable = "\(methodNames)/isAvailable";
    static let setLogEnable = "\(methodNames)/setLogEnable";
    static let destroy = "\(methodNames)/destroy";
    static let renewPreGetToken = "\(methodNames)/renewPreGetToken";
    static let deletePreResultCache = "\(methodNames)/deletePreResultCache";
    static let setProtocolCheckState =
          "\(methodNames)/setProtocolCheckState";
    static let networkInfo = "\(methodNames)/networkInfo";
    
    ///native事件回调flutter方法名称
    static let onBackButtonClick = "\(methodNames)/onBackButtonClick";
    static let onAuthButtonClick = "\(methodNames)/onAuthButtonClick";
    static let onSwitchButtonClick = "\(methodNames)/onSwitchButtonClick";
    static let onTermCheckBoxClick = "\(methodNames)/onTermCheckBoxClick"; //点击服务条款的选择框

    static let onAuthDialogDisagreeBtnClick = "\(methodNames)/onAuthDialogDisagreeBtnClick";

    static let onCustomWidgetsClick =
          "\(methodNames)/onCustomWidgetsClick";
    
    ///方法参数
    static let methodParameters = "\(methodChannel)/methodParameters";
    static let appId = "\(methodParameters)/appId";
    static let timeout = "\(methodParameters)/timeout";

    static let termsItemTitle = "\(methodParameters)/termsItemTitle";
    static let termsItemUrl = "\(methodParameters)/termsItemUrl";
    
    
    static let rectWidth  = "\(methodParameters)/rectWidth"
    static let rectHeight = "\(methodParameters)/rectHeight"
    static let rectX      = "\(methodParameters)/rectX"
    static let rectY      = "\(methodParameters)/rectY"
    
    //  UI配置参数
    // Only for iOS 授权页面支持的横竖屏方向
    static let supportedinterfaceOrientations = "\(methodParameters)/supportedinterfaceOrientations";
    // Only for iOS 授权页面界面样式
    static let userinterfaceStyle = "\(methodParameters)/userinterfaceStyle";
    ///--------------弹窗----------------
    // 是否是弹框样式
    static let isDialogStyle = "\(methodParameters)/isDialogStyle";
    // 弹窗size，位置
    static let dialogRect = "\(methodParameters)/dialogRect";
    // 弹窗圆角
    static let dialogCornersRadius = "\(methodParameters)/dialogCornersRadius";
    //是否需要通过点击弹窗的背景区域以关闭授权页面
    static let isDialogClosedWhenTapBackground = "\(methodParameters)/isDialogClosedWhenTapBackground";

    ///--------------多语言----------------
    static let languageType =
          "\(methodParameters)/languageType";
    
    ///--------------背景----------------
    // 设置背景图片
    static let authViewBackgroundImage = "\(methodParameters)/authViewBackgroundImage";
    // Only for iOS 设置背景颜色
    static let backgroundColor = "\(methodParameters)/backgroundColor";
    ///--------------状态栏----------------
    // Only for Android 状态栏颜色
    static let statusBarBgColor = "\(methodParameters)/statusBarBgColor";
    // 状态栏样式
    static let statusBarStyle = "\(methodParameters)/statusBarStyle";
    ///--------------标题栏，虚拟按键----------------
    // 导航栏标题距离屏幕左边的间距。默认为36，隐私条款导航栏保持一致
    static let navTextMargin = "\(methodParameters)/navTextMargin";
    // 标题栏：颜色
    static let navigationBarColor = "\(methodParameters)/navigationBarColor";
    // Only for Android 标题栏：高度
    static let authNavHeight = "\(methodParameters)/authNavHeight";
    // 标题栏：隐藏
    static let navHidden = "\(methodParameters)/navHidden";
    // 标题栏：文本
    static let navText = "\(methodParameters)/navText";
    // 标题栏：字体颜色
    static let navTextColor = "\(methodParameters)/navTextColor";
    // 标题栏：字体大小
    static let navTextSize = "\(methodParameters)/navTextSize";
    // 返回按钮图片
    static let navBackImage = "\(methodParameters)/navBackImage";
    // 返回按钮图片 size 位置
    static let navBackImageRect = "\(methodParameters)/navBackImageRect";
    // 返回按钮是否隐藏
    static let navBackImageHidden = "\(methodParameters)/navBackImageHidden";
    ///--------------logo----------------
    // logo 图片
    static let logoImage = "\(methodParameters)/logoImage";
    // logo size 位置
    static let logoImageRect = "\(methodParameters)/logoImageRect";
    // logo：是否隐藏
    static let logoImageHidden = "\(methodParameters)/logoImageHidden";
    // Only for iOS logo圆角，默认为0
    static let logoCornerRadius = "\(methodParameters)/logoCornerRadius";
    ///--------------号码----------------
    // 号码栏字体颜色
    static let numberColor = "\(methodParameters)/numberColor";
    // 号码栏字体大小
    static let numberSize = "\(methodParameters)/numberSize";
    // 号码栏 size 位置
    static let numberRect = "\(methodParameters)/numberRect";
    ///--------------切换账号按钮----------------
    // 切换账号按钮文本
    static let switchButtonText = "\(methodParameters)/switchButtonText";
    // 切换账号按钮字体颜色
    static let switchButtonColor = "\(methodParameters)/switchButtonColor";
    // 切换账号按钮字体大小
    static let switchTextSize = "\(methodParameters)/switchTextSize";
    // 切换账号按钮是否隐藏
    static let switchButtonHidden = "\(methodParameters)/switchButtonHidden";
    // Only for iOS  切换账号按钮背景颜色
    static let switchButtonBackgroundColor = "\(methodParameters)/switchButtonBackgroundColor";
    // 切换账号按钮size  位置
    static let switchButtonRect = "\(methodParameters)/switchButtonRect";
    // Only for Android 切换账号相对于底部 y 偏移
    static let switchButtonOffsetYB = "\(methodParameters)/switchButtonOffsetYB";
    // Only for Android 切换账号背景图片
    static let switchButtonBgImage = "\(methodParameters)/switchButtonBgImage";
    ///--------------一键登录按钮----------------
    // [正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
    static let authButtonImages = "\(methodParameters)/authButtonImages";
    // 授权按钮的size 位置
    static let authButtonRect = "\(methodParameters)/authButtonRect";
    // Only for iOS 授权按钮圆角
    static let authButtonCornerRadius = "\(methodParameters)/authButtonCornerRadius";
    // 授权按钮文字
    static let authBtnText = "\(methodParameters)/authBtnText";
    // 授权按钮文字颜色
    static let authBtnColor = "\(methodParameters)/authBtnColor";
    // 授权按钮字体大小
    static let authBtnTextSize = "\(methodParameters)/authBtnTextSize";
    ///--------------SLogan----------------
    // Only for iOS slogan 文案
    static let sloganText = "\(methodParameters)/sloganText";
    // slogan文字颜色
    static let sloganColor = "\(methodParameters)/sloganColor";
    // slogan字体大小
    static let sloganSize = "\(methodParameters)/sloganSize";
    // slogan size 位置
    static let sloganRect = "\(methodParameters)/sloganRect";
    // Only for Android Slogan 相对于底部 y 偏移
    static let sloganOffsetYB = "\(methodParameters)/sloganOffsetYB";
    ///--------------隐私条款----------------
    // 隐私条款 位置及大小
    static let termsRect = "\(methodParameters)/termsRect";
    // Only for Android Slogan 隐私条款相对于底部 y 偏移
    static let termsaOffsetBottom = "\(methodParameters)/termsaOffsetBottom";
    // Only for Android Slogan  隐私条款选择框和文本的对齐方式
    static let termsGravityWithCheckbox = "\(methodParameters)/termsGravityWithCheckbox";
    // 隐私条款基础文字颜色
    static let termTextColor = "\(methodParameters)/termTextColor";
    // 隐私条款文本：隐私条款协议文字颜色
    static let termsClauseColor = "\(methodParameters)/termsClauseColor";
    // 隐私条款文本：隐私条款字体大小
    static let termsClauseTextSize = "\(methodParameters)/termsClauseTextSize";
    // 隐私条款文本：隐私条款文字行间距
    static let termsLineSpacingExtra = "\(methodParameters)/termsLineSpacingExtra";
    // 隐私条款文本：隐私条款文字行间距的倍数
    static let termsLineSpacingMultiplier = "\(methodParameters)/termsLineSpacingMultiplier";
    // 隐私条款文本：隐私条款名称是否显示书名号
    static let termsBookTitleMarkHidden = "\(methodParameters)/termsBookTitleMarkHidden";
    // 未同意隐私条款的提示文字
    static let termsUncheckedToastText = "\(methodParameters)/termsUncheckedToastText";
    //是否显示未同意隐私条款的提示文字
    static let termsUncheckedEnableToast =
          "\(methodParameters)/termsUncheckedEnableToast";
    // 隐私条款对象数组
    static let terms = "\(methodParameters)/terms";
    // 除隐私条款外的其他文案,连接字符串
    static let auxiliaryPrivacyWords = "\(methodParameters)/auxiliaryPrivacyWords";

    // 隐私条款CheckBox：未选中下按钮的图片地址
    static let uncheckedImage = "\(methodParameters)/uncheckedImage";
    // 隐私条款CheckBox：选中下按钮的图片地址
    static let checkedImage = "\(methodParameters)/checkedImage";
    // 隐私条款CheckBox：选择框是否默认勾选
    static let defaultCheckBoxState = "\(methodParameters)/defaultCheckBoxState";
    //隐私条款勾选框大小及位置
    static let checkBoxRect = "\(methodParameters)/checkBoxRect";

    // Only for iOS 服务条款页面导航栏是否隐藏
    static let webNaviHidden = "\(methodParameters)/webNaviHidden";
    // Only for iOS 服务条款页面导航的背景颜色
    static let webNaviBgColor = "\(methodParameters)/webNaviBgColor";
    // 隐私条款页面标题栏文字
    static let navWebViewText = "\(methodParameters)/navWebViewText";
    // 隐私条款页面标题栏字体颜色
    static let navWebViewTextColor = "\(methodParameters)/navWebViewTextColor";
    // 隐私条款页面标题栏字体大小
    static let navWebViewTextSize = "\(methodParameters)/navWebViewTextSize";
    //隐私条款抖动动画样式
    static let protocolShakeStyle = "\(methodParameters)/protocolShakeStyle";
    
    static let willAuthDialogDisplay = "\(methodParameters)/willAuthDialogDisplay";
    static let canCloseAuthDialogFromTapGesture = "\(methodParameters)/canCloseAuthDialogFromTapGesture";
    static let authDialogRect = "\(methodParameters)/authDialogRect";
    static let isAuthDialogBottom = "\(methodParameters)/isAuthDialogBottom";
    static let authDialogBgColor = "\(methodParameters)/authDialogBgColor";
    static let authDialogTitleText = "\(methodParameters)/authDialogTitleText";
    static let authDialogTitleColor = "\(methodParameters)/authDialogTitleColor";
    static let authDialogTitleSize = "\(methodParameters)/authDialogTitleSize";
    static let authDialogContentFontSize = "\(methodParameters)/authDialogContentFontSize";
    static let authDialogDisagreeBtnText = "\(methodParameters)/authDialogDisagreeBtnText";
    static let authDialogDisagreeBtnFontSize = "\(methodParameters)/authDialogDisagreeBtnFontSize";
    static let authDialogDisagreeBtnColor = "\(methodParameters)/authDialogDisagreeBtnColor";
    static let authDialogDisagreeBtnImages = "\(methodParameters)/authDialogDisagreeBtnImages";
    static let authDialogAgreeBtnText = "\(methodParameters)/authDialogAgreeBtnText";
    static let authDialogAgreeBtnFontSize = "\(methodParameters)/authDialogAgreeBtnFontSize";
    static let authDialogAgreeBtnColor = "\(methodParameters)/authDialogAgreeBtnColor";
    static let authDialogAgreeBtnImages = "\(methodParameters)/authDialogAgreeBtnImages";
    static let authDialogCornerRadius = "\(methodParameters)/authDialogCornerRadius";

    ///--------------自定义组件----------------
    static let customWidgetsParameter = "\(methodParameters)/customWidgets";
    static let customWidgetsParaViewId = "\(customWidgetsParameter)/viewId";
    static let customWidgetsParaType = "\(customWidgetsParameter)/type";
    static let customWidgetsParaRect = "\(customWidgetsParameter)/rect";
    static let customWidgetsParaText = "\(customWidgetsParameter)/text";
    static let customWidgetsParaTextSize = "\(customWidgetsParameter)/textSize";
    static let customWidgetsParaTextColor = "\(customWidgetsParameter)/textColor";
    static let customWidgetsParaBackgroundImage = "\(customWidgetsParameter)/backgroundImage";
    static let customWidgetsParaImage = "\(customWidgetsParameter)/image";
    static let customWidgetsParaBackgroundColor = "\(customWidgetsParameter)/backgroundColor";
    static let customWidgetsParaCornerRadius = "\(customWidgetsParameter)/cornerRadius";
    static let customWidgetsParaTextAlignment = "\(customWidgetsParameter)/textAlignment";

}
