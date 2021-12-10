package com.geetest.gt_onelogin_flutter_plugin

import android.content.Context
import android.graphics.BitmapFactory
import android.nfc.FormatException
import android.util.Log
import android.view.ViewGroup
import com.geetest.onelogin.config.OneLoginThemeConfig

object UIHelper {
    private const val tag = "| Geetest | Android | "

    fun generateUIConfig(param: Any?, context: Context) : OneLoginThemeConfig {
        Log.i(tag, "generateUIConfig enter ${param?.toString()}")
        if (param !is Map<*, *>) {
            Log.i(tag, "uiConfig is null")
            return OneLoginThemeConfig.Builder().build()
        }
        val uiConfigBuilder = OneLoginThemeConfig.Builder()

        val displayMetrics = context.resources.displayMetrics
        val screenWidth = (displayMetrics.widthPixels/displayMetrics.density).toInt()
        val screenHeight = (displayMetrics.heightPixels/displayMetrics.density).toInt()
        val statusBarHeight = getStatusBarHeight(context)

        //弹窗模式
        val dialogWidth = setDialogStyle(param, uiConfigBuilder, screenWidth, screenHeight, statusBarHeight)
        val authViewWidth = if (dialogWidth == 0) {
            screenWidth
        } else {
            dialogWidth
        }

        //背景
        if (param.containsKey(Constant.authViewBackgroundImage)) {
            uiConfigBuilder.setAuthBGImgPath(param[Constant.authViewBackgroundImage] as String)
        }

        //导航栏、状态栏的颜色
        setSystemBar(param, uiConfigBuilder)

        //标题栏布局
        val authNavHeight = setAuthNavLayout(param, uiConfigBuilder)

        //标题栏文本相关
        setAuthNavTextView(param, uiConfigBuilder)

        //返回按钮
        setBackButton(param, uiConfigBuilder)

        //logo
        setLogo(param, uiConfigBuilder, authViewWidth, authNavHeight)

        //号码栏
        setNumber(param, uiConfigBuilder)

        //切换账号
        setSwitch(param, uiConfigBuilder)

        //授权按钮的图片资源和布局
        setAuthButtonLayout(param, uiConfigBuilder)

        //授权按钮文本相关
        setAuthButtonTextView(param, uiConfigBuilder)

        //slogan
        setSlogan(param, uiConfigBuilder)

        //设置隐私条款布局
        setPrivacyLayout(param, uiConfigBuilder)

        //checkbox
        setCheckBox(param, uiConfigBuilder, context)

        //服务条款的文字颜色、大小
        setPrivacyClauseView(param, uiConfigBuilder)

        //服务条款文本内部的间距
        setPrivacyLineSpacing(param, uiConfigBuilder)

        //隐私条款文本：隐私条款名称是否显示书名号
        if (param.containsKey(Constant.termsBookTitleMarkHidden)) {
            val termsBookTitleMarkHidden = param[Constant.termsBookTitleMarkHidden] as Boolean
            uiConfigBuilder.setPrivacyAddFrenchQuotes(!termsBookTitleMarkHidden)
        }

        //未同意隐私条款的提示文字
        if (param.containsKey(Constant.termsUncheckedToastText)) {
            val termsUncheckedToastText = param[Constant.termsUncheckedToastText] as String
            uiConfigBuilder.setPrivacyUnCheckedToastText(termsUncheckedToastText)
        }

        //服务条款的内容
        setPrivacyClauseText(param, uiConfigBuilder)

        return  uiConfigBuilder.build()
    }

    //设置授权页对话框模式
    private fun setDialogStyle(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder,
                               screenWidth: Int, screenHeight: Int, statusBarHeight: Int): Int {
        if (!param.containsKey(Constant.isDialogStyle)) {
            return 0
        }
        val dialogStyle = param[Constant.isDialogStyle] as Boolean
        if (!dialogStyle) {
            return 0
        }
        var dialogWidth = 300
        var dialogHeight = 500
        var dialogX = 0
        var dialogY = 0
        if (param.containsKey(Constant.dialogRect)) {
            val dialogRectMap = param[Constant.dialogRect]
            if (dialogRectMap is Map<*, *>) {
                val dialogRect = convertMapToRect(dialogRectMap)
                dialogRect.width?.let {
                    dialogWidth = it
                }
                dialogRect.height?.let {
                    dialogHeight = it
                }
                dialogRect.x?.let {
                    //客户设置了距离屏幕左侧的margin，转换为对话框中心点距离屏幕中心点的x偏移量
                    dialogX = it - (screenWidth - dialogWidth)/2
                }
                dialogRect.y?.let {
                    //flutter中设置的y轴偏移量为对话框上边缘距离屏幕顶部的距离
                    //native中获取的屏幕高不包含状态栏高度
                    //对话框中心点距离屏幕中心点的距离 = flutter设置的y偏移 + 对话框高度的一半 - 屏幕高度的一半
                    dialogY = it + dialogHeight/2 - (screenHeight + statusBarHeight)/2
                }
            }
        }
        var isWebDialogStyle = false
        if (param.containsKey(Constant.isWebDialogStyle)) {
            isWebDialogStyle = param[Constant.isWebDialogStyle] as Boolean
        }
        uiConfigBuilder.setDialogTheme(true,
            dialogWidth, dialogHeight, dialogX, dialogY, false, isWebDialogStyle)
        return dialogWidth
    }

    private fun setSystemBar(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.statusBarBgColor)
            && !param.containsKey(Constant.systemNavBarBgColor)
            && !param.containsKey(Constant.statusBarStyle)) {
            return
        }
        //状态栏
        var statusBarBgColor = 0
        if (param.containsKey(Constant.statusBarBgColor)) {
            statusBarBgColor = hexStrToInt(param[Constant.statusBarBgColor] as String)
        }
        //导航栏
        var systemNavBarBgColor = 0
        if (param.containsKey(Constant.systemNavBarBgColor)) {
            systemNavBarBgColor = hexStrToInt(param[Constant.systemNavBarBgColor] as String)
        }
        //状态栏是否为亮色：true:内容为黑色 false：内容为白色
        var lightColor = false
        if (param.containsKey(Constant.statusBarStyle)) {
            lightColor = (param[Constant.statusBarStyle] as Int) == 2 //暗色内容枚举对应的序号为2
        }
        uiConfigBuilder.setStatusBar(statusBarBgColor, systemNavBarBgColor, lightColor)
    }

    private fun setAuthNavLayout(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder): Int {
        if (!param.containsKey(Constant.authNavHeight)
            && !param.containsKey(Constant.navigationBarColor)
            && !param.containsKey(Constant.navHidden)) {
            return 49
        }
        var authNavHeight = 49 //高度
        if (param.containsKey(Constant.authNavHeight)) {
            authNavHeight = (param[Constant.authNavHeight] as Double).toInt()
        }
        var navigationBarColor = 0 //颜色
        if (param.containsKey(Constant.navigationBarColor)) {
            navigationBarColor = hexStrToInt(param[Constant.navigationBarColor] as String)
        }
        var navHidden = false //隐藏
        if (param.containsKey(Constant.navHidden)) {
            navHidden = param[Constant.navHidden] as Boolean
        }
        uiConfigBuilder.setAuthNavLayout(navigationBarColor, authNavHeight, false, navHidden)
        return if (navHidden) {
            0
        } else {
            authNavHeight
        }
    }

    private fun setBackButton(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.navBackImage)
            && !param.containsKey(Constant.navBackImageHidden)
            && !param.containsKey(Constant.navBackImageRect)) {
            return
        }

        //返回按钮图片
        var navBackImage = "gt_one_login_ic_chevron_left_black"
        if (param.containsKey(Constant.navBackImage)) {
            navBackImage = param[Constant.navBackImage] as String
        }
        //返回按钮是否隐藏
        var navBackImageHidden = false
        if (param.containsKey(Constant.navBackImageHidden)) {
            navBackImageHidden = param[Constant.navBackImageHidden] as Boolean
        }
        //返回按钮图片 size 位置
        var navBackWidth = 24
        var navBackHeight = 24
        var navBackOffsetX = 12
        var navBackOffsetY: Int? = null
        if (param.containsKey(Constant.navBackImageRect)) {
            val navBackImageRectMap = param[Constant.navBackImageRect]
            if (navBackImageRectMap is Map<*, *>) {
                val navBackImageRect = convertMapToRect(navBackImageRectMap)
                navBackImageRect.width?.let {
                    navBackWidth = it
                }
                navBackImageRect.height?.let {
                    navBackHeight = it
                }
                navBackImageRect.x?.let {
                    navBackOffsetX = it
                }
                navBackImageRect.y?.let {
                    navBackOffsetY = it
                }
            }
        }
        if (navBackOffsetY == null) { //不传y轴偏移表示返回按钮垂直居中
            uiConfigBuilder.setAuthNavReturnImgView(navBackImage, navBackWidth, navBackHeight,
                navBackImageHidden, navBackOffsetX)
        } else {
            uiConfigBuilder.setAuthNavReturnImgView(navBackImage, navBackWidth, navBackHeight,
                navBackImageHidden, navBackOffsetX, navBackOffsetY!!)
        }
    }

    private fun setAuthNavTextView(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        //标题栏：文本
        var navText = "一键登录"
        if (param.containsKey(Constant.navText)) {
            navText = param[Constant.navText] as String
        }
        //标题栏：字体颜色
        var navTextColor = 0xFFFFFFFF.toInt()
        if (param.containsKey(Constant.navTextColor)) {
            navTextColor = hexStrToInt(param[Constant.navTextColor] as String)
        }
        //标题栏：字体大小
        var navTextSize = 17
        if (param.containsKey(Constant.navTextSize)) {
            navTextSize = param[Constant.navTextSize] as Int
        }
        //标题栏：服务条款页面的标题栏是否使用自定义的文本 true即使用navWebViewText，false为使用服务条款对应的名称 注：运营商条款固定使用条款的名称作为标题
        var navWebTextNormal = false
        //隐私条款页面标题栏文字
        var navWebViewText = "服务条款"
        if (param.containsKey(Constant.navWebViewText)) {
            navWebTextNormal = true
            navWebViewText = param[Constant.navWebViewText] as String
        }
        //隐私条款页面标题栏字体颜色
        var navWebViewTextColor = 0xFFFFFFFF.toInt()
        if (param.containsKey(Constant.navWebViewTextColor)) {
            navWebViewTextColor = hexStrToInt(param[Constant.navWebViewTextColor] as String)
        }
        //隐私条款页面标题栏字体大小
        var navWebViewTextSize = 17
        if (param.containsKey(Constant.navWebViewTextSize)) {
            navWebViewTextSize = param[Constant.navWebViewTextSize] as Int
        }
        uiConfigBuilder.setAuthNavTextView(navText, navTextColor, navTextSize, navWebTextNormal, navWebViewText, navWebViewTextColor, navWebViewTextSize)
    }

    private fun setLogo(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder,
                        authViewWidth: Int, authNavHeight: Int) {
        if (!param.containsKey(Constant.logoImage)
            && !param.containsKey(Constant.logoImageHidden)
            && !param.containsKey(Constant.logoImageRect)) {
            return
        }
        //logo 图片
        var logoImage = "gt_one_login_logo"
        if (param.containsKey(Constant.logoImage)) {
            logoImage = param[Constant.logoImage] as String
        }
        //logo：是否隐藏
        var logoImageHidden = false
        if (param.containsKey(Constant.logoImageHidden)) {
            logoImageHidden = param[Constant.logoImageHidden] as Boolean
        }
        //logo size 位置
        var logoWidth = 71
        var logoHeight = 71
        var logoOffsetX = 0
        var logoOffsetY = 125
        if (param.containsKey(Constant.logoImageRect)) {
            val logoImageRect = param[Constant.logoImageRect]
            if (logoImageRect is Map<*, *>) {
                val logoRect = convertMapToRect(logoImageRect)
                logoRect.width?.let {
                    logoWidth = it
                }
                logoRect.height?.let {
                    logoHeight = it
                }
                logoRect.x?.let {
                    logoOffsetX = it-(authViewWidth-logoWidth)/2
                }
                logoRect.y?.let {
                    logoOffsetY = it+authNavHeight //android sdk中logo的y轴偏移的起点是状态栏下边缘
                }
            }
        }
        uiConfigBuilder.setLogoImgView(logoImage,
            logoWidth, logoHeight, logoImageHidden, logoOffsetY, 0, logoOffsetX)
    }

    private fun setNumber(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.numberColor)
            && !param.containsKey(Constant.numberSize)
            && !param.containsKey(Constant.numberRect)) {
            return
        }
        //号码栏字体颜色
        var numberColor = 0xFF3D424C.toInt()
        if (param.containsKey(Constant.numberColor)) {
            numberColor = hexStrToInt(param[Constant.numberColor] as String)
        }
        //号码栏字体大小
        var numberSize = 24
        if (param.containsKey(Constant.numberSize)) {
            numberSize = param[Constant.numberSize] as Int
        }
        //号码栏 size 位置
        var numberRect: OLRect? = null
        if (param.containsKey(Constant.numberRect)) {
            val numberRectMap = param[Constant.numberRect]
            if (numberRectMap is Map<*, *>) {
                numberRect = convertMapToRect(numberRectMap,0, 0, 0, 200)
            }
        }
        if (numberRect == null) {
            numberRect = OLRect(0, 0, 0, 200)
        }
        uiConfigBuilder.setNumberView(numberColor, numberSize, numberRect.y!!, 0, numberRect.x!!)
    }

    private fun setSwitch(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.switchButtonText)
            && !param.containsKey(Constant.switchButtonColor)
            && !param.containsKey(Constant.navTextSize)
            && !param.containsKey(Constant.switchButtonHidden)
            && !param.containsKey(Constant.switchButtonBgImage)
            && !param.containsKey(Constant.switchButtonRect)) {
            return
        }
        // 切换账号按钮文本
        var switchButtonText = "切换账号"
        if (param.containsKey(Constant.switchButtonText)) {
            switchButtonText = param[Constant.switchButtonText] as String
        }
        // 切换账号按钮字体颜色
        var switchButtonColor = 0xFF3973FF.toInt()
        if (param.containsKey(Constant.switchButtonColor)) {
            switchButtonColor = hexStrToInt(param[Constant.switchButtonColor] as String)
        }
        // 切换账号按钮字体大小
        var switchTextSize = 14
        if (param.containsKey(Constant.switchTextSize)) {
            switchTextSize = param[Constant.switchTextSize] as Int
        }
        // 切换账号按钮是否隐藏
        var switchButtonHidden = false
        if (param.containsKey(Constant.switchButtonHidden)) {
            switchButtonHidden = param[Constant.switchButtonHidden] as Boolean
        }
        // 切换账号背景图片
        var switchButtonBgImage = ""
        if (param.containsKey(Constant.switchButtonBgImage)) {
            switchButtonBgImage = param[Constant.switchButtonBgImage] as String
        }
        // 切换账号按钮size  位置
        var switchButtonRect: OLRect? = null
        if (param.containsKey(Constant.switchButtonRect)) {
            val switchButtonRectMap = param[Constant.switchButtonRect]
            if (switchButtonRectMap is Map<*, *>) {
                switchButtonRect = convertMapToRect(switchButtonRectMap, 80, 25, 0, 249)
            }
        }
        if (switchButtonRect == null) {
            switchButtonRect = OLRect(80, 25, 0, 249)
        }

        uiConfigBuilder.setSwitchView(switchButtonText, switchButtonColor, switchTextSize,
            switchButtonHidden, switchButtonRect.y!!, 0, switchButtonRect.x!!)
        uiConfigBuilder.setSwitchViewLayout(switchButtonBgImage, switchButtonRect.width!!, switchButtonRect.height!!)
    }

    private fun setAuthButtonLayout(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.authButtonImages)
            && !param.containsKey(Constant.authButtonRect)) {
            return
        }
        // 授权按钮 正常状态的背景图片, 不可用状态的背景图片
        var authButtonImage = "gt_one_login_btn"
        var authButtonUncheckedImage = "gt_one_login_btn_unchecked"
        if (param.containsKey(Constant.authButtonImages)) {
            val authButtonImages = param[Constant.authButtonImages] as List<*>
            if (authButtonImages.size >= 2) {
                authButtonImage = authButtonImages[0] as String
                authButtonUncheckedImage = authButtonImages[1] as String
            } else if (authButtonImages.size == 1) {
                authButtonImage = authButtonImages[0] as String
                authButtonUncheckedImage = authButtonImage
            }
        }
        //授权按钮的size 位置
        var authButtonRect: OLRect? = null
        if (param.containsKey(Constant.authButtonRect)) {
            val authButtonRectMap = param[Constant.authButtonRect]
            if (authButtonRectMap is Map<*, *>) {
                authButtonRect = convertMapToRect(authButtonRectMap, 268, 36, 0, 324)
            }
        }
        if (authButtonRect == null) {
            authButtonRect = OLRect(268, 36, 0, 324)
        }
        uiConfigBuilder.setLogBtnLayout(authButtonImage, authButtonUncheckedImage, authButtonRect.width!!,
            authButtonRect.height!!, authButtonRect.y!!, 0, authButtonRect.x!!)
    }

    private fun setAuthButtonTextView(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.authBtnText)
            && !param.containsKey(Constant.authBtnColor)
            && !param.containsKey(Constant.authBtnTextSize)) {
            return
        }
        //授权按钮文字
        var authBtnText = "一键登录"
        if (param.containsKey(Constant.authBtnText)) {
            authBtnText = param[Constant.authBtnText] as String
        }
        //授权按钮文字颜色
        var authBtnColor = 0xFFFFFFFF.toInt()
        if (param.containsKey(Constant.authBtnColor)) {
            authBtnColor = hexStrToInt(param[Constant.authBtnColor] as String)
        }
        //授权按钮字体大小
        var authBtnTextSize = 15
        if (param.containsKey(Constant.authBtnTextSize)) {
            authBtnTextSize = param[Constant.authBtnTextSize] as Int
        }
        uiConfigBuilder.setLogBtnTextView(authBtnText, authBtnColor, authBtnTextSize)
    }

    private fun setSlogan(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.sloganColor)
            && !param.containsKey(Constant.sloganSize)
            && !param.containsKey(Constant.sloganRect)) {
            return
        }
        // slogan文字颜色
        var sloganColor = 0xFFA8A8A8.toInt()
        if (param.containsKey(Constant.sloganColor)) {
            sloganColor = hexStrToInt(param[Constant.sloganColor] as String)
        }
        // slogan字体大小
        var sloganSize = 10
        if (param.containsKey(Constant.sloganSize)) {
            sloganSize = param[Constant.sloganSize] as Int
        }
        //slogan size 位置
        var sloganRect: OLRect? = null
        if (param.containsKey(Constant.sloganRect)) {
            val sloganRectMap = param[Constant.sloganRect]
            if (sloganRectMap is Map<*, *>) {
                sloganRect = convertMapToRect(sloganRectMap, 0, 0, 0, 382)
            }
        }
        if (sloganRect == null) {
            sloganRect = OLRect(0, 0, 0, 382)
        }
        uiConfigBuilder.setSloganView(sloganColor, sloganSize, sloganRect.y!!, 0, sloganRect.x!!)
    }

    private fun setPrivacyLayout(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.isUseNormalWebActivity)
            && !param.containsKey(Constant.termsRect)) {
            return
        }
        //是否跳转到默认的隐私条款页面
        var isUseNormalWebActivity = true
        if (param.containsKey(Constant.isUseNormalWebActivity)) {
            isUseNormalWebActivity = param[Constant.isUseNormalWebActivity] as Boolean
        }
        //隐私条款选择框和文本的对齐方式
        val termsGravityWithCheckbox = 1 //Gravity.CENTER_HORIZONTAL

        //隐私条款 位置及大小
        var termsRect: OLRect? = null
        if (param.containsKey(Constant.termsRect)) {
            val termsRectMap = param[Constant.termsRect]
            if (termsRectMap is Map<*, *>) {
                termsRect = convertMapToRect(termsRectMap, 256, 0, 0, 400)
            }
        }
        if (termsRect == null) {
            termsRect = OLRect(256, 0, 0, 400)
        }
        uiConfigBuilder.setPrivacyLayout(termsRect.width!!, termsRect.y!!, 0, termsRect.x!!,
            isUseNormalWebActivity, termsGravityWithCheckbox)
    }

    private fun setCheckBox(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder, context: Context) {
        if (!param.containsKey(Constant.uncheckedImage)
            && !param.containsKey(Constant.checkedImage)
            && !param.containsKey(Constant.defaultCheckBoxState)) {
            return
        }

        //隐私条款CheckBox：未选中下按钮的图片地址
        var uncheckedImage = "gt_one_login_unchecked"
        if (param.containsKey(Constant.uncheckedImage)) {
            uncheckedImage = param[Constant.uncheckedImage] as String
        }
        //隐私条款CheckBox：选中下按钮的图片地址
        var checkedImage = "gt_one_login_checked"
        if (param.containsKey(Constant.checkedImage)) {
            checkedImage = param[Constant.checkedImage] as String
        }
        //隐私条款CheckBox：选择框是否默认勾选
        var defaultCheckBoxState = false
        if (param.containsKey(Constant.defaultCheckBoxState)) {
            defaultCheckBoxState = param[Constant.defaultCheckBoxState] as Boolean
        }

        //取选中状态的图片宽高作为checkBox的宽高
        val options = getPictureSize(checkedImage, context)
        val checkBoxWidthDp = (options.outWidth/context.resources.displayMetrics.density).toInt()
        val checkBoxHeightDp = (options.outHeight/context.resources.displayMetrics.density).toInt()
        Log.i(tag, "checkbox pic width:${options.outWidth} height:${options.outHeight}")
        Log.i(tag, "checkbox pic checkBoxWidthDp:$checkBoxWidthDp checkBoxHeightDp:$checkBoxHeightDp")

        uiConfigBuilder.setPrivacyCheckBox(uncheckedImage, checkedImage, defaultCheckBoxState, checkBoxWidthDp, checkBoxHeightDp)
    }

    private fun setPrivacyClauseView(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.termTextColor)
            && !param.containsKey(Constant.termsClauseColor)
            && !param.containsKey(Constant.termsClauseTextSize)) {
            return
        }
        //隐私条款基础文字颜色
        var termTextColor = 0xFFA8A8A8.toInt()
        if (param.containsKey(Constant.termTextColor)) {
            termTextColor = hexStrToInt(param[Constant.termTextColor] as String)
        }
        //隐私条款文本：隐私条款协议文字颜色
        var termsClauseColor = 0xFF3973FF.toInt()
        if (param.containsKey(Constant.termsClauseColor)) {
            termsClauseColor = hexStrToInt(param[Constant.termsClauseColor] as String)
        }
        //隐私条款文本：隐私条款字体大小
        var termsClauseTextSize = 10
        if (param.containsKey(Constant.termsClauseTextSize)) {
            termsClauseTextSize = param[Constant.termsClauseTextSize] as Int
        }
        uiConfigBuilder.setPrivacyClauseView(termTextColor, termsClauseColor, termsClauseTextSize)
    }

    private fun setPrivacyLineSpacing(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.termsLineSpacingExtra)
            && !param.containsKey(Constant.termsLineSpacingMultiplier)) {
            return
        }
        //隐私条款文本：隐私条款文字行间距
        var termsLineSpacingExtra = 8.0f
        if (param.containsKey(Constant.termsLineSpacingExtra)) {
            termsLineSpacingExtra = (param[Constant.termsLineSpacingExtra] as Double).toFloat()
        }
        //隐私条款文本：隐私条款文字行间距的倍数
        var termsLineSpacingMultiplier = 1.0f
        if (param.containsKey(Constant.termsLineSpacingMultiplier)) {
            termsLineSpacingMultiplier = (param[Constant.termsLineSpacingMultiplier] as Double).toFloat()
        }
        uiConfigBuilder.setPrivacyLineSpacing(termsLineSpacingExtra, termsLineSpacingMultiplier)
    }

    private fun setPrivacyClauseText(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
        if (!param.containsKey(Constant.terms)
            && !param.containsKey(Constant.auxiliaryPrivacyWords)) {
            return
        }

        //服务条款列表
        val termsList = if (param.containsKey(Constant.terms)) {
            getPrivacyItemsList(param[Constant.terms] as List<*>)
        } else {
            null
        }
        //居间连接字符列表
        val auxiliaryPrivacyWords = if (param.containsKey(Constant.auxiliaryPrivacyWords)) {
            param[Constant.auxiliaryPrivacyWords] as List<*>
        } else {
            null
        }

        if ((termsList == null || termsList.isEmpty())
            && (auxiliaryPrivacyWords == null || auxiliaryPrivacyWords.isEmpty())) {
            return
        }

        val privacyItem0 = getPrivacyItem(0, termsList)
        val privacyItem1 = getPrivacyItem(1, termsList)
        val privacyItem2 = getPrivacyItem(2, termsList)

        //句首字符
        val auxiliaryWordFirst = if (auxiliaryPrivacyWords != null && auxiliaryPrivacyWords.isNotEmpty()) {
            auxiliaryPrivacyWords[0] as String
        } else {
            ""
        }
        //句尾字符
        val auxiliaryWordEnd = if (auxiliaryPrivacyWords != null && auxiliaryPrivacyWords.size > 1) {
            auxiliaryPrivacyWords[auxiliaryPrivacyWords.size-1] as String
        } else {
            ""
        }

        val auxiliaryWord1 = if (auxiliaryPrivacyWords != null && auxiliaryPrivacyWords.size > 2) {
            auxiliaryPrivacyWords[1] as String //取第2个字符作为居间连接符
        } else {
            ""
        }
        val auxiliaryWord2 = if (auxiliaryPrivacyWords != null && auxiliaryPrivacyWords.size > 3) {
            auxiliaryPrivacyWords[2] as String //取第3个字符作为居间连接符
        } else {
            ""
        }
        val auxiliaryWord3 = if (auxiliaryPrivacyWords != null && auxiliaryPrivacyWords.size > 4) {
            auxiliaryPrivacyWords[3] as String //取第4个字符作为居间连接符
        } else {
            ""
        }

        //运营商条款置于第一
        if (termsList == null || termsList.isEmpty()) { //无自定义条款，连接字符位于运营商条款首尾即可
            uiConfigBuilder.setPrivacyTextView(auxiliaryWordFirst, "", "", auxiliaryWordEnd)
        } else if (termsList.size == 1) { //有一个自定义条款
            uiConfigBuilder.setPrivacyTextView(auxiliaryWordFirst, auxiliaryWord1, "", auxiliaryWordEnd)
            uiConfigBuilder.setPrivacyClauseText("", "",
                privacyItem0.title, privacyItem0.url,
                "", "")
        } else if (termsList.size == 2) { //有两个自定义条款
            uiConfigBuilder.setPrivacyTextView(auxiliaryWordFirst, auxiliaryWord1, auxiliaryWord2, auxiliaryWordEnd)
            uiConfigBuilder.setPrivacyClauseText("", "",
                privacyItem0.title, privacyItem0.url,
                privacyItem1.title, privacyItem1.url)
        } else { //有三个自定义条款
            uiConfigBuilder.setPrivacyClauseTextStrings(auxiliaryWordFirst, "", "", "",
                auxiliaryWord1, privacyItem0.title, privacyItem0.url, "",
                auxiliaryWord2, privacyItem1.title, privacyItem1.url, "",
                auxiliaryWord3, privacyItem2.title, privacyItem2.url, auxiliaryWordEnd)
        }
    }

    private fun convertMapToRect(param: Map<*, *>, vararg argus: Int): OLRect {
        val hasDefaultVarargs = argus.size >= 4
        val rect = OLRect()
        if (param.containsKey(Constant.rectWidth)) {
            rect.width = (param[Constant.rectWidth] as Double).toInt()
        } else if (hasDefaultVarargs) {
            rect.width = argus[0]
        }
        if (param.containsKey(Constant.rectHeight)) {
            rect.height = (param[Constant.rectHeight] as Double).toInt()
        } else if (hasDefaultVarargs) {
            rect.height = argus[1]
        }
        if (param.containsKey(Constant.rectX)) {
            rect.x = (param[Constant.rectX] as Double).toInt()
        } else if (hasDefaultVarargs) {
            rect.x = argus[2]
        }
        if (param.containsKey(Constant.rectY)) {
            rect.y = (param[Constant.rectY] as Double).toInt()
        } else if (hasDefaultVarargs) {
            rect.y = argus[3]
        }
        return rect
    }

    private fun getPrivacyItemsList(argus: List<*>) : List<OLTermsPrivacyItem>? {
        if (argus.isEmpty()) {
            return null
        }
        val termsArray: MutableList<OLTermsPrivacyItem> = mutableListOf()
        argus.forEach {
            val itemMap = it as Map<*, *>

            val termTitle = itemMap[Constant.termsItemTitle] as String
            val termUrl = itemMap[Constant.termsItemUrl] as String
            termsArray.add(OLTermsPrivacyItem(termTitle, termUrl))
        }
        return termsArray.toList()
    }

    private fun getPrivacyItem(index: Int, terms: List<OLTermsPrivacyItem>?): OLTermsPrivacyItem {
        if (terms == null) {
            return OLTermsPrivacyItem("", "")
        }
        if (index >= terms.size) {
            return OLTermsPrivacyItem("", "")
        }
        return terms[index]
    }

    /**
     * 十六进制表示的字符串转整数
     */
    private fun hexStrToInt(hex: String): Int {
        var result = 0
        val len = hex.length
        for (i in 0 until len) {
            val hexDigit: Int = hex.codePointAt(i)
            result += if (hexDigit in 48..57) {
                (hexDigit - 48) * (1 shl 4 * (len - 1 - i))
            } else if (hexDigit in 65..70) {
                // A..F
                (hexDigit - 55) * (1 shl 4 * (len - 1 - i))
            } else if (hexDigit in 97..102) {
                // a..f
                (hexDigit - 87) * (1 shl 4 * (len - 1 - i))
            } else {
                throw FormatException("Invalid hexadecimal value")
            }
        }
        return result
    }

    private fun getPictureSize(picName: String, context: Context): BitmapFactory.Options {
        val appInfo = context.applicationInfo
        val picId = context.resources.getIdentifier(picName, "drawable", appInfo.packageName)

        val options = BitmapFactory.Options()
        options.inJustDecodeBounds = true
        BitmapFactory.decodeResource(context.resources, picId, options)
        return options
    }

    private fun getStatusBarHeight(context: Context): Int {
        val res = context.resources
        val statusBarId = res.getIdentifier("status_bar_height", "dimen", "android")
        val statusBarHeightPx = res.getDimensionPixelSize(statusBarId)
        return (statusBarHeightPx/res.displayMetrics.density).toInt()
    }
}