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
  gt_onelogin_flutter_plugin:
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

请在 [官网/Official](https://www.geetest.com) 申请 APPID 和 Key，并部署配套的后端接口。详细介绍请查阅：

[部署说明](https://docs.geetest.com/onelogin/overview/start)


## 示例 / Example

### Init

**方法描述**

初始化 

**参数说明**

参数|必须|类型|说明
------|-----|------|---
appId|是|String |极验后台配置唯一产品`APPID`，请在官网申请
timeout|否|Double |超时时间，单位:`ms`，取值范围:`1000~15000`，默认`5000`

**代码示例**

```dart
GtOneloginFlutterPlugin oneLoginPlugin = GtOneloginFlutterPlugin();
oneLoginPlugin.init("b41a959b5cac4dd1277183e074630945");
```

### requestToken

**方法描述**

拉起授权页

**参数说明**
参数|必须|类型|说明
------|-----|------|---
configuration|否|OLUIConfigure |用来配置授权页面 UI 样式，详细含义见`UI配置项`章节

**代码示例**

```dart
oneLoginPlugin.requestToken();
```

### UI配置项

**说明**
UI配置项属于可选参数，当拉起授权页不传递该参数时，插件将按照默认效果展示授权页。其内部属性也是可选配置。

```dart
var configure = OLUIConfigure();
```

#### 1、设置弹窗模式

**参数说明**

参数                 |参数类型  |说明                                                       |默认值
-----               |------   |-----                                                      |----
isDialogStyle       | bool    |是否使用弹窗模式，true 为使用，false 为不使用              |false
dialogRect          | OLRect  |描述弹窗的宽高和位置坐标`dp`，**以下单位与之保持一致** |宽300，高340，居中
isWebDialogStyle    | bool    |服务条款页面是否使用弹窗模式(仅Android有效)|false
dialogCornersRadius | double  |弹窗圆角(仅iOS有效)|6

**OLRect属性说明**
宽高不设置将按照默认值设置，x坐标不设置默认为水平居中，设置后表示控件左边缘距离父布局左上角原点的水平偏移量。y坐标不设置默认为竖直居中，设置后表示控件上边缘距离父布局左上角原点的垂直偏移量。
对话框的父布局左上角位于屏幕左上角，类似授权按钮的控件父布局左上角位于顶部标题栏的左下角。本说明试用于所有OLRect属性。

#### 2、设置背景

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
authViewBackgroundImage   | String|设置背景图片。Android放在 `drawable` 文件下，iOS放在 `asserts` 文件下**以下图片路径与之保持一致**|-
backgroundColor   | Color |设置背景颜色(仅iOS有效)|-

#### 2、状态栏与系统虚拟按键

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
statusBarBgColor   | Color|自定义状态栏背景颜色|0
statusBarStyle   | OLStatusBarStyle |设置状态栏内容的样式|内容为白色
systemNavBarBgColor   | Color |自定义系统导航栏背景颜色(即虚拟按键，仅Android有效)|0

#### 3、标题栏

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
navigationBarColor   | Color|自定义标题栏颜色|0xFF3973FF
authNavHeight   | double|标题栏高度|49
navHidden   | bool|标题栏是否隐藏|false
navText   | String|标题栏文本|一键登录
navTextColor   | Color|字体颜色|0xFF000000
navTextSize   | int|字体大小,单位为`sp`，**以下设置字体大小的单位与之保持一致**|17
navBackImage   | String|标题栏返回按钮图片|-
navBackImageRect   | OLRect|标题栏返回按钮的宽高和位置坐标|宽高24，距离左侧12，垂直居中
navBackImageHidden   | bool|标题栏返回按钮是否隐藏|false

#### 4、logo

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
logoImage   | String|logo 图片|-
logoImageRect   | OLRect|logo的宽高和位置坐标|宽71，高71，水平居中，y轴偏移125
logoImageHidden   | bool|logo是否隐藏|false
logoCornerRadius   | double|logo圆角|0


#### 5、号码

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
numberColor   | Color|号码栏字体颜色|0xFF3D424C
numberSize    | int|号码栏字体大小|24
numberRect    | OLRect|号码栏的宽高和位置坐标|宽高包裹内容，水平居中，y轴偏移200

#### 6、切换账号

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
switchButtonText   | String|切换账号文本|切换账号
numberSize    | int|切换账号字体大小|24
numberRect    | OLRect|切换账号的宽高和位置坐标|宽度80，默认只能显示4个字，如要增加请设置合适的宽度，高度25，水平居中，垂直偏移249

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
oneLoginPlugin.requestToken(configure).then((result) async {
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
        var errCode = result["err_code"];
        // 获取网关token失败
        if ("-20103" == errCode) {
          // TO-DO
          // 重复调用 requestToken:
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
        oneLoginPlugin.dismissAuthView();
      }
    });
    
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
    }
);
```