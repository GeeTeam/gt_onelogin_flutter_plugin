//
//  OLUIConfigure.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/3.
//

import Foundation
import OneLoginSDK
import UIKit

let iosLog = "| Geetest | OneLogin iOS | "

class OLUIConfiguration {
    
    //Only for iOS 授权页面支持的横竖屏方向（portrait or landscape）
    var supportedinterfaceOrientations:UIInterfaceOrientationMask?
      //Only for iOS 授权页面界面样式
    var userinterfaceStyle:Int?
    //  UIUserInterfaceStyle

      ///--------------弹窗----------------
      //是否是弹框样式
    var isDialogStyle:Bool?
      //弹窗size，位置
    var dialogRect:OLRect?
      //弹窗圆角
    var dialogCornersRadius:Double?
      //是否需要通过点击弹窗的背景区域以关闭授权页面
    var isDialogClosedWhenTapBackground:Bool?

      ///--------------多语言配置----------------
    var languageType: Int?
    
      ///--------------背景----------------
      //设置背景图片
    var authViewBackgroundImage:UIImage?
      //Only for iOS 设置背景颜色
    var backgroundColor:UIColor?
    
    ///--------------状态栏----------------
      //状态栏样式
    var statusBarStyle:UIStatusBarStyle?

      ///--------------标题栏，虚拟按键----------------
      // 导航栏标题距离屏幕左边的间距。默认为36，隐私条款导航栏保持一致
    var navTextMargin: Double?
      //标题栏：颜色
    var navigationBarColor:UIColor?
      //标题栏：隐藏
    var navHidden:Bool?
/*     //标题栏：文本
    var navText:String?
      //标题栏：字体颜色
    var navTextColor:UIColor?
      //标题栏：字体大小
    var navTextSize:Int?
 */
    var navAttributedString:NSAttributedString?
      //返回按钮图片
    var navBackImage:UIImage?
      //返回按钮图片 size 位置
    var navBackImageRect:OLRect?
      //返回按钮是否隐藏
    var navBackImageHidden:Bool?
    
    ///--------------logo----------------
      //logo 图片
    var logoImage:UIImage?
      //logo size 位置
    var logoImageRect:OLRect?
      //logo：是否隐藏
    var logoImageHidden:Bool?
      //Only for iOS logo圆角，默认为0
    var logoCornerRadius:Double?

      ///--------------号码----------------
      //号码栏字体颜色
    var numberColor:UIColor?
      //号码栏字体大小
    var numberSize:Int?
      //号码栏 size 位置
    var numberRect:OLRect?
    
    ///--------------切换账号按钮----------------
      // 切换账号按钮文本
    var switchButtonText:String?
      // 切换账号按钮字体颜色
    var switchButtonColor:UIColor?
      // 切换账号按钮字体大小
    var switchTextSize:Int?
      // 切换账号按钮是否隐藏
    var switchButtonHidden:Bool?
      //Only for iOS  切换账号按钮背景颜色
    var switchButtonBackgroundColor:UIColor?
      // 切换账号按钮size  位置
    var switchButtonRect: OLRect?
    
    ///--------------一键登录按钮----------------
      //[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
    var authButtonImages:[String]?
      //授权按钮的size 位置
    var authButtonRect:OLRect?
      //Only for iOS 授权按钮圆角
    var authButtonCornerRadius:Double?
//      //授权按钮文字
//    var authzBtnText:String?
//      //授权按钮文字颜色
//    var authzBtnColor:UIColor?
//      //授权按钮字体大小
//    var authzBtnTextSize:int?
    var authBtnAttString:NSAttributedString?
    
    ///--------------SLogan----------------
      // Only for iOS slogan 文案
    var sloganText:String?
      // slogan文字颜色
    var sloganColor:UIColor?
      // slogan字体大小
    var sloganSize:Int?
      //slogan size 位置
    var sloganRect:OLRect?
    
    ///--------------隐私条款----------------
      //隐私条款 位置及大小
    var termsRect:OLRect?
      //隐私条款基础文字颜色
    var termTextColor:UIColor?
      //隐私条款文本：隐私条款协议文字颜色
//    var termsClauseColor:UIColor?
//      //隐私条款文本：隐私条款字体大小
//    var termsClauseTextSize:Int?
//      //隐私条款文本：隐私条款文字行间距
//    var termsLineSpacingExtra:Double?
//      //隐私条款文本：隐私条款文字行间距的倍数
//    var termsLineSpacingMultiplier:Double?
    var termsClauseAttributes:[NSAttributedString.Key:Any]?
      //隐私条款文本：隐私条款名称是否隐藏书名号
    var termsBookTitleMarkHidden:Bool?
      //未同意隐私条款的提示文字
    var termsUncheckedToastText:String?
     //是否显示未同意隐私条款的提示文字
    var termsUncheckedEnableToast:Bool?
      //隐私条款对象数组
    var terms:[OLPrivacyTermItem]?
      //除隐私条款外的其他文案,连接字符串
    var auxiliaryPrivacyWords:[String]?

      //隐私条款CheckBox：未选中下按钮的图片地址
    var uncheckedImage:UIImage?
      //隐私条款CheckBox：选中下按钮的图片地址
    var  checkedImage:UIImage?
      //隐私条款CheckBox：选择框是否默认勾选
    var defaultCheckBoxState:Bool?
    //隐私条款勾选框大小及位置，请不要设置勾选框的横向偏移，整体隐私条款的横向偏移，请通过 termsRect 设置
    var checkBoxRect:OLRect?

      //Only for iOS 服务条款页面导航栏是否隐藏
    var webNaviHidden:Bool?
      //Only for iOS 服务条款页面导航的背景颜色
    var webNaviBgColor:UIColor?
      //隐私条款页面标题栏文字
//    var navWebViewText:String?
//      //隐私条款页面标题栏字体颜色
//    var navWebViewTextColor:UIColor?
//      //隐私条款页面标题栏字体大小
//    var navWebViewTextSize:Int?
    var navWebViewAttString: NSAttributedString?
    var protocolShakeStyle: Int?
    
    ///--------------授权弹窗----------------
    //未勾选同意协议时是否弹出授权弹窗
    var willAuthDialogDisplay:Bool?
    //点击授权弹窗外是否关闭授权弹窗
    var canCloseAuthDialogFromTapGesture:Bool?
    //授权弹窗宽、高、起始点位置
    var authDialogRect:OLRect?
    //授权弹窗是否显示在屏幕下方
    var isAuthDialogBottom:Bool?
    //授权弹窗背景颜色
    var authDialogBgColor:UIColor?
    //授权弹窗标题文字
    var authDialogTitleText:String?
    //授权弹窗标题颜色
    var authDialogTitleColor:UIColor?
    //授权弹窗字体大小
    var authDialogTitleSize:Int?
    //授权弹窗富文本字体大小
    var authDialogContentFontSize:Int?
    //授权弹窗不同意按钮文字
    var authDialogDisagreeBtnText:String?
    //授权弹窗不同意按钮字体大小
    var authDialogDisagreeBtnFontSize:Int?
    //授权弹窗不同意按钮文字颜色
    var authDialogDisagreeBtnColor:UIColor?
    //授权弹窗不同意按钮的背景图片, @[正常状态的背景图片, 高亮状态的背景图片]。默认正常状态为灰色, 高亮状态为深灰色。
    var authDialogDisagreeBtnImages:[String]?
    //授权弹窗同意按钮文字
    var authDialogAgreeBtnText:String?
    //授权弹窗同意按钮字体大小
    var authDialogAgreeBtnFontSize:Int?
    //授权弹窗同意按钮文字颜色
    var authDialogAgreeBtnColor:UIColor?
    //授权弹窗同意按钮的背景图片, @[正常状态的背景图片, 高亮状态的背景图片]。默认正常状态为蓝色纯色, 高亮状态为灰蓝色。
    var authDialogAgreeBtnImages:[String]?
    //授权弹窗圆角，默认为10。
    var authDialogCornerRadius:Double?
    // 是否自定义授权弹窗
    var isCustomDisabledAuthAction:Bool?
    
    
    ///--------------自定义组件点击----------------
    var customWidgets:[OLCustomWidget]?
    var clickCustomWidgetsBlock: ((_ viewId:String) -> Void)?
    
    
    init(dict:[String:Any]) {
        if let orientationsIndex = dict[OLConstant.supportedinterfaceOrientations] as? UInt,(orientationsIndex == 0 || orientationsIndex == 1) {
            if orientationsIndex == 0 {
                supportedinterfaceOrientations = .portrait
            }else{
                supportedinterfaceOrientations = .landscape
            }
        }
        if let userinterfaceStyleIndex = dict[OLConstant.userinterfaceStyle] as? Int {
            self.userinterfaceStyle = userinterfaceStyleIndex
        }
        self.isDialogStyle = DictParseUtil.parseBool(dict: dict, key: OLConstant.isDialogStyle)
        self.dialogRect = parseRect(dict: dict, key: OLConstant.dialogRect)
        self.dialogCornersRadius = dict[OLConstant.dialogCornersRadius] as? Double
        self.dialogCornersRadius = DictParseUtil.parseDouble(dict: dict, key: OLConstant.dialogCornersRadius)
        self.isDialogClosedWhenTapBackground = DictParseUtil.parseBool(dict: dict, key: OLConstant.isDialogClosedWhenTapBackground)
        self.languageType = DictParseUtil.parseInt(dict: dict, key: OLConstant.languageType)
        self.authViewBackgroundImage = DictParseUtil.parseIntoAssetsImage(dict[OLConstant.authViewBackgroundImage])
        self.backgroundColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.backgroundColor)
        if let statusBarStyleIndex = dict[OLConstant.statusBarStyle] as? Int{
            if statusBarStyleIndex < 2,let statusBarStyle = UIStatusBarStyle(rawValue: statusBarStyleIndex) {
                self.statusBarStyle = statusBarStyle
            }else{
                if #available(iOS 13.0, *) {
                    self.statusBarStyle = UIStatusBarStyle.darkContent
                }
            }
            
        }
        self.navTextMargin = DictParseUtil.parseDouble(dict: dict, key: OLConstant.navTextMargin)
        self.navigationBarColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.navigationBarColor)
        self.navHidden = DictParseUtil.parseBool(dict: dict, key: OLConstant.navHidden)
        self.navAttributedString = NSAttributedString.textFontColorString(color: DictParseUtil.parseColor(dict: dict, key: OLConstant.navTextColor), font: DictParseUtil.parseInt(dict: dict, key: OLConstant.navTextSize), text: (dict[OLConstant.navText] as? String), lineSpace: nil, lineSpacingMultiplier: nil)
        self.navBackImage = DictParseUtil.parseIntoAssetsImage(dict[OLConstant.navBackImage])
        self.navBackImageRect = parseRect(dict: dict, key: OLConstant.navBackImageRect)
        self.navBackImageHidden = DictParseUtil.parseBool(dict: dict, key: OLConstant.navBackImageHidden)
        self.logoImage = DictParseUtil.parseIntoAssetsImage(dict[OLConstant.logoImage])
        self.logoImageRect = parseRect(dict: dict, key: OLConstant.logoImageRect)
        self.logoImageHidden = DictParseUtil.parseBool(dict: dict, key: OLConstant.logoImageHidden)
        self.logoCornerRadius = DictParseUtil.parseDouble(dict: dict, key: OLConstant.logoCornerRadius)
        self.numberColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.numberColor)
        self.numberSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.numberSize)
        self.numberRect = parseRect(dict: dict, key: OLConstant.numberRect)
        self.switchButtonText = DictParseUtil.parseString(dict: dict, key: OLConstant.switchButtonText)
        self.switchTextSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.switchTextSize)
        self.switchButtonColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.switchButtonColor)
        self.switchButtonHidden = DictParseUtil.parseBool(dict: dict, key: OLConstant.switchButtonHidden)
        self.switchButtonRect = parseRect(dict: dict, key: OLConstant.switchButtonRect)
        self.authButtonImages = dict[OLConstant.authButtonImages] as? [String]
        self.authButtonRect = parseRect(dict: dict, key: OLConstant.authButtonRect)
        self.authButtonCornerRadius = DictParseUtil.parseDouble(dict: dict, key: OLConstant.authButtonCornerRadius)
        self.authBtnAttString = NSAttributedString.textFontColorString(color: DictParseUtil.parseColor(dict: dict, key: OLConstant.authBtnColor), font: DictParseUtil.parseInt(dict: dict, key: OLConstant.authBtnTextSize), text: (dict[OLConstant.authBtnText] as? String), lineSpace: nil, lineSpacingMultiplier: nil)
        self.sloganText = DictParseUtil.parseString(dict: dict, key: OLConstant.sloganText)
        self.sloganSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.sloganSize)
        self.sloganColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.sloganColor)
        self.sloganRect = parseRect(dict: dict, key: OLConstant.sloganRect)
        self.termsRect = parseRect(dict: dict, key: OLConstant.termsRect)
        self.termTextColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.termTextColor)
        self.termsClauseAttributes = DictParseUtil.parseAttributes(dict: dict, colorKey: OLConstant.termsClauseColor, OLConstant.termsClauseTextSize, OLConstant.termsLineSpacingExtra, OLConstant.termsLineSpacingMultiplier)
        self.termsBookTitleMarkHidden = DictParseUtil.parseBool(dict: dict, key: OLConstant.termsBookTitleMarkHidden)
        self.termsUncheckedToastText = DictParseUtil.parseString(dict: dict, key: OLConstant.termsUncheckedToastText)
        self.termsUncheckedEnableToast = DictParseUtil.parseBool(dict: dict, key: OLConstant.termsUncheckedEnableToast)
        self.terms = DictParseUtil.parsePrivacyTermItem(dict: dict, key: OLConstant.terms)
        self.auxiliaryPrivacyWords = dict[OLConstant.auxiliaryPrivacyWords] as? [String]
        self.uncheckedImage = DictParseUtil.parseIntoAssetsImage(dict[OLConstant.uncheckedImage])
        self.checkedImage = DictParseUtil.parseIntoAssetsImage(dict[OLConstant.checkedImage])
        self.defaultCheckBoxState = DictParseUtil.parseBool(dict: dict, key: OLConstant.defaultCheckBoxState)
        self.webNaviHidden = DictParseUtil.parseBool(dict: dict, key: OLConstant.webNaviHidden)
        self.webNaviBgColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.webNaviBgColor)
        self.navWebViewAttString = NSAttributedString.textFontColorString(color: DictParseUtil.parseColor(dict: dict, key: OLConstant.navWebViewTextColor), font: DictParseUtil.parseInt(dict: dict, key: OLConstant.navWebViewTextSize), text: (dict[OLConstant.navWebViewText] as? String), lineSpace: nil, lineSpacingMultiplier: nil)
        self.protocolShakeStyle = DictParseUtil.parseInt(dict: dict, key: OLConstant.protocolShakeStyle)

        self.checkBoxRect = parseRect(dict: dict, key: OLConstant.checkBoxRect)
        self.willAuthDialogDisplay = DictParseUtil.parseBool(dict: dict, key: OLConstant.willAuthDialogDisplay)
        self.canCloseAuthDialogFromTapGesture = DictParseUtil.parseBool(dict: dict, key: OLConstant.canCloseAuthDialogFromTapGesture)
        self.authDialogRect = parseRect(dict: dict, key: OLConstant.authDialogRect)
        self.isAuthDialogBottom = DictParseUtil.parseBool(dict: dict, key: OLConstant.isAuthDialogBottom)
        self.authDialogBgColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.authDialogBgColor)
        self.authDialogTitleText = DictParseUtil.parseString(dict: dict, key: OLConstant.authDialogTitleText)
        self.authDialogTitleColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.authDialogTitleColor)
        self.authDialogTitleSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.authDialogTitleSize)
        self.authDialogContentFontSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.authDialogContentFontSize)
        self.authDialogDisagreeBtnText = DictParseUtil.parseString(dict: dict, key: OLConstant.authDialogDisagreeBtnText)
        self.authDialogDisagreeBtnFontSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.authDialogDisagreeBtnFontSize)
        self.authDialogDisagreeBtnColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.authDialogDisagreeBtnColor)
        self.authDialogDisagreeBtnImages = dict[OLConstant.authDialogDisagreeBtnImages] as? [String]
        self.authDialogAgreeBtnText = DictParseUtil.parseString(dict: dict, key: OLConstant.authDialogAgreeBtnText)
        self.authDialogAgreeBtnFontSize = DictParseUtil.parseInt(dict: dict, key: OLConstant.authDialogAgreeBtnFontSize)
        self.authDialogAgreeBtnColor = DictParseUtil.parseColor(dict: dict, key: OLConstant.authDialogAgreeBtnColor)
        self.authDialogAgreeBtnImages = dict[OLConstant.authDialogAgreeBtnImages] as? [String]
        self.authDialogCornerRadius = DictParseUtil.parseDouble(dict: dict, key: OLConstant.authDialogCornerRadius)
        
        if let customWidgetsParam = dict[OLConstant.customWidgetsParameter] as? Array<[String:Any]> {
            let customWidgets = customWidgetsParam.compactMap { dict in
                return OLCustomWidget(dict: dict)
            }
            self.customWidgets = customWidgets
        }
        
    }
    
    
}

extension OLUIConfiguration{
//    转成SDK对应model
    func toAuthViewModel() -> OLAuthViewModel {
        let authViewModel = OLAuthViewModel()
        if let supportedInterfaceOrientations = supportedinterfaceOrientations {
            
            authViewModel.supportedInterfaceOrientations = supportedInterfaceOrientations
        }
        if #available(iOS 12.0, *),let userinterfaceStyleIndex = userinterfaceStyle,let _ = UIUserInterfaceStyle(rawValue: userinterfaceStyleIndex) {
            authViewModel.userInterfaceStyle = NSNumber(value: userinterfaceStyleIndex)
        }
        if let isDialogStyle = isDialogStyle {
            authViewModel.isPopup = isDialogStyle
        }
        if let popRect = dialogRect {
            authViewModel.popupRect = popRect
        }
        if let dialogCornersRadius = dialogCornersRadius {
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
        if let dialogCornersRadius = dialogCornersRadius {
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
        if let isDialogClosedWhenTapBackground = isDialogClosedWhenTapBackground {
            authViewModel.canClosePopupFromTapGesture = isDialogClosedWhenTapBackground
        }
        if let languageType = languageType, languageType > 0, languageType < 3 {
            authViewModel.languageType = OLLanguageType.init(rawValue: languageType)!
        }
        authViewModel.backgroundImage = authViewBackgroundImage
        authViewModel.backgroundColor = backgroundColor
        if let statusBarStyle = statusBarStyle {
            authViewModel.statusBarStyle = statusBarStyle
        }
        if let navTextMargin = navTextMargin {
            authViewModel.navTextMargin = navTextMargin
        }
        authViewModel.naviBgColor = navigationBarColor
        if let navHidden = navHidden {
            authViewModel.naviHidden = navHidden
        }
        authViewModel.naviTitle = navAttributedString
        authViewModel.naviBackImage = navBackImage
        if let navBackImageRect = navBackImageRect {
            authViewModel.backButtonRect = navBackImageRect
        }
        if let navBackImageHidden = navBackImageHidden {
            authViewModel.backButtonHidden = navBackImageHidden
        }
        authViewModel.appLogo = logoImage
        if let logoImageRect = logoImageRect {
            authViewModel.logoRect = logoImageRect
        }
        if let logoImageHidden = logoImageHidden {
            authViewModel.logoHidden = logoImageHidden
        }
        if let logoCornerRadius = logoCornerRadius {
            authViewModel.logoCornerRadius = logoCornerRadius
        }
        authViewModel.phoneNumColor = numberColor
        if let numberSize = numberSize {
            authViewModel.phoneNumFont = UIFont.systemFont(ofSize: CGFloat(numberSize))
        }
        if let numberRect = numberRect {
            authViewModel.phoneNumRect = numberRect
        }
        authViewModel.switchButtonBackgroundColor = switchButtonBackgroundColor
        if let switchButtonRect = switchButtonRect {
            authViewModel.switchButtonRect = switchButtonRect
        }
        if let switchButtonHidden = switchButtonHidden {
            authViewModel.switchButtonHidden = switchButtonHidden
        }
        authViewModel.switchButtonText = switchButtonText
        authViewModel.switchButtonColor = switchButtonColor
        if let switchTextSize = switchTextSize {
            authViewModel.switchButtonFont = UIFont.systemFont(ofSize: CGFloat(switchTextSize))
        }
        authViewModel.authButtonTitle = authBtnAttString
        if let imagesString = authButtonImages,!imagesString.isEmpty {
            let images = imagesString.compactMap({ (string) in
                return DictParseUtil.parseIntoAssetsImage(string)
            })
            if !images.isEmpty,images.count <= 3  {
                authViewModel.authButtonImages = images
            }
        }
        if let authButtonRect = authButtonRect {
            authViewModel.authButtonRect = authButtonRect
        }
        if let authButtonCornerRadius = authButtonCornerRadius {
            authViewModel.authButtonCornerRadius = authButtonCornerRadius
        }
        authViewModel.sloganText = sloganText
        if let sloganColor = sloganColor {
            authViewModel.sloganTextColor = sloganColor
        }
        if let sloganTextFont = sloganSize  {
            authViewModel.sloganTextFont = UIFont.systemFont(ofSize: CGFloat(sloganTextFont))
        }
        if let sloganRect = sloganRect {
            authViewModel.sloganRect = sloganRect
        }
        if let termsRect = termsRect {
            authViewModel.termsRect = termsRect
        }
        if let termTextColor = termTextColor {
            authViewModel.termTextColor = termTextColor
        }
        authViewModel.privacyTermsAttributes = termsClauseAttributes
        if let termsBookTitleMarkHidden = termsBookTitleMarkHidden {
            authViewModel.hasQuotationMarkOnCarrierProtocol = !termsBookTitleMarkHidden
        }
        authViewModel.notCheckProtocolHint = termsUncheckedToastText
        authViewModel.additionalPrivacyTerms = terms
        if let termsUncheckedEnableToast = termsUncheckedEnableToast, termsUncheckedEnableToast==false {
            authViewModel.hintBlock = {}
        }
        authViewModel.auxiliaryPrivacyWords = auxiliaryPrivacyWords
        authViewModel.uncheckedImage = uncheckedImage
        authViewModel.checkedImage = checkedImage
        if let defaultCheckBoxState = defaultCheckBoxState {
            authViewModel.defaultCheckBoxState = defaultCheckBoxState
        }
        if let webNaviHidden = webNaviHidden {
            authViewModel.webNaviHidden = webNaviHidden
        }
        if let webNaviBgColor = webNaviBgColor {
            authViewModel.webNaviBgColor = webNaviBgColor
        }
        authViewModel.webNaviTitle = navWebViewAttString
        if let protocolShakeStyle = protocolShakeStyle, protocolShakeStyle > 0, protocolShakeStyle < 3 {
            authViewModel.shakeStyle = OLNotCheckProtocolShakeStyle.init(rawValue: protocolShakeStyle)!
        }

        if let checkBoxRect = checkBoxRect {
            authViewModel.checkBoxRect = checkBoxRect
        }
        
        if let willAuthDialogDisplay = willAuthDialogDisplay  {
            authViewModel.willAuthDialogDisplay = willAuthDialogDisplay
        }
        if let canCloseAuthDialogFromTapGesture = canCloseAuthDialogFromTapGesture  {
            authViewModel.canCloseAuthDialogFromTapGesture = canCloseAuthDialogFromTapGesture
        }
        if let authDialogRect = authDialogRect {
            authViewModel.authDialogRect = authDialogRect
        }
        if let isAuthDialogBottom = isAuthDialogBottom {
            authViewModel.isAuthDialogBottom = isAuthDialogBottom
        }
        authViewModel.authDialogBgColor = authDialogBgColor
        authViewModel.authDialogTitleText = authDialogTitleText
        authViewModel.authDialogTitleColor = authDialogTitleColor
        if let authDialogTitleSize = authDialogTitleSize {
            authViewModel.authDialogTitleFont = UIFont.systemFont(ofSize: CGFloat(authDialogTitleSize))
        }
        if let authDialogContentFontSize = authDialogContentFontSize {
            authViewModel.authDialogContentFont = UIFont.systemFont(ofSize:CGFloat(authDialogContentFontSize))
        }
        authViewModel.authDialogDisagreeBtnText = authDialogDisagreeBtnText
        if let authDialogDisagreeBtnFontSize = authDialogDisagreeBtnFontSize {
            authViewModel.authDialogDisagreeBtnFont = UIFont.systemFont(ofSize:CGFloat(authDialogDisagreeBtnFontSize))
        }
        authViewModel.authDialogDisagreeBtnColor = authDialogDisagreeBtnColor
        if let imagesString = authDialogDisagreeBtnImages,!imagesString.isEmpty {
            let images = imagesString.compactMap({ (string) in
                return DictParseUtil.parseIntoAssetsImage(string)
            })
            if !images.isEmpty,images.count < 3  {
                authViewModel.authDialogDisagreeBtnImages = images
            }
        }
        authViewModel.authDialogAgreeBtnText = authDialogAgreeBtnText
        if let authDialogAgreeBtnFontSize = authDialogAgreeBtnFontSize {
            authViewModel.authDialogAgreeBtnFont = UIFont.systemFont(ofSize:CGFloat(authDialogAgreeBtnFontSize))
        }
        authViewModel.authDialogAgreeBtnColor = authDialogAgreeBtnColor
        if let imagesString = authDialogAgreeBtnImages,!imagesString.isEmpty {
            let images = imagesString.compactMap({ (string) in
                return DictParseUtil.parseIntoAssetsImage(string)
            })
            if !images.isEmpty,images.count < 3  {
                authViewModel.authDialogAgreeBtnImages = images
            }
        }
        if let authDialogCornerRadius = authDialogCornerRadius {
            authViewModel.authDialogCornerRadius = authDialogCornerRadius
        }
        
        if let customWidgets = customWidgets {
            authViewModel.customUIHandler = { (customAreaView: UIView) in
                for widget in customWidgets {
                    if let view = widget.toUIView(target: self, action: #selector(self.customWidgetsClick)){
                        customAreaView.addSubview(view)
                    }
                }
            }
        }
        return authViewModel
    }
    
    @objc func customWidgetsClick(sender:UIButton) {
        if let clickCustomWidgetsBlock = clickCustomWidgetsBlock {
            clickCustomWidgetsBlock(sender.viewId)
        }
    }
}


//数据解析
extension OLUIConfiguration{
    
    func parseRect(dict:[String:Any],key:String) -> OLRect {
        let rect = DictParseUtil.parseCGRect(dict: dict, key: key)
        var isForcePortrait:Bool?
        if let supportOrientation = supportedinterfaceOrientations {
            isForcePortrait = supportOrientation == .portrait
        }
        return rect.olRect(isForcePortrait)
    }
    
}

struct DictParseUtil {
    static func parseBool(dict:[String:Any],key:String) -> Bool? {
        return dict[key] as? Bool
    }
    
    static func parseDouble(dict:[String:Any],key:String) -> Double? {
        return dict[key] as? Double
    }
    
    static func parseInt(dict:[String:Any],key:String)->Int? {
        return dict[key] as? Int
    }
    static func parseColor(dict:[String:Any],key:String) -> UIColor? {
        if let colorString = dict[key] as? String {
            return UIColor(hexString: colorString)
        }
        return nil
    }
    
    static func parseString(dict:[String:Any],key:String) -> String? {
        return dict[key] as? String
    }
    
    static func parseAttributes(dict:[String:Any],colorKey:String?,_ textSizeKey:String?,_ lineSpacingKey:String?,_ lineSpacingMultiplierKey:String?)-> [NSAttributedString.Key:Any]? {
        var attributes : [NSAttributedString.Key:Any] = [:]
        if let key = colorKey,let color = parseColor(dict: dict, key: key) {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        if let  key = textSizeKey,let textSize = parseInt(dict: dict, key: key) {
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize:CGFloat(textSize))
        }
        if lineSpacingKey != nil || lineSpacingMultiplierKey != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            if let key = lineSpacingKey,let lineSpacing = parseDouble(dict: dict, key: key) {
                paragraphStyle.lineSpacing = lineSpacing
            }
            if let key = lineSpacingMultiplierKey,let lineSpacingMultiplier = parseDouble(dict: dict, key: key) {
                paragraphStyle.lineHeightMultiple = lineSpacingMultiplier
            }
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        return attributes.isEmpty ? nil : attributes
    }
    
    static func parseIntoAssetsImage(_ value:Any?) -> UIImage? {
        if let imageString = value as? String,!imageString.isEmpty{
            if let image =  UIImage(named: imageString) {
                return image
            }else{
                debugPrint(iosLog+"\(imageString)该资源路径不存在")
                return nil
            }
        }
        return nil
    }
    
    static func parseCGRect(dict:[String:Any],key:String) -> CGRect {
        var rect = CGRect.zero
        if let rectDict = dict[key] as? [String:Double] {
            var width:Double = 0
            var height:Double = 0
            var x:Double = 0
            var y:Double = 0
            if let w = rectDict[OLConstant.rectWidth] {
                width = w
            }
            if let h = rectDict[OLConstant.rectHeight] {
                height = h
            }
            if let _x = rectDict[OLConstant.rectX] {
                x = _x
            }
            if let _y = rectDict[OLConstant.rectY] {
                y = _y
            }
            rect = CGRect(x: x, y: y, width: width, height: height)
        }
        return rect
    }
    
    static func parsePrivacyTermItem(dict:[String:Any],key:String) -> [OLPrivacyTermItem]? {
        if let privacyTerms = dict[key] as? [[String:String]],!privacyTerms.isEmpty {
            return privacyTerms.compactMap { item -> OLPrivacyTermItem? in
                guard let title = item[OLConstant.termsItemTitle],!title.isEmpty,
                      let urlString = item[OLConstant.termsItemUrl],!urlString.isEmpty,
                      let url = URL(string: urlString) else {
                    return nil
                }
                return OLPrivacyTermItem(title: title, linkURL: url)
            }
        }
        return nil
    }
}
