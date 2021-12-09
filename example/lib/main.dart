import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gt_onelogin_flutter_plugin/gt_onelogin_flutter_plugin.dart';
import 'package:dio/dio.dart';

const olAppId = "b41a959b5cac4dd1277183e074630945";
const getPhoneUrl = "http://onepass.geetest.com/onelogin/result";
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
    oneLoginPlugin.init(olAppId);
    oneLoginPlugin.addEventListener(onBackButtonClick: (_) {
      debugPrint(tag + "onBackButtonClick");
    }, onAuthButtonClick: (_) {
      debugPrint(tag + "onAuthButtonClick");
    }, onSwitchButtonClick: (_) {
      debugPrint(tag + "onSwitchButtonClick");
    }, onTermCheckBoxClick: (isChecked) {
      debugPrint(tag + "onTermItemClick:$isChecked");
    }, onTermItemClick: (item) {
      debugPrint(tag + "onTermItemClick:${item.title} --  ${item.url}");
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
        oneLoginPlugin.dismissAuthView();
      }
    });
  }

  OLUIConfigure _getOLUIConfigure() {
    var configure = OLUIConfigure();
    var screenSize = MediaQuery.of(context).size;

    configure.isDialogStyle = _isDialog;
    configure.dialogRect = OLRect(
        y: (screenSize.height - 340) / 2,
        x: (screenSize.width - 300) / 2,
        height: 340,
        width: 300);
    // configure.supportedinterfaceOrientations = OLIOSInterfaceOrientation.landscape;
    configure.userinterfaceStyle = OLIOSUserInterfaceStyle.dark;
    configure.dialogCornersRadius = 20;
    configure.navigationBarColor = const Color(0x8cff90ff);
    configure.logoImage = "onelogin";
    configure.navText = "一键登录";
    configure.switchButtonText = "自定义切换按钮文案";
    configure.switchButtonColor = Colors.brown;
    configure.authButtonImages = ["bg_logo_launch","bg_logo_launch","bg_logo_launch"];
    configure.authButtonRect = OLRect(x: 0,y: 0,width: 300,height: 40);
    configure.authBtnColor = Colors.yellow;
    configure.authBtnText = "授权登录";
    configure.authBtnColor = Colors.blueAccent;
    configure.sloganText = "极验提供统一认证服务";
    configure.sloganColor = Colors.lightGreen;
    configure.termsClauseColor = Colors.orange;
    configure.termTextColor = Colors.purple;
    configure.termsRect = OLRect(x: 50);
    configure.checkedImage = "checked";
    configure.uncheckedImage = "unchecked";

    configure.logoImage = '网关取号_logo';
    configure.numberColor = Colors.pinkAccent;
    configure.numberSize = 16;

    configure.terms = [
      OLTermsPrivacyItem("自定义服务条款1", "http://www.baidu.com"),
      OLTermsPrivacyItem("自定义服务条款2", "https://www.geetest.com"),
      OLTermsPrivacyItem("自定义服务条款3", "https://www.geetest.com"),
    ];
    configure.auxiliaryPrivacyWords = ["条款前文案", "&", "%", "~", "条款后的文案"];
    debugPrint("configure:${configure.toMap()}");
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
