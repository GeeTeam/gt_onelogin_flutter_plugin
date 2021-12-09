package com.geetest.gt_onelogin_flutter_plugin

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.geetest.onelogin.OneLoginHelper
import com.geetest.onelogin.listener.AbstractOneLoginListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject


/** GtOneloginFlutterPlugin */
class GtOneloginFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var mContext: Context
  private val tag = "| Geetest | Android | "

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, Constant.methodChannel)
    channel.setMethodCallHandler(this)
    mContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.i(tag, "flutter call native: " + call.method)
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
        Log.e(tag, "init without appId")
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
    val oneLoginUIConfig = UIHelper.generateUIConfig(uiConfig, mContext)
    OneLoginHelper.with().requestToken(oneLoginUIConfig, object : AbstractOneLoginListener() {
      override fun onResult(p0: JSONObject?) {
        requireNotNull(p0) {
          "onResult argument is null"
        }
        Log.i(tag, "onResult: $p0")
        if (p0.has("errorCode")) {
          val errorCode = p0["errorCode"]
          // 分别对应：切换账号、点击标题栏返回按钮、点击系统返回按钮。此三者有event回调，不再返回到flutter
          if (errorCode == "-20303" || errorCode == "-20302" || errorCode == "-20301") {
            return
          }
        }

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
        Log.i(tag, "onAuthButtonClick")
        channel.invokeMethod(Constant.onAuthButtonClick, null)
      }

      override fun onBackButtonClick() {
        Log.i(tag, "onBackButtonClick")
        channel.invokeMethod(Constant.onBackButtonClick, null)
      }

      override fun onSwitchButtonClick() {
        Log.i(tag, "onSwitchButtonClick")
        channel.invokeMethod(Constant.onSwitchButtonClick, null)
      }

      override fun onPrivacyCheckBoxClick(isChecked: Boolean) {
        Log.i(tag, "onTermCheckBoxClick")
        channel.invokeMethod(Constant.onTermCheckBoxClick, isChecked)
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

}
