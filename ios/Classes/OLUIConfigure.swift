//
//  OLUIConfigure.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/3.
//

import Foundation
import OneLoginSDK
import UIKit


class OLUIConfigure{
    let iosLog = "| Geetest | OneLogin iOS | "
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

      ///--------------背景----------------
      //设置背景图片
    var authViewBackgroundImage:UIImage?
      //Only for iOS 设置背景颜色
    var backgroundColor:UIColor?
    
    ///--------------状态栏----------------
      //状态栏样式
    var statusBarStyle:UIStatusBarStyle?

      ///--------------标题栏，虚拟按键----------------
      //标题栏：颜色
    var navigationBarColor:UIColor?
      //标题栏：隐藏
    var navHidden:Bool?
/*     //标题栏：文本
    var navText:String?;
      //标题栏：字体颜色
    var navTextColor:UIColor?;
      //标题栏：字体大小
    var navTextSize:Int?;
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
    var logoImageRect:OLRect? ;
      //logo：是否隐藏
    var logoImageHidden:Bool?;
      //Only for iOS logo圆角，默认为0
    var logoCornerRadius:Double?;

      ///--------------号码----------------
      //号码栏字体颜色
    var numberColor:UIColor?;
      //号码栏字体大小
    var numberSize:Int?;
      //号码栏 size 位置
    var numberRect:OLRect? ;
    
    ///--------------切换账号按钮----------------
      // 切换账号按钮文本
    var switchButtonText:String?;
      // 切换账号按钮字体颜色
    var switchButtonColor:UIColor?;
      // 切换账号按钮字体大小
    var switchTextSize:Int?;
      // 切换账号按钮是否隐藏
    var switchButtonHidden:Bool?;
      //Only for iOS  切换账号按钮背景颜色
    var switchButtonBackgroundColor:UIColor?
      // 切换账号按钮size  位置
    var switchButtonRect: OLRect? ;
    
    ///--------------一键登录按钮----------------
      //[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
    var authButtonImages:[String]?;
      //授权按钮的size 位置
    var authButtonRect:OLRect?;
      //Only for iOS 授权按钮圆角
    var authButtonCornerRadius:Double?;
//      //授权按钮文字
//    var authzBtnText:String? ;
//      //授权按钮文字颜色
//    var authzBtnColor:UIColor?;
//      //授权按钮字体大小
//    var authzBtnTextSize:int? ;
    var authBtnAttString:NSAttributedString?
    
    ///--------------SLogan----------------
      // Only for iOS slogan 文案
    var sloganText:String?;
      // slogan文字颜色
    var sloganColor:UIColor? ;
      // slogan字体大小
    var sloganSize:Int?;
      //slogan size 位置
    var sloganRect:OLRect?;
    
    ///--------------隐私条款----------------
      //隐私条款 位置及大小
    var termsRect:OLRect?;
      //隐私条款基础文字颜色
    var termTextColor:UIColor?;
      //隐私条款文本：隐私条款协议文字颜色
//    var termsClauseColor:UIColor?;
//      //隐私条款文本：隐私条款字体大小
//    var termsClauseTextSize:Int?;
//      //隐私条款文本：隐私条款文字行间距
//    var termsLineSpacingExtra:Double?;
//      //隐私条款文本：隐私条款文字行间距的倍数
//    var termsLineSpacingMultiplier:Double?;
    var termsClauseAttributes:[NSAttributedString.Key:Any]?
      //隐私条款文本：隐私条款名称是否显示书名号
    var termsBookTitleMarkHidden:Bool?;
      //未同意隐私条款的提示文字
    var termsUncheckedToastText:String?;
      //服务条款文案对齐方式
    var termsAlignmentIOS:Int?;
//      int? termsAlignmentAndroid;
      //隐私条款对象数组
    var terms:[OLPrivacyTermItem]?;
      //除隐私条款外的其他文案,连接字符串
    var auxiliaryPrivacyWords:[String]?;

      //隐私条款CheckBox：未选中下按钮的图片地址
    var uncheckedImage:UIImage?;
      //隐私条款CheckBox：选中下按钮的图片地址
    var  checkedImage:UIImage?;
      //隐私条款CheckBox：选择框是否默认勾选
    var defaultCheckBoxState:Bool?;
      //隐私条款CheckBox size及位置
    var checkBoxRect:OLRect?;

      //Only for iOS 服务条款页面导航栏是否隐藏
    var webNaviHidden:Bool?
      //Only for iOS 服务条款页面导航的背景颜色
    var webNaviBgColor:UIColor?;
      //隐私条款页面标题栏文字
//    var navWebViewText:String?;
//      //隐私条款页面标题栏字体颜色
//    var navWebViewTextColor:UIColor?;
//      //隐私条款页面标题栏字体大小
//    var navWebViewTextSize:Int?;
    var navWebViewAttString : NSAttributedString?

    init(dict:[String:Any]) {
        if let orientationsIndex = dict[OLConstant.supportedinterfaceOrientations] as? UInt,(orientationsIndex == 0 || orientationsIndex == 1) {
            if orientationsIndex == 0 {
                supportedinterfaceOrientations = .portrait
            }else{
                supportedinterfaceOrientations = .landscape
            }
        }
        if let userinterfaceStyleIndex = dict[OLConstant.supportedinterfaceOrientations] as? Int {
            self.userinterfaceStyle = userinterfaceStyleIndex;
        }
        self.isDialogStyle = parseBool(dict: dict, key: OLConstant.isDialogStyle)
        self.dialogRect = parseRect(dict: dict, key: OLConstant.dialogRect)
        self.dialogCornersRadius = dict[OLConstant.dialogCornersRadius] as? Double
        self.dialogCornersRadius = parseDouble(dict: dict, key: OLConstant.dialogCornersRadius)
        self.authViewBackgroundImage = parseIntoAssetsImage(dict[OLConstant.authViewBackgroundImage])
        self.backgroundColor = parseColor(dict: dict, key: OLConstant.backgroundColor)
        if let statusBarStyleIndex = dict[OLConstant.statusBarStyle] as? Int,
           let statusBarStyle = UIStatusBarStyle(rawValue: statusBarStyleIndex){
            self.statusBarStyle = statusBarStyle
        }
        self.navigationBarColor = parseColor(dict: dict, key: OLConstant.navigationBarColor)
        self.navHidden = parseBool(dict: dict, key: OLConstant.navHidden)
        self.navAttributedString = NSAttributedString.textFontColorString(color: dict[OLConstant.navTextColor] as? UIColor, font: dict[OLConstant.navTextSize] as? Int, text: (dict[OLConstant.navText] as? String), lineSpace: nil, lineSpacingMultiplier: nil)
        self.navBackImage = parseIntoAssetsImage(dict[OLConstant.navBackImage])
        self.navBackImageRect = parseRect(dict: dict, key: OLConstant.navBackImageRect)
        self.navBackImageHidden = parseBool(dict: dict, key: OLConstant.navBackImageHidden)
        self.logoImage = parseIntoAssetsImage(dict[OLConstant.logoImage])
        self.logoImageRect = parseRect(dict: dict, key: OLConstant.logoImageRect)
        self.logoImageHidden = parseBool(dict: dict, key: OLConstant.logoImageHidden)
        self.logoCornerRadius = parseDouble(dict: dict, key: OLConstant.logoCornerRadius)
        self.numberColor = parseColor(dict: dict, key: OLConstant.numberColor)
        self.numberSize = parseInt(dict: dict, key: OLConstant.numberSize)
        self.numberRect = parseRect(dict: dict, key: OLConstant.numberRect)
        self.switchButtonText = parseString(dict: dict, key: OLConstant.switchButtonText)
        self.switchTextSize = parseInt(dict: dict, key: OLConstant.switchTextSize)
        self.switchButtonColor = parseColor(dict: dict, key: OLConstant.switchButtonColor)
        self.switchButtonHidden = parseBool(dict: dict, key: OLConstant.switchButtonHidden)
        self.switchButtonRect = parseRect(dict: dict, key: OLConstant.switchButtonRect)
        self.authButtonImages = dict[OLConstant.authButtonImages] as? [String]
        self.authButtonRect = parseRect(dict: dict, key: OLConstant.authButtonRect)
        self.authButtonCornerRadius = parseDouble(dict: dict, key: OLConstant.authButtonCornerRadius)
        self.authBtnAttString = NSAttributedString.textFontColorString(color: dict[OLConstant.authBtnColor] as? UIColor, font: dict[OLConstant.authBtnColor] as? Int, text: (dict[OLConstant.authBtnText] as? String), lineSpace: nil, lineSpacingMultiplier: nil)
        self.sloganText = parseString(dict: dict, key: OLConstant.sloganText)
        self.sloganSize = parseInt(dict: dict, key: OLConstant.sloganSize)
        self.sloganColor = parseColor(dict: dict, key: OLConstant.sloganColor)
        self.sloganRect = parseRect(dict: dict, key: OLConstant.sloganRect)
        self.termsRect = parseRect(dict: dict, key: OLConstant.termsRect)
        self.termsClauseAttributes = parseAttributes(dict: dict, colorKey: OLConstant.termsClauseColor, OLConstant.termsClauseTextSize, OLConstant.termsLineSpacingExtra, OLConstant.termsLineSpacingMultiplier)
        self.termsBookTitleMarkHidden = parseBool(dict: dict, key: OLConstant.termsBookTitleMarkHidden)
        self.termsUncheckedToastText = parseString(dict: dict, key: OLConstant.termsUncheckedToastText)
        self.termsAlignmentIOS = parseInt(dict: dict, key: OLConstant.termsAlignmentIOS)
        self.terms = parsePrivacyTermItem(dict: dict, key: OLConstant.terms)
        self.auxiliaryPrivacyWords = dict[OLConstant.auxiliaryPrivacyWords] as? [String]
        self.uncheckedImage = parseIntoAssetsImage(dict[OLConstant.uncheckedImage])
        self.checkedImage = parseIntoAssetsImage(dict[OLConstant.checkedImage])
        self.defaultCheckBoxState = parseBool(dict: dict, key: OLConstant.defaultCheckBoxState)
        self.checkBoxRect = parseRect(dict: dict, key: OLConstant.checkBoxRect)
        self.webNaviHidden = parseBool(dict: dict, key: OLConstant.webNaviHidden)
        self.webNaviBgColor = parseColor(dict: dict, key: OLConstant.webNaviBgColor)
        self.navWebViewAttString = NSAttributedString.textFontColorString(color: dict[OLConstant.navWebViewTextColor] as? UIColor, font: dict[OLConstant.navWebViewTextSize] as? Int, text: (dict[OLConstant.navWebViewText] as? String), lineSpace: nil, lineSpacingMultiplier: nil)
        
    }
    
    
}

extension OLUIConfigure{
//    转成SDK对应model
    func toAuthViewModel() -> OLAuthViewModel{
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
        if let dialogCornersRadius = dialogCornersRadius{
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
        if let dialogCornersRadius = dialogCornersRadius{
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
        authViewModel.backgroundImage = authViewBackgroundImage
        authViewModel.backgroundColor = backgroundColor
        if let statusBarStyle = statusBarStyle {
            authViewModel.statusBarStyle = statusBarStyle
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
            let images = imagesString.compactMap({ [weak self](string) in
                return self?.parseIntoAssetsImage(string)
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
        authViewModel.privacyTermsAttributes = termsClauseAttributes
        if let termsBookTitleMarkHidden = termsBookTitleMarkHidden {
            authViewModel.hasQuotationMarkOnCarrierProtocol = termsBookTitleMarkHidden
        }
        authViewModel.notCheckProtocolHint = termsUncheckedToastText
        if let alignInt = termsAlignmentIOS,let align = NSTextAlignment(rawValue: alignInt) {
            authViewModel.termsAlignment = align
        }
        authViewModel.additionalPrivacyTerms = terms
        authViewModel.auxiliaryPrivacyWords = auxiliaryPrivacyWords
        authViewModel.uncheckedImage = uncheckedImage
        authViewModel.checkedImage = checkedImage
        if let defaultCheckBoxState = defaultCheckBoxState {
            authViewModel.defaultCheckBoxState = defaultCheckBoxState
        }
        if let checkBoxRect = checkBoxRect  {
            authViewModel.checkBoxRect = checkBoxRect
        }
        if let webNaviHidden = webNaviHidden {
            authViewModel.webNaviHidden = webNaviHidden
        }
        if let webNaviBgColor = webNaviBgColor {
            authViewModel.webNaviBgColor = webNaviBgColor
        }
        authViewModel.webNaviTitle = navWebViewAttString
        return authViewModel
    }
    
}


//数据解析
extension OLUIConfigure{
    func parseBool(dict:[String:Any],key:String) -> Bool?{
        return dict[key] as? Bool
    }
    
    func parseDouble(dict:[String:Any],key:String) -> Double?{
        return dict[key] as? Double
    }
    
    func parseInt(dict:[String:Any],key:String)->Int?{
        return dict[key] as? Int
    }
    func parseColor(dict:[String:Any],key:String) -> UIColor?{
        if let colorString = dict[key] as? String {
            return UIColor(hexString: colorString)
        }
        return nil
    }
    
    func parseString(dict:[String:Any],key:String) -> String?{
        return dict[key] as? String
    }
    
    func parseAttributes(dict:[String:Any],colorKey:String?,_ textSizeKey:String?,_ lineSpacingKey:String?,_ lineSpacingMultiplierKey:String?)-> [NSAttributedString.Key:Any]?{
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
    
    func parseIntoAssetsImage(_ value:Any?) -> UIImage?{
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
    
    func parseRect(dict:[String:Any],key:String) -> OLRect{
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
        var isForcePortrait:Bool?
        if let supportOrientation = supportedinterfaceOrientations{
            isForcePortrait = supportOrientation == .portrait
        }
        return rect.olRect(isForcePortrait)
    }
    
    func parsePrivacyTermItem(dict:[String:Any],key:String) -> [OLPrivacyTermItem]?{
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

