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

**返回值说明**
类型   |说明    |默认值
------	|-----  |-----
Map<String, dynamic> |取号结果 |-

**Map 集合的字段说明**

- 取号成功

参数名|必须 |类型  |说明
------|-----|------|---
`msg`|是|String|运营商返回的状态信息
`process_id`|是|String|流水号(`有效期10分钟`)
`app_id`|是|String|极验后台配置唯一 id
`operator`|是|String|客户端获取的运营商
`clienttype`|是|String|客户端，1 表示 Android
`sdk`|是|String|SDK 的版本号
`status`|是|int|状态码，状态码为 200
`token`|是|String|运营商返回的`accessToken`
`authcode`|否|String|电信运营商返回的`authcode`

- 取号失败

参数名|必须|类型|说明
------|-----|------|---
`errorCode`|是|String|错误码
`msg`|是|String|运营商返回的状态信息
`process_id`|是|String|流水号(`有效期10分钟`)
`app_id`|是|String|极验后台配置唯一 id
`metadata` |是|JSONObject|具体的错误原因
`operator`|是|String|客户端获取的运营商
`clienttype`|是|String|客户端，1 表示 Android
`sdk`|是|String|SDK 的版本号
`status`|是|int|状态码，状态码为 500

**代码示例**

```dart
var configure = OLUIConfigure();
//参照`UI配置项`章节和demo示例代码在这里设置授权页的UI配置项
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
}
```

### UI配置项

**说明**
UI配置项属于可选参数，当拉起授权页不传递该参数时，插件将按照默认效果展示授权页。其内部属性也是可选配置。

```dart
var configure = OLUIConfiguration();
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
switchButtonColor    | int|切换账号字体颜色|0xFF3973FF
switchTextSize    | int|切换账号字体大小|14
switchButtonHidden    | bool|切换账号是否隐藏|false
switchButtonBackgroundColor    | Color|切换账号按钮背景颜色(仅iOS有效)|-
switchButtonRect    | OLRect|切换账号的宽高和位置坐标|宽80，高25，水平居中，y轴偏移249
switchButtonBgImage    | String|切换账号背景图片|默认无背景

#### 7、登录按钮

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
authButtonImages   | List<String>|[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2|-
authButtonRect    | OLRect|登录按钮的宽高和位置坐标|宽268，高36，水平居中，y轴偏移324
authButtonCornerRadius    | int|登录按钮圆角(仅iOS有效)|-
authBtnText    | String|文字设置|一键登录
authBtnColor    | Color|文字颜色|0xFFFFFFFF
authBtnTextSize    | int|文字大小|15

#### 8、Slogan

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
sloganText   | String|Slogan文本(仅iOS有效)|-
sloganColor    | Color|文字颜色|0xFFA8A8A8
sloganSize    | int|字体大小|10
sloganRect    | OLRect|Slogan 的宽高和位置坐标|宽高包裹内容，水平居中，y轴偏移382

#### 9、服务条款

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
termsRect    | OLRect|服务条款的宽高和位置坐标|默认256，高度自适应，服务条款整体的高度取决于checkbox背景资源的高度以及文本的长度，水平居中，y轴偏移400
termTextColor    | Color|服务条款基础文字颜色|0xFFA8A8A8
termsClauseColor    | Color|服务条款协议文字颜色|0xFF3973FF
termsClauseTextSize    | int|服务条款字体大小|10
termsLineSpacingExtra   | double|服务条款文字行间距|8.0
termsLineSpacingMultiplier   | double|服务条款文字行间距的倍数|1.0
termsBookTitleMarkHidden   | bool|条款名称是否隐藏书名号|true
termsUncheckedToastText   | String|未同意服务条款时的提示文字|请同意服务条款
terms   | List<OLTermsPrivacyItem>|自定义服务条款对象数组。最多支持设置3个自定义服务条款，也可以不设置|-
auxiliaryPrivacyWords   | List<String>|除服务条款外的其他文案，包含服务条款之前和之间已经之后的文本，数组的第一个元素表示服务条款之前的文本，如”登录即同意“，最后一个元素表示末尾的文本，其他表示服务条款之间的连接文本，如”和“、顿号|-

#### 10、Checkbox

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
uncheckedImage    | String|未选中下按钮的图片地址|-
checkedImage   | String|选中下按钮的图片地址|-
defaultCheckBoxState    | bool|选择框是否默认勾选|false

#### 11、其他

**参数说明**
参数            |参数类型|说明|默认值
-----           |------ |-----|----
supportedinterfaceOrientations    | OLIOSInterfaceOrientation|授权页面支持的横竖屏方向(仅iOS有效)|-
userinterfaceStyle   | OLIOSUserInterfaceStyle|授权页面界面样式(仅iOS有效)|-
webNaviHidden    | bool|服务条款页面标题栏是否隐藏(仅iOS有效)|false
webNaviBgColor    | Color|服务条款页面标题栏的背景颜色(仅iOS有效)|-
navWebViewText    | bool|服务条款页面标题栏的文本|服务条款
navWebViewTextColor    | bool|服务条款页面标题栏的字体颜色|0xFF000000
navWebViewTextSize    | bool|服务条款页面标题栏的字体大小|fal17

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
      oneLoginPlugin.dismissAuthView();
    }, 
    onTermCheckBoxClick: (isChecked) {
      debugPrint(tag + "onTermItemClick:$isChecked");
    }, 
    onTermItemClick: (item) {
      debugPrint(tag + "onTermItemClick:${item.title} --  ${item.url}");
    }
);
```