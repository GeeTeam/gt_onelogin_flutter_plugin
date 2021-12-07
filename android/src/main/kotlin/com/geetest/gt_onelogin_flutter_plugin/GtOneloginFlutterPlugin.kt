package com.geetest.gt_onelogin_flutter_plugin

import android.content.Context
import android.nfc.FormatException
import android.util.Log
import androidx.annotation.NonNull
import com.geetest.onelogin.OneLoginHelper
import com.geetest.onelogin.config.OneLoginThemeConfig
import com.geetest.onelogin.listener.AbstractOneLoginListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import java.lang.StringBuilder


/** GtOneloginFlutterPlugin */
class GtOneloginFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var mContext: Context
  private val TAG = "| Geetest | Android | "

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, Constant.methodChannel)
    channel.setMethodCallHandler(this)
    mContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.i(TAG, "flutter call native: " + call.method)
    when(call.method) {
      Constant.sdkVersion -> {
        result.success(OneLoginHelper.with().sdkVersion())
      }
      Constant.init -> {
        init(call)
      }
      Constant.requestToken -> {
        requestToken(call.arguments, result)
      }
      Constant.dismissAuthView -> {
        OneLoginHelper.with().dismissAuthActivity()
      }
      Constant.isReady -> {
        result.success(OneLoginHelper.with().isPreGetTokenResultValidate)
      }
      Constant.setLogEnable -> {
        OneLoginHelper.with().setLogEnable(call.arguments as Boolean)
      }
      Constant.carrier -> {
        getCarrier(result)
      }
      Constant.isProtocolCheckboxChecked -> {
        result.success(OneLoginHelper.with().isPrivacyChecked)
      }
      Constant.destroy -> {
        OneLoginHelper.with().cancel()
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun init(call: MethodCall) {
    val args: Map<String, Any>? = call.arguments()
    args?.run {
      if (!containsKey(Constant.appId)) {
        Log.e(TAG, "init without appId")
        return
      }
      val appId = get(Constant.appId) as String
      OneLoginHelper.with().init(mContext, appId)

      val timeout: Int = if (containsKey(Constant.timeout)) {
        get(Constant.timeout) as Int
      } else {
        5000
      }
      OneLoginHelper.with().register("", timeout)
    }
  }

  private fun requestToken(uiConfig: Any?, result: Result) {
    OneLoginHelper.with().requestToken(generateUIConfig(uiConfig), object : AbstractOneLoginListener() {
      override fun onResult(p0: JSONObject?) {
        requireNotNull(p0) {
          "onResult argument is null"
        }
        Log.i(TAG, "onResult: $p0")
        val argumentsMap = HashMap<String, Any>()
        val keyIterator: Iterator<String> = p0.keys()
        var key: String
        var value: Any
        while (keyIterator.hasNext()) {
          key = keyIterator.next()
          value = p0[key]
          if (value is JSONObject) {
            value = value.toString()
          }
          argumentsMap[key] = value
        }
        result.success(argumentsMap)
      }

      override fun onLoginButtonClick() {
        Log.i(TAG, "onAuthButtonClick")
        channel.invokeMethod(Constant.onAuthButtonClick, null)
      }

      override fun onBackButtonClick() {
        Log.i(TAG, "onBackButtonClick")
        channel.invokeMethod(Constant.onBackButtonClick, null)
      }

      override fun onSwitchButtonClick() {
        Log.i(TAG, "onSwitchButtonClick")
        channel.invokeMethod(Constant.onSwitchButtonClick, null)
      }

      override fun onPrivacyCheckBoxClick(isChecked: Boolean) {
        Log.i(TAG, "onTermCheckBoxClick")
        val argus = mapOf("isChecked" to isChecked)
        channel.invokeMethod(Constant.onTermCheckBoxClick, argus)
      }

      override fun onPrivacyClick(name: String?, url: String?) {
        Log.i(TAG, "onTermItemClick")
        val argus = mapOf("name" to name, "url" to url)
        channel.invokeMethod(Constant.onTermItemClick, argus)
      }
    })
  }

  /**
   * 获取sim卡运营商类型
   */
  private fun getCarrier(result: Result) {
    when (OneLoginHelper.with().getSimOperator(mContext)) {
      Carrier.CM.name -> {
        result.success(Carrier.CM.value)
      }
      Carrier.CU.name -> {
        result.success(Carrier.CU.value)
      }
      Carrier.CT.name -> {
        result.success(Carrier.CT.value)
      }
      else -> {
        result.success(Carrier.unknown.value)
      }
    }
  }

  private fun generateUIConfig(param: Any?) : OneLoginThemeConfig {
    Log.i(TAG, "generateUIConfig enter ${param?.toString()}")
    if (param !is Map<*, *>) {
      Log.i(TAG, "uiConfig is null")
      return OneLoginThemeConfig.Builder().build()
    }
    val uiConfigBuilder = OneLoginThemeConfig.Builder()

    //弹窗模式
    setDialogStyle(param, uiConfigBuilder)

    //背景
    if (param.containsKey(Constant.authViewBackgroundImage)) {
      uiConfigBuilder.setAuthBGImgPath(param[Constant.authViewBackgroundImage] as String)
    }

    //导航栏、状态栏
    setSystemBar(param, uiConfigBuilder)

    //标题栏布局
    setAuthNavLayout(param, uiConfigBuilder)

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

    //返回按钮
    setBackButton(param, uiConfigBuilder)

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
    if (param.containsKey(Constant.logoImageRect)) {
      val logoImageRect = param[Constant.logoImageRect]
      if (logoImageRect is Map<*, *>) {
        val logoRect = convertMapToRect(logoImageRect, 71, 71, 125, 0)
        uiConfigBuilder.setLogoImgView(logoImage,
          logoRect.width!!, logoRect.height!!, logoImageHidden, logoRect.y!!, 0, logoRect.x!!)
      }
    }

    //号码栏字体颜色
    var numberColor = 0xFF3D424C.toInt()
    if (param.containsKey(Constant.numberColor)) {
      numberColor = hexStrToInt(param[Constant.numberColor] as String)
    }
    //号码栏字体大小
    var numberSize = 24
    if (param.containsKey(Constant.numberSize)) {
      numberSize = (param[Constant.numberSize] as Double).toInt()
    }
    //号码栏 size 位置
    if (param.containsKey(Constant.numberRect)) {
      val numberRectMap = param[Constant.numberRect]
      if (numberRectMap is Map<*, *>) {
        val numberRect = convertMapToRect(numberRectMap, 0, 0, 0, 200)
        uiConfigBuilder.setNumberView(numberColor, numberSize, numberRect.y!!, 0, numberRect.x!!)
      }
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
    if (param.containsKey(Constant.navTextSize)) {
      switchTextSize = (param[Constant.switchTextSize] as Double).toInt()
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
    // 切换账号相对于底部 y 偏移
    var switchButtonOffsetYB = 0
    if (param.containsKey(Constant.switchButtonOffsetYB)) {
      switchButtonOffsetYB = (param[Constant.switchButtonOffsetYB] as Double).toInt()
    }
    // 切换账号按钮size  位置
    if (param.containsKey(Constant.switchButtonRect)) {
      val switchButtonRectMap = param[Constant.switchButtonRect]
      if (switchButtonRectMap is Map<*, *>) {
        val switchButtonRect = convertMapToRect(switchButtonRectMap, 80, 25, 0, 249)
        //切换账号的宽 高 Y轴偏移
        uiConfigBuilder.setSwitchView(switchButtonText, switchButtonColor, switchTextSize,
          switchButtonHidden, switchButtonRect.y!!, switchButtonOffsetYB, switchButtonRect.x!!)
        uiConfigBuilder.setSwitchViewLayout(switchButtonBgImage, switchButtonRect.width!!, switchButtonRect.height!!)
      }
    }

    // 授权按钮 正常状态的背景图片, 不可用状态的背景图片
    var authButtonImage = "gt_one_login_btn"
    var authButtonUncheckedImage = "gt_one_login_btn_unchecked"
    if (param.containsKey(Constant.authButtonImages)) {
      val authButtonImages = param[Constant.authButtonImages] as Array<*>
      authButtonImage = authButtonImages[0] as String
      authButtonUncheckedImage = authButtonImages[1] as String
    }
    //授权按钮的size 位置
    val authButtonRect: OLRect?
    if (param.containsKey(Constant.authButtonRect)) {
      val authButtonRectMap = param[Constant.authButtonRect]
      if (authButtonRectMap is Map<*, *>) {
        authButtonRect = convertMapToRect(authButtonRectMap, 268, 36, 0, 249)
        uiConfigBuilder.setLogBtnLayout(authButtonImage, authButtonUncheckedImage, authButtonRect.width!!,
        authButtonRect.height!!, authButtonRect.y!!, 0, authButtonRect.x!!)
      }
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
      authBtnTextSize = (param[Constant.authBtnTextSize] as Double).toInt()
    }
    uiConfigBuilder.setLogBtnTextView(authBtnText, authBtnColor, authBtnTextSize)

    // slogan文字颜色
    var sloganColor = 0xFFA8A8A8.toInt()
    if (param.containsKey(Constant.sloganColor)) {
      sloganColor = hexStrToInt(param[Constant.sloganColor] as String)
    }
    // slogan字体大小
    var sloganSize = 10
    if (param.containsKey(Constant.sloganSize)) {
      sloganSize = (param[Constant.sloganSize] as Double).toInt()
    }
    // Slogan 相对于底部 y 偏移
    var sloganOffsetYB = 0
    if (param.containsKey(Constant.sloganOffsetYB)) {
      sloganOffsetYB = (param[Constant.sloganOffsetYB] as Double).toInt()
    }
    //slogan size 位置
    if (param.containsKey(Constant.sloganRect)) {
      val sloganRectMap = param[Constant.sloganRect]
      if (sloganRectMap is Map<*, *>) {
        val sloganRect = convertMapToRect(sloganRectMap, 0, 0, 382, 0)
        uiConfigBuilder.setSloganView(sloganColor, sloganSize, sloganRect.y!!, sloganOffsetYB, sloganRect.x!!)
      }
    }

    //隐私条款相对于底部 y 偏移
    var termsOffsetBottom = 0
    if (param.containsKey(Constant.termsOffsetBottom)) {
      termsOffsetBottom = (param[Constant.termsOffsetBottom] as Double).toInt()
    }
    //是否跳转到默认的隐私条款页面
    var isUseNormalWebActivity = true
    if (param.containsKey(Constant.isUseNormalWebActivity)) {
      isUseNormalWebActivity = param[Constant.isUseNormalWebActivity] as Boolean
    }
    //隐私条款选择框和文本的对齐方式
    var termsGravityWithCheckbox = 1 //Gravity.CENTER_HORIZONTAL
    if (param.containsKey(Constant.termsGravityWithCheckbox)) {
      termsGravityWithCheckbox = (param[Constant.termsGravityWithCheckbox] as Double).toInt()
    }
    //隐私条款 位置及大小
    if (param.containsKey(Constant.termsRect)) {
      val termsRectMap = param[Constant.termsRect]
      if (termsRectMap is Map<*, *>) {
        val termsRect = convertMapToRect(termsRectMap, 256, 0, 0, 400)
        uiConfigBuilder.setPrivacyLayout(termsRect.width!!, termsRect.y!!, termsOffsetBottom, termsRect.x!!,
          isUseNormalWebActivity, termsGravityWithCheckbox)
      }
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
    //隐私条款CheckBox size及位置
    if (param.containsKey(Constant.checkBoxRect)) {
      val checkBoxRectMap = param[Constant.checkBoxRect]
      if (checkBoxRectMap is Map<*, *>) {
        val checkBoxRect = convertMapToRect(checkBoxRectMap, 9, 9, 5, 0)
        uiConfigBuilder.setPrivacyCheckBox(uncheckedImage, checkedImage, defaultCheckBoxState,
          checkBoxRect.width!!, checkBoxRect.height!!, checkBoxRect.y!!, checkBoxRect.x!!)
      }
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
      termsClauseTextSize = (param[Constant.termsClauseTextSize] as Double).toInt()
    }
    uiConfigBuilder.setPrivacyClauseView(termTextColor, termsClauseColor, termsClauseTextSize)

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

    //隐私条款文本：隐私条款名称是否显示书名号
    var termsBookTitleMarkHidden = true
    if (param.containsKey(Constant.termsBookTitleMarkHidden)) {
      termsBookTitleMarkHidden = param[Constant.termsBookTitleMarkHidden] as Boolean
    }
    uiConfigBuilder.setPrivacyAddFrenchQuotes(!termsBookTitleMarkHidden)

    //未同意隐私条款的提示文字
    if (param.containsKey(Constant.termsUncheckedToastText)) {
      val termsUncheckedToastText = param[Constant.termsUncheckedToastText] as String
      uiConfigBuilder.setPrivacyUnCheckedToastText(termsUncheckedToastText)
    }

    //服务条款文案对齐方式
    if (param.containsKey(Constant.termsAlignmentAndroid)) {
      val termsAlignmentAndroid = (param[Constant.termsAlignmentAndroid] as Double).toInt()
      uiConfigBuilder.setPrivacyTextGravity(termsAlignmentAndroid)
    }

    //隐私条款对象数组
    if (param.containsKey(Constant.terms) && param.containsKey(Constant.auxiliaryPrivacyWords)) {
      val termsList = getPrivacyItemsList(param[Constant.terms] as List<*>)
      val auxiliaryPrivacyWords = param[Constant.auxiliaryPrivacyWords] as List<*>
      if (termsList == null) { //无自定义条款，连接字符位于运营商条款首尾即可
        val auxiliaryPrivacyWord0 = getAuxiliaryPrivacyWord(0, auxiliaryPrivacyWords)
        val auxiliaryPrivacyWord1 = getAuxiliaryPrivacyWord(1, auxiliaryPrivacyWords)
        uiConfigBuilder.setPrivacyTextView(auxiliaryPrivacyWord0, "", "", auxiliaryPrivacyWord1)
      } else { //有添加自定义条款，将运营商条款置于第一，连接字符个数应比
        val auxiliaryPrivacyWord0 = getAuxiliaryPrivacyWord(0, auxiliaryPrivacyWords)
        val auxiliaryPrivacyWord1 = getAuxiliaryPrivacyWord(1, auxiliaryPrivacyWords)
        val auxiliaryPrivacyWord2 = getAuxiliaryPrivacyWord(2, auxiliaryPrivacyWords)
        val auxiliaryPrivacyWord3 = getAuxiliaryPrivacyWord(3, auxiliaryPrivacyWords)
        val auxiliaryPrivacyWord4 = getAuxiliaryPrivacyWord(4, auxiliaryPrivacyWords)

        val privacyItem0 = getPrivacyItem(0, termsList)
        val privacyItem1 = getPrivacyItem(1, termsList)
        val privacyItem2 = getPrivacyItem(2, termsList)

        uiConfigBuilder.setPrivacyClauseTextStrings(auxiliaryPrivacyWord0, "", "", "",
          auxiliaryPrivacyWord1, privacyItem0.title, privacyItem0.url, "",
          auxiliaryPrivacyWord2, privacyItem1.title, privacyItem1.url, "",
          auxiliaryPrivacyWord3, privacyItem2.title, privacyItem2.url, auxiliaryPrivacyWord4)
      }

    }


    return  uiConfigBuilder.build()
  }

  //设置授权页对话框模式
  private fun setDialogStyle(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
    if (!param.containsKey(Constant.isDialogStyle)) {
      return
    }
    val dialogStyle = param[Constant.isDialogStyle] as Boolean
    if (!dialogStyle) {
      return
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
        val displayMetrics = mContext.resources.displayMetrics
        Log.i(TAG, "displayMetrics: $displayMetrics")
        dialogRect.x?.let {
          //客户设置了距离屏幕左侧的margin
          dialogX = it
        }
        dialogRect.y?.let {
          dialogY = it
        }
        Log.i(TAG, "dialogRect width:${dialogRect.width} height:${dialogRect.height} x:${dialogRect.x} y:${dialogRect.y}")
      }
    }
    var isWebDialogStyle = false
    if (param.containsKey(Constant.isWebDialogStyle)) {
      isWebDialogStyle = param[Constant.isWebDialogStyle] as Boolean
    }
    uiConfigBuilder.setDialogTheme(true,
      dialogWidth, dialogHeight, dialogX, dialogY, false, isWebDialogStyle) //TODO dialogBottomStyle
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
    //状态栏是否为亮色：内容为黑色 暗色：内容为白色
    var statusBarStyle = false //默认为亮色
    if (param.containsKey(Constant.statusBarStyle)) {
      statusBarStyle = (param[Constant.statusBarStyle] as Int) != 2 //暗色枚举对应的序号为2
    }
    uiConfigBuilder.setStatusBar(statusBarBgColor, systemNavBarBgColor, statusBarStyle)
  }

  private fun setAuthNavLayout(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
    if (!param.containsKey(Constant.authNavHeight)
      && !param.containsKey(Constant.navigationBarColor)
      && !param.containsKey(Constant.navHidden)) {
      return
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
    uiConfigBuilder.setAuthNavLayout(navigationBarColor, authNavHeight, true, navHidden)
  }

  private fun setBackButton(param: Map<*, *>, uiConfigBuilder: OneLoginThemeConfig.Builder) {
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
    if (param.containsKey(Constant.navBackImageRect)) {
      val navBackImageRectMap = param[Constant.navBackImageRect]
      if (navBackImageRectMap is Map<*, *>) {
        val navBackImageRect = convertMapToRect(navBackImageRectMap, 24, 24, 12, 0)

        uiConfigBuilder.setAuthNavReturnImgView(navBackImage, navBackImageRect.width!!,
          navBackImageRect.height!!, navBackImageHidden, navBackImageRect.x!!, navBackImageRect.y!!)
      }
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

  private fun getAuxiliaryPrivacyWord(index: Int, words: List<*>): String {
    if (index >= words.size) {
      return ""
    }
    return words[index] as String
  }

  private fun getPrivacyItem(index: Int, terms: List<OLTermsPrivacyItem>): OLTermsPrivacyItem {
    if (index >= terms.size) {
      return OLTermsPrivacyItem("", "")
    }
    return terms[index]
  }

  private fun hexStrToInt(hex: String): Int {
    var result = 0
    val len = hex.length
    for (i in 0 until len) {
      val hexDigit: Int = hex.codePointAt(i)
      result += if (hexDigit >= 48 && hexDigit <= 57) {
        (hexDigit - 48) * (1 shl 4 * (len - 1 - i))
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        (hexDigit - 55) * (1 shl 4 * (len - 1 - i))
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        (hexDigit - 87) * (1 shl 4 * (len - 1 - i))
      } else {
        throw FormatException("Invalid hexadecimal value")
      }
    }
    Log.i(TAG, "hex $hex to $result")
    return result
  }
}
