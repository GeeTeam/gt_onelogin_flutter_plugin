import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gt_onelogin_flutter_plugin/gt_onelogin_flutter_plugin.dart';
import 'package:dio/dio.dart';

const String tag = "| Geetest | Example | ";

void main() {
  runApp(MaterialApp(
    title: "GTOneLoginPlugin demo",
    theme: ThemeData(primaryColor: Colors.white),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GtOneloginFlutterPlugin oneLoginPlugin = GtOneloginFlutterPlugin();

  //是否是弹窗模式
  bool _isDialog = false;

  //是否自定义授权页面UI
  bool _isCustomUI = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    oneLoginPlugin.init("b41a959b5cac4dd1277183e074630945");
    oneLoginPlugin.addEventListener(onBackButtonClick: (_) {
      debugPrint(tag + "onBackButtonClick");
    }, onAuthButtonClick: (_) {
      debugPrint(tag + "onAuthButtonClick");
    }, onSwitchButtonClick: (_) { // 用户选择切换账号登录，收到此回调后可关闭授权页，跳转或降级走其他方式登录，或者待用户选择
      debugPrint(tag + "onSwitchButtonClick");
      oneLoginPlugin.dismissAuthView();
    }, onTermCheckBoxClick: (isChecked) {
      debugPrint(tag + "onTermItemClick:$isChecked");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GTOneLoginFlutter example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  requestToken();
                },
                child: const Text("OneLogin start",style: TextStyle(
                    fontSize: 20
                ),)),
            const SizedBox(
              height: 50,
            ),
            SwitchListTile(
                title: const Text("是否弹窗模式"),
                value: _isDialog,
                onChanged: (isOn) {
                  setState(() {
                    _isDialog = isOn;
                    _isCustomUI = isOn;
                  });
                }),
            const SizedBox(
              height: 50,
            ),
            SwitchListTile(
                title: const Text("是否自定义UI"),
                value: _isCustomUI,
                onChanged: (isOn) {
                  setState(() {
                    _isCustomUI = isOn;
                  });
                }),
          ],
        ),
      ),
    );
  }

  //拉起授权页
  requestToken() {
    oneLoginPlugin
        .requestToken(_isCustomUI ? _getOLUIConfigure() : null)
        .then((result) async {
      debugPrint("oneLoginPlugin then $result");
      int status = result["status"];
      if (status == 200) {
        Map<String, dynamic> params = {};
        params["process_id"] = result["process_id"];
        params["token"] = result["token"];
        params["id_2_sign"] = result["app_id"];
        if (result["authcode"] != null) {
          params["authcode"] = result["authcode"];
        }
        await verifyToken(params);
      } else {
        var errCode = result["errorCode"];
        // 获取网关token失败
        if (Platform.isIOS) { //iOS错误码
          if ("-20103" == errCode) {
            // TO-DO
            // 重复调用 requestTokenWithViewController:viewModel:completion:
          }
          else if ("-20202" == errCode) {
            // TO-DO
            // 检测到未开启蜂窝网络
          }
          else if ("-20203" == errCode) {
            // TO-DO
            // 不支持的运营商类型
          }
          else if ("-20204" == errCode) {
            // TO-DO
            // 未获取有效的 `accessCode` 或已经失效, 请重新初始化，init(appId):
          }
          else {
            // TO-DO
            // 其他错误类型
          }
        } else { //安卓错误码
          if ("-20200" == errCode) {
            // TO-DO
            // 网络不可用
          } else if ("-20202" == errCode) {
            // TO-DO
            // 检测到未开启蜂窝网络
          }
          else if ("-20203" == errCode) {
            // TO-DO
            // 不支持的运营商类型
          }
          else if ("-20105" == errCode) {
            // TO-DO
            // 超时。网络信号较差或者配置的超时时间较短，导致预取号或者取号超时
          } else {
            // TO-DO
            // 其他错误类型
          }
        }
        oneLoginPlugin.dismissAuthView();
      }
    });
  }

  OLUIConfiguration _getOLUIConfigure() {
    var configure = OLUIConfiguration();
    var screenSize = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    //弹窗样式
    configure.isDialogStyle = _isDialog;
    configure.dialogRect = OLRect(
        y: screenSize.height - 400,
        height: 400,
        width: screenSize.width);
    // configure.supportedinterfaceOrientations = OLIOSInterfaceOrientation.landscape;
    configure.userinterfaceStyle = OLIOSUserInterfaceStyle.dark;
    configure.dialogCornersRadius = 20;

    //背景
    // configure.authViewBackgroundImage = "one_login_bg_fuchsin";

    //状态栏 导航栏
    configure.statusBarBgColor = Colors.transparent;
    configure.systemNavBarBgColor = Colors.transparent;
    configure.statusBarStyle = OLStatusBarStyle.darkContent;

    //标题栏
    configure.navTextColor = Colors.black;
    configure.navigationBarColor = Colors.white;
    configure.navText = "一键登录";
    configure.authNavHeight = 50;
    configure.navTextSize = 25;
    configure.navBackImage = "back";
    configure.navBackImageRect = OLRect(
      width: 13,
      height: 21,
      x: 10,
    );
    configure.navBackImageHidden = false;
    configure.navHidden = false;

    //logo
    configure.logoImage = "onelogin";
    configure.logoImageRect = OLRect(
      width: 100,
      height: 100,
      x: (screenSize.width - 100) / 2,
      y: 90
    );
    configure.logoImageHidden = false;

    //number
    configure.numberColor = Colors.pinkAccent;
    configure.numberSize = 16;
    configure.numberRect = OLRect(
      width: 100,
      height: 25,
      x: (screenSize.width - 100) / 2,
      y: 210
    );

    //切换账号
    configure.switchButtonText = "自定义切换按钮文案";
    configure.switchButtonColor = Colors.black54;
    configure.switchTextSize = 16;
    configure.switchButtonRect = OLRect(
        width: 160,
        height: 28,
        x: (screenSize.width - 160) / 2,
        y: 249);
    // configure.switchButtonBgImage = "one_login_bg_fuchsin";
    configure.switchButtonHidden = false;

    //一键登录按钮
    configure.authButtonImages = ["login_button_enabled","login_button_disabled","btn_blue"];
    configure.authButtonRect = OLRect(
        x: (screenSize.width - 300) / 2,
        y: 324,
        width: 300,
        height: 40);
    configure.authBtnText = "授权登录";
    configure.authBtnColor = Colors.blueAccent;

    //slogan
    configure.sloganText = "极验提供统一认证服务"; //android 侧暂未提供修改slogan文案功能，待规划
    configure.sloganColor = Colors.lightGreen;
    configure.sloganSize = 12;
    configure.sloganRect = OLRect(
      width: 200,
      height: 20,
      x: (screenSize.width - 200) / 2,
      y: 380
    );

    //服务条款
    configure.termsClauseColor = Colors.orange;
    configure.termTextColor = Colors.purple;
    configure.termsRect = OLRect(
        y: (screenSize.height - 90 - 50 - statusBarHeight) //需要减去标题栏的高度、状态栏高度，还有预留的服务条款高度和底部外边距
    );
    configure.isUseNormalWebActivity = true;
    configure.termsClauseTextSize = 10;
    configure.termsLineSpacingExtra = 8.0;
    configure.termsLineSpacingMultiplier = 1.0;
    configure.termsBookTitleMarkHidden = true;
    configure.termsUncheckedToastText = "请查看服务条款并同意后再登录~";

    //checkbox
    configure.checkedImage = "checked";
    configure.uncheckedImage = "unchecked";
    configure.defaultCheckBoxState = false;

    //服务条款的名称、url及连接文案
    configure.terms = [
      OLTermsPrivacyItem("自定义服务条款1", "http://www.baidu.com"),
      OLTermsPrivacyItem("自定义服务条款2", "https://www.geetest.com"),
      OLTermsPrivacyItem("自定义服务条款3", "https://www.geetest.com"),
    ];
    configure.auxiliaryPrivacyWords = ["条款前文案", "&", "%", "~", "条款后的文案"];

    //服务条款展示页面
    configure.navWebViewText = "自定义服务条款的标题栏文案";
    configure.navWebViewTextColor = Colors.white54;
    configure.navWebViewTextSize = 20;

    // debugPrint("configure:${configure.toMap()}");
    return configure;
  }

  //一键登录校验token
  Future<dynamic> verifyToken(Map<String, dynamic> params) async {
    var options = BaseOptions(
      baseUrl: 'http://onepass.geetest.com',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    final response =
        await dio.post<Map<String, dynamic>>("/onelogin/result", data: params);
    String toast = "登录失败";
    if (response.statusCode == 200) {
      var result = response.data;
      debugPrint(response.data.toString());
      if (result != null && result["status"] == 200) {
        toast = "登录成功，手机号为:${result["result"]}";
      }
    }
    oneLoginPlugin.dismissAuthView();
    Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white10,
        textColor: Colors.black87,
        fontSize: 16.0);
    return;
  }
}
