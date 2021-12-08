# gt_onelogin_flutter_plugin

The official OneLoginSDK flutter plugin project for geetest. Support Flutter 2.0.
极验 OneLoginSDK Flutter 官方插件。支持 Flutter 2.0。

[官网/Official](https://www.geetest.com)

## 开始 / Get started

## 安装 / Install
在工程 `pubspec.yaml` 中 `dependencies` 块中添加下列配置

**Github 集成**

```
dependencies:
  gt3_flutter_plugin:
    git:
      url: https://github.com/GeeTeam/gt_onelogin_flutter_plugin.git
      ref: master
```

或

**pub 集成**

```
dependencies:
  gt_onelogin_flutter_plugin: 0.0.1
```
  
## 配置 / Configuration

请在 [官网/Official](https://www.geetest.com) 申请验证 ID（gt）和 Key，并部署配套的后端接口。详细介绍请查阅：

[部署说明](https://docs.geetest.com/sensebot/start/)/[Deploy Introduction](https://docs.geetest.com/captcha/overview/start/)


## 示例 / Example

### Init

初始化 

```dart
GtOneloginFlutterPlugin oneLoginPlugin = GtOneloginFlutterPlugin();
oneLoginPlugin.init("AppId");
```

### requestToken

拉起授权页

```dart
oneLoginPlugin.requestToken();
```

或

```dart
var configure = OLUIConfigure();
var screenSize = MediaQuery.of(context).size;
configure.isDialogStyle = true;
configure.dialogRect = OLRect(y: (screenSize.height-500)/2,x:(screenSize.width-300)/2,height: 500,width: 300);
configure.userinterfaceStyle = OLIOSUserInterfaceStyle.dark;
configure.dialogCornersRadius = 20;
configure.navigationBarColor = const Color(0x8cff90ff);
configure.logoImage = "onelogin";
configure.navText = "一键登录";
configure.navBackImageRect = OLRect(y: 50,x: 50,width: 20,height: 20);
configure.switchButtonText = "自定义切换按钮文案";
configure.switchButtonColor = Colors.brown;
configure.authButtonRect = OLRect(width: 200);
configure.authBtnColor = Colors.yellow;
configure.authBtnText = "授权登录";
configure.authBtnColor = Colors.blueAccent;
configure.sloganText = "极验提供统一认证服务";
configure.termsClauseColor = Colors.orange;
configure.termTextColor = Colors.purple;
configure.termsRect = OLRect(x: 50);
configure.terms = [
  OLTermsPrivacyItem("自定义服务条款1", "http://www.baidu.com"),
  OLTermsPrivacyItem("自定义服务条款2", "https://www.geetest.com"),
  OLTermsPrivacyItem("自定义服务条款3", "https://www.geetest.com"),
];
configure.auxiliaryPrivacyWords = ["条款前文案", "&", "%", "~", "条款后的文案"];
oneLoginPlugin.requestToken(configure);
```

### dismissAuthView

关闭授权页

```dart
oneLoginPlugin.dismissAuthView();
```


### setLogEnable
设置是否开启日志

```
oneLoginPlugin.setLogEnable(true);
```


### sdkVersion
获取SDK版本号

```
var sdkVersion = oneLoginPlugin.sdkVersion();
```


### getCurrentCarrier
获取当前运营商

```
OLCarrierType currentCarrier = oneLoginPlugin.getCurrentCarrier();
```


### isProtocolCheckboxChecked
隐私条款是否勾选

```
bool isProtocolCheckboxChecked = oneLoginPlugin.isProtocolCheckboxChecked();
```


### isReady
预取号拿到的token是否还在有效期

```
bool isReady = oneLoginPlugin.isReady();
```


###destroy

销毁对象

```dart
oneLoginPlugin.destroy();
```


### addEventHandler

添加处理回调
```dart
oneLoginPlugin.addEventListener(
    onBackButtonClick: (_) {
      debugPrint(tag + "onBackButtonClick");
    },
    onAuthButtonClick: (_) {
      debugPrint(tag + "onAuthButtonClick");
    }, 
    onSwitchButtonClick: (_) {
      debugPrint(tag + "onSwitchButtonClick");
    }, 
    onTermCheckBoxClick: (isChecked) {
      debugPrint(tag + "onTermItemClick:$isChecked");
    }, 
    onTermItemClick: (item) {
      debugPrint(tag + "onTermItemClick:${item.title} --  ${item.url}");
    });
```