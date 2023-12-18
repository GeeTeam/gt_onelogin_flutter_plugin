# gt_onelogin_flutter_plugin

The official flutter plugin project for geetest OneLoginSDK. Support Flutter 2.x/3.x.
极验 OneLoginSDK Flutter 官方插件。支持 Flutter 2.x/3.x。

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
  gt_onelogin_flutter_plugin: 0.0.4
```
  
## 配置 / Configuration

请在 [官网/Official](https://www.geetest.com) 申请 APPID 和 Key，并部署配套的后端接口。详细介绍请查阅：

[部署说明](https://docs.geetest.com/onelogin/overview/start)


## 示例 / Example

### 创建 GtOneloginFlutterPlugin 实例


**参数说明**

参数|必须|类型|说明
------|-----|------|---
appId|是|String |极验后台配置唯一产品`APPID`，请在官网申请
timeout|否|int |超时时间，单位:`ms`，取值范围:`1000~15000`，默认`8000`

**代码示例**

```dart
GtOneloginFlutterPlugin oneLoginPlugin = GtOneloginFlutterPlugin("b41a959b5cac4dd1277183e074630945");
```

### requestToken

**方法描述**

拉起授权页

**参数说明**

参数|必须|类型|说明
------|-----|------|---
configuration|否|OLUIConfiguration |用来配置授权页面 UI 样式，详细含义见`UI配置项`章节

**返回值说明**
  
更多返回值请参考官网集成文档

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
`status`|是|int|状态码，状态码为 200
`token`|是|String|运营商返回的`accessToken`
`authcode`|否|String|电信运营商返回的`authcode`

- 取号失败

参数名|必须|类型|说明
------|-----|------|---
`errorCode`|是|String|错误码
`msg`|是|String|运营商返回的状态信息
`status`|是|int|状态码，状态码为 500

**代码示例**

```dart
var configure = OLUIConfiguration();
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
        } else { //Android错误码
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

#### 3、状态栏与系统虚拟按键

**参数说明**

参数            | 参数类型             |说明|默认值
-----           |------------------|-----|----
statusBarBgColor   | Color            |自定义状态栏背景颜色(仅Android有效)|0
statusBarStyle   | OLStatusBarStyle |设置状态栏内容的样式|内容为白色
bgLayoutInStatusBar   | bool |背景侵入状态栏区域(仅Android有效)|false

#### 4、标题栏

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
navigationBarColor   | Color|自定义标题栏颜色|Android 0xFF3973FF iOS0xFFFFFF
authNavHeight   | double|标题栏高度(仅Android有效)|Android49 iOS44
navHidden   | bool|标题栏是否隐藏|false
navText   | String|标题栏文本|Android`一键登录` iOS`空字符串`
navTextColor   | Color|字体颜色|0xFF000000
navTextSize   | int|字体大小,单位为`sp`，**以下设置字体大小的单位与之保持一致**|Android：17 iOS：15
navBackImage   | String|标题栏返回按钮图片|-
navBackImageRect   | OLRect|标题栏返回按钮的宽高和位置坐标|宽高24，距离左侧12，垂直居中
navBackImageHidden   | bool|标题栏返回按钮是否隐藏|false
navTextMargin | double | 导航栏标题距离屏幕左边的间距，隐私条款导航栏保持一致 | 36

#### 5、logo

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
logoImage   | String|logo 图片|-
logoImageRect   | OLRect|logo的宽高和位置坐标|Android:宽71，高71，水平居中，y轴偏移125 iOS：默认为图片大小
logoImageHidden   | bool|logo是否隐藏|false
logoCornerRadius   | double|logo圆角|0


#### 6、号码

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
numberColor   | Color|号码栏字体颜色|Android：0xFF3D424C  iOS：黑色
numberSize    | int|号码栏字体大小|24
numberRect    | OLRect|号码栏的宽高和位置坐标|宽高包裹内容，水平居中，y轴偏移200

#### 7、切换账号

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
switchButtonText   | String|切换账号文本|切换账号
switchButtonColor    | int|切换账号字体颜色|Android：0xFF3973FF iOS：蓝色
switchTextSize    | int|切换账号字体大小|Android：14  iOS：15
switchButtonHidden    | bool|切换账号是否隐藏|false
switchButtonBackgroundColor    | Color|切换账号按钮背景颜色(仅iOS有效)|-
switchButtonRect    | OLRect|切换账号的宽高和位置坐标|Android：宽80，高25，水平居中，y轴偏移249 iOS：按比例计算
switchButtonBgImage    | String|切换账号背景图片|默认无背景，仅 Android 有效

#### 8、登录按钮

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
authButtonImages   | List<String>|[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2|-
authButtonRect    | OLRect|Android：登录按钮的宽高和位置坐标|宽268，高36，水平居中，y轴偏移324  iOS；按比例计算
authButtonCornerRadius    | int|登录按钮圆角(仅iOS有效)|0
authBtnText    | String|文字设置|一键登录
authBtnColor    | Color|文字颜色|0xFFFFFFFF
authBtnTextSize    | int|文字大小|15

#### 9、Slogan

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
sloganText   | String|Slogan文本(仅iOS有效)|-
sloganColor    | Color|文字颜色|Android：0xFFA8A8A8   iOS:灰色
sloganSize    | int|字体大小|Android：10  iOS：12
sloganRect    | OLRect|Slogan 的宽高和位置坐标|Android：宽高包裹内容，水平居中，y轴偏移382  iOS：按比例计算

#### 10、服务条款

**参数说明**

参数            | 参数类型                     | 说明                                                                                                |默认值
-----           |--------------------------|---------------------------------------------------------------------------------------------------|----
termsRect    | OLRect                   | 服务条款的宽高和位置坐标                                                                                      |默认256，高度自适应，服务条款整体的高度取决于checkbox背景资源的高度以及文本的长度，水平居中，y轴偏移400
termTextColor    | Color                    | 服务条款基础文字颜色                                                                                        |Android：0xFFA8A8A8 iOS：灰色
termsClauseColor    | Color                    | 服务条款协议文字颜色                                                                                        |Android：0xFF3973FF  iOS：蓝色
termsClauseTextSize    | int                      | 服务条款字体大小                                                                                          |Android:10 iOS：12
termsLineSpacingExtra   | double                   | 服务条款文字行间距                                                                                         |8.0
termsLineSpacingMultiplier   | double                   | 服务条款文字行间距的倍数                                                                                      |1.0
termsBookTitleMarkHidden   | bool                     | 条款名称是否隐藏书名号                                                                                       |true
termsUncheckedToastText   | String                   | 未同意服务条款时的提示文字                                                                                     |请同意服务条款
termsUncheckedEnableToast   | bool                     | 是否显示未同意服务条款时的提示文字                                                                                 |true
terms   | List<OLTermsPrivacyItem> | 自定义服务条款对象数组。最多支持设置3个自定义服务条款，也可以不设置                                                                |-
auxiliaryPrivacyWords   | List<String>             | 除服务条款外的其他文案，包含服务条款之前和之间以及之后的文本，数组的第一个元素表示服务条款之前的文本，如”登录即同意“，最后一个元素表示末尾的文本，其他表示服务条款之间的连接文本，如”和“、顿号 |-
protocolShakeStyle | ProtocolShakeStyle       | 未勾选授权页面隐私协议前勾选框时，点击授权页面登录按钮时勾选框与协议的抖动样式,默认不抖动                                                     |`none`，默认不抖动

#### 11、Checkbox

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
uncheckedImage    | String|未选中下按钮的图片地址|-
checkedImage   | String|选中下按钮的图片地址|-
defaultCheckBoxState    | bool|选择框是否默认勾选|false
checkBoxRect | OLRect | 选择框的位置和大小,仅对 iOS 有效，Android 根据图片大小自适应 | -

#### 12、多语言配置
**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
languageType | OLLanguageType | 多语言配置，支持中文简体，中文繁体，英文 | `simplifiedChinese`，默认中文简体

#### 13、授权弹窗
**参数说明**

参数            |参数类型| 说明                                          |默认值
-----           |------ |---------------------------------------------|----
willAuthDialogDisplay  | bool  | 未勾选同意协议时是否弹出授权弹窗                            | false
canCloseAuthDialogFromTapGesture   | bool  | 点击授权弹窗外是否关闭授权弹窗                             | true
authDialogRect  | OLRect  | 授权弹窗宽、高、起始点位置                               | iOS 宽 300, 高 204，按距离屏幕一定偏移水平垂直居中
isAuthDialogBottom  | bool  | 授权弹窗是否显示在屏幕下方                               | false
authDialogBgColor  | Color  | 授权弹窗背景颜色                                    | 白色
authDialogTitleText  | String  | 授权弹窗标题文字                                    | 服务协议和隐私政策等指引
authDialogTitleColor  | Color  | 授权弹窗标题颜色                                    | 黑色
authDialogTitleSize  | int  | 授权弹窗标题字体大小                                  | 16
authDialogContentFontSize  | int  | 授权弹窗富文本字体大小                                 | 12
authDialogDisagreeBtnText  | String  | 授权弹窗不同意按钮文字                                 | 不同意
authDialogDisagreeBtnFontSize  | int  | 授权弹窗不同意按钮字体大小                               | 14
authDialogDisagreeBtnColor  | Color  | 授权弹窗不同意按钮文字颜色                               | 黑色
authDialogDisagreeBtnImages  | List<String>  | 授权弹窗不同意按钮的背景图片, @[正常状态的背景图片, 高亮状态的背景图片]。    | Only for iOS 默认正常状态为灰色, 高亮状态为深灰色。
authDialogDisagreeBtnBg | String  | 授权弹窗不同意按钮的背景图片, 不同状态的图通过drawable下的xml配置实现。  | Only for Android
authDialogAgreeBtnText  | String  | 授权弹窗同意按钮文字                                  | 同意并继续
authDialogAgreeBtnFontSize  | int  | 授权弹窗同意按钮字体大小                                | 14
authDialogAgreeBtnColor  | Color  | 授权弹窗同意按钮文字颜色                                | 白色
authDialogAgreeBtnImages  | List<String>  | 授权弹窗同意按钮的背景图片, @[正常状态的背景图片, 高亮状态的背景图片]。     | Only for iOS 默认正常状态为蓝色纯色, 高亮状态为灰蓝色
authDialogAgreeBtnBg | String  | 授权弹窗不同意按钮的背景图片,不同状态的图通过drawable下的xml配置实现。   | Only for Android
authDialogCornerRadius | double | 授权弹窗圆角(Only for iOS;Android使用xml的shape配置实现) | 默认为10


#### 14、其他

**参数说明**

参数            |参数类型|说明|默认值
-----           |------ |-----|----
supportedinterfaceOrientations    | OLIOSInterfaceOrientation|授权页面支持的横竖屏方向(仅iOS有效)|-
userinterfaceStyle   | OLIOSUserInterfaceStyle|授权页面界面样式(仅iOS有效)|-
webNaviHidden    | bool|服务条款页面标题栏是否隐藏(仅iOS有效)|false
webNaviBgColor    | Color|服务条款页面标题栏的背景颜色(仅iOS有效)|白色
navWebViewText    | bool|服务条款页面标题栏的文本|不设置时自定义服务条款的标题与协议名称保持一致。运营商协议的标题固定为对应的协议名称
navWebViewTextColor    | bool|服务条款页面标题栏的字体颜色|0xFF000000
navWebViewTextSize    | bool|服务条款页面标题栏的字体大小|17


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


### isAvailable

预取号拿到的token是否还在有效期

```
bool isAvailable = oneLoginPlugin.isAvailable();
```


### destroy

销毁对象(仅Android有效)。当不再需要使用 OneLogin 时，调用此接口销毁 OneLogin Android SDK，避免内存泄漏问题。若销毁后需要重新使用插件，再创建一个 GtOneloginFlutterPlugin 实例即可。

```dart
oneLoginPlugin.destroy();
```

### renewPreGetToken
重新预取号，可在退出登录时调用此方法，加快下次拉起授权页的速度

```dart
oneLoginPlugin.renewPreGetToken();
```

### deletePreResultCache
删除预取号缓存

```dart
oneLoginPlugin.deletePreResultCache();
```

### setProtocolCheckState
设置隐私条款勾选框状态

```dart
oneLoginPlugin.setProtocolCheckState(true);
```

### getCurrentNetworkInfo
获取当前网络类型

```dart
oneLoginPlugin.getCurrentNetworkInfo()
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
    onAuthDialogDisagreeBtnClick: (_){
      debugPrint(tag + "点击了授权弹窗不同意按钮");
    }
);
```