package com.geetest.gt_onelogin_flutter_plugin

class Constant {
    companion object {
        ///方法通道名称
        const val methodChannel = "com.geetest.one_login_plugin"

        ///方法名称
        private const val methodNames = "$methodChannel/methodNames"
        //初始化
        const val init = "$methodNames/init"
        const val requestToken = "$methodNames/requestToken"
        const val dismissAuthView = "$methodNames/dismissAuthView"
        const val sdkVersion = "$methodNames/sdkVersion"
        const val carrier = "$methodNames/carrier"
        const val networkInfo = "$methodNames/networkInfo"
        const val isProtocolCheckboxChecked = "$methodNames/isProtocolCheckboxChecked"
        const val isAvailable = "$methodNames/isAvailable"
        const val setLogEnable = "$methodNames/setLogEnable"
        const val destroy = "$methodNames/destroy"
        const val renewPreGetToken = "$methodNames/renewPreGetToken";
        const val deletePreResultCache = "$methodNames/deletePreResultCache";
        const val setProtocolCheckState = "$methodNames/setProtocolCheckState";
//        const val startRequestToken = "$methodNames/startRequestToken";

        ///native事件回调flutter方法名称
        const val onBackButtonClick = "$methodNames/onBackButtonClick"
        const val onAuthButtonClick = "$methodNames/onAuthButtonClick"
        const val onSwitchButtonClick = "$methodNames/onSwitchButtonClick"
        const val onTermCheckBoxClick = "$methodNames/onTermCheckBoxClick" //点击服务条款的选择框
//        const val onCustomDisabledAuthAction = "$methodNames/onCustomDisabledAuthAction"//自定义授权弹窗,要实现自定义授权弹窗

        ///方法参数
        private const val methodParameters = "$methodChannel/methodParameters"
        const val appId = "$methodParameters/appId"
        const val timeout = "$methodParameters/timeout"

        const val termsItemTitle = "$methodParameters/termsItemTitle"
        const val termsItemUrl = "$methodParameters/termsItemUrl"

        const val rectWidth  = "$methodParameters/rectWidth"
        const val rectHeight = "$methodParameters/rectHeight"
        const val rectX      = "$methodParameters/rectX"
        const val rectY      = "$methodParameters/rectY"

        ///  UI配置参数
        ///--------------弹窗----------------
        //是否是弹框样式
        const val isDialogStyle = "$methodParameters/isDialogStyle"
        //弹窗size，位置
        const val dialogRect = "$methodParameters/dialogRect"
        //服务条款页面是否使用弹窗样式
        const val isWebDialogStyle = "$methodParameters/isWebDialogStyle"

        ///--------------多语言配置----------------
        const val languageType = "$methodParameters/languageType"

        ///--------------背景----------------
        //设置背景图片
        const val authViewBackgroundImage = "$methodParameters/authViewBackgroundImage"
        ///--------------状态栏----------------
        //Only for Android 状态栏颜色
        const val statusBarBgColor = "$methodParameters/statusBarBgColor"
        //状态栏样式
        const val statusBarStyle = "$methodParameters/statusBarStyle"
//        ///--------------背景侵入状态栏区域----------------
        //Only for Android
        const val bgLayoutInStatusBar = "$methodParameters/bgLayoutInStatusBar"
        ///--------------标题栏----------------
        // 导航栏标题距离屏幕左边的间距。默认为36，隐私条款导航栏保持一致
        const val navTextMargin = "$methodParameters/navTextMargin"
        //标题栏：颜色
        const val navigationBarColor = "$methodParameters/navigationBarColor"
        //Only for Android 标题栏：高度
        const val authNavHeight = "$methodParameters/authNavHeight"
        //标题栏：隐藏
        const val navHidden = "$methodParameters/navHidden"
        //标题栏：文本
        const val navText = "$methodParameters/navText"
        //标题栏：字体颜色
        const val  navTextColor = "$methodParameters/navTextColor"
        //标题栏：字体大小
        const val  navTextSize = "$methodParameters/navTextSize"

        //返回按钮图片
        const val navBackImage = "$methodParameters/navBackImage"
        //返回按钮图片 size 位置
        const val navBackImageRect = "$methodParameters/navBackImageRect"
        //返回按钮是否隐藏
        const val navBackImageHidden = "$methodParameters/navBackImageHidden"
        ///--------------logo----------------
        //logo 图片
        const val logoImage = "$methodParameters/logoImage"
        //logo size 位置
        const val logoImageRect = "$methodParameters/logoImageRect"
        //logo：是否隐藏
        const val logoImageHidden = "$methodParameters/logoImageHidden"
        ///--------------号码----------------
        //号码栏字体颜色
        const val numberColor = "$methodParameters/numberColor"
        //号码栏字体大小
        const val numberSize = "$methodParameters/numberSize"
        //号码栏 size 位置
        const val numberRect = "$methodParameters/numberRect"
        ///--------------切换账号按钮----------------
        // 切换账号按钮文本
        const val switchButtonText = "$methodParameters/switchButtonText"
        // 切换账号按钮字体颜色
        const val  switchButtonColor = "$methodParameters/switchButtonColor"
        // 切换账号按钮字体大小
        const val   switchTextSize = "$methodParameters/switchTextSize"
        // 切换账号按钮是否隐藏
        const val switchButtonHidden = "$methodParameters/switchButtonHidden"
        // 切换账号按钮size  位置
        const val switchButtonRect = "$methodParameters/switchButtonRect"
        //Only for Android 切换账号背景图片
        const val switchButtonBgImage = "$methodParameters/switchButtonBgImage"
        ///--------------一键登录按钮----------------
        //[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
        const val authButtonImages = "$methodParameters/authButtonImages"
        //授权按钮的size 位置
        const val authButtonRect = "$methodParameters/authButtonRect"
        //授权按钮文字
        const val authBtnText = "$methodParameters/authBtnText"
        //授权按钮文字颜色
        const val authBtnColor = "$methodParameters/authBtnColor"
        //授权按钮字体大小
        const val  authBtnTextSize = "$methodParameters/authBtnTextSize"
        ///--------------SLogan----------------
        // slogan 文案
        const val sloganText = "$methodParameters/sloganText"
        // slogan文字颜色
        const val sloganColor = "$methodParameters/sloganColor"

        // slogan字体大小
        const val  sloganSize = "$methodParameters/sloganSize"
        //slogan size 位置
        const val sloganRect = "$methodParameters/sloganRect"
        ///--------------隐私条款----------------
        //隐私条款 位置及大小
        const val termsRect = "$methodParameters/termsRect"
        //隐私条款基础文字颜色
        const val termTextColor = "$methodParameters/termTextColor"
        //隐私条款文本：隐私条款协议文字颜色
        const val termsClauseColor = "$methodParameters/termsClauseColor"
        //隐私条款文本：隐私条款字体大小
        const val  termsClauseTextSize = "$methodParameters/termsClauseTextSize"
        //隐私条款文本：隐私条款文字行间距
        const val termsLineSpacingExtra = "$methodParameters/termsLineSpacingExtra"
        //隐私条款文本：隐私条款文字行间距的倍数
        const val  termsLineSpacingMultiplier = "$methodParameters/termsLineSpacingMultiplier"
        //隐私条款文本：隐私条款名称是否显示书名号
        const val termsBookTitleMarkHidden = "$methodParameters/termsBookTitleMarkHidden"
        //未同意隐私条款的提示文字
        const val termsUncheckedToastText = "$methodParameters/termsUncheckedToastText"
        //是否显示未同意隐私条款的提示文字
        const val termsUncheckedEnableToast = "$methodParameters/termsUncheckedEnableToast"
        //隐私条款对象数组
        const val terms = "$methodParameters/terms"
        //除隐私条款外的其他文案,连接字符串
        const val auxiliaryPrivacyWords = "$methodParameters/auxiliaryPrivacyWords"

        //隐私条款CheckBox：未选中下按钮的图片地址
        const val uncheckedImage = "$methodParameters/uncheckedImage"
        //隐私条款CheckBox：选中下按钮的图片地址
        const val checkedImage = "$methodParameters/checkedImage"
        //隐私条款CheckBox：选择框是否默认勾选
        const val defaultCheckBoxState = "$methodParameters/defaultCheckBoxState"

        //隐私条款页面标题栏文字
        const val navWebViewText = "$methodParameters/navWebViewText"
        //隐私条款页面标题栏字体颜色
        const val  navWebViewTextColor = "$methodParameters/navWebViewTextColor"
        //隐私条款页面标题栏字体大小
        const val  navWebViewTextSize = "$methodParameters/navWebViewTextSize"
        //隐私条款抖动动画样式
        const val protocolShakeStyle = "$methodParameters/protocolShakeStyle"
        //是否自定义授权弹窗
//        const val isCustomDisabledAuthAction  = "$methodParameters/isCustomDisabledAuthAction"

        ///--------------未勾选同意协议时授权弹窗----------------
        //未勾选同意协议时是否弹出授权弹窗
        const val willAuthDialogDisplay = "$methodParameters/willAuthDialogDisplay"
        //点击授权弹窗外是否关闭授权弹窗
        const val canCloseAuthDialogFromTapGesture = "$methodParameters/canCloseAuthDialogFromTapGesture"
        //授权弹窗宽、高、起始点位置
        const val authDialogRect = "$methodParameters/authDialogRect"
        //授权弹窗是否显示在屏幕下方
        const val isAuthDialogBottom = "$methodParameters/isAuthDialogBottom"
        //授权弹窗背景颜色
        const val authDialogBg = "$methodParameters/authDialogBg"
        //授权弹窗标题文字
        const val authDialogTitleText = "$methodParameters/authDialogTitleText"
        //授权弹窗标题颜色
        const val authDialogTitleColor = "$methodParameters/authDialogTitleColor"
        //授权弹窗字体大小
        const val authDialogTitleSize = "$methodParameters/authDialogTitleSize"
        //授权弹窗富文本字体大小
        const val authDialogContentFontSize = "$methodParameters/authDialogContentFontSize"
        //授权弹窗不同意按钮文字
        const val authDialogDisagreeBtnText = "$methodParameters/authDialogDisagreeBtnText"
        //授权弹窗不同意按钮字体大小
        const val authDialogDisagreeBtnFontSize = "$methodParameters/authDialogDisagreeBtnFontSize"
        //授权弹窗不同意按钮文字颜色
        const val authDialogDisagreeBtnColor = "$methodParameters/authDialogDisagreeBtnColor"
        //授权弹窗不同意按钮的背景图片
        const val authDialogDisagreeBtnBg = "$methodParameters/authDialogDisagreeBtnBg"
        //授权弹窗同意按钮文字
        const val authDialogAgreeBtnText = "$methodParameters/authDialogAgreeBtnText"
        //授权弹窗同意按钮字体大小
        const val authDialogAgreeBtnFontSize = "$methodParameters/authDialogAgreeBtnFontSize"
        //授权弹窗同意按钮文字颜色
        const val authDialogAgreeBtnColor = "$methodParameters/authDialogAgreeBtnColor"
        //授权弹窗同意按钮的背景图片
        const val authDialogAgreeBtnBg = "$methodParameters/authDialogAgreeBtnBg"

    }
}