//
//  OLUIConfigure.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/3.
//

import Foundation
import OneLoginSDK


class OLUIConfigure{
    let iosLog = "| Geetest | OneLogin iOS | "
    //Only for iOS 授权页面支持的横竖屏方向
    var supportedinterfaceOrientations:UIInterfaceOrientationMask?
      //Only for iOS 授权页面界面样式

//    @available(iOS 12.0, *)
//    var userinterfaceStyle:UIUserInterfaceStyle?{
//        set{
//            _userinterfaceStyle = newValue
//        }
//        get{
//            return self.userinterfaceStyle
//        }
//
//    }

      ///--------------弹窗----------------
      //是否是弹框样式
    var isDialogStyle:Bool?
      //弹窗size，位置
    var dialogRect:CGRect?
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
    var navBackImageRect:CGRect?
      //返回按钮是否隐藏
    var navBackImageHidden:Bool?
    
    ///--------------logo----------------
      //logo 图片
    var logoImage:UIImage?
      //logo size 位置
    var logoImageRect:CGRect? ;
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
    var numberRect:CGRect? ;
    
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
    var switchButtonRect: CGRect? ;
    
    ///--------------一键登录按钮----------------
      //[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片],iOS数组最多为3，Android最多为2
    var authButtonImages:[String]?;
      //授权按钮的size 位置
    var authButtonRect:CGRect;
      //Only for iOS 授权按钮圆角
    var authButtonCornerRadius:Double?;
//      //授权按钮文字
//    var authzBtnText:String? ;
//      //授权按钮文字颜色
//    var authzBtnColor:UIColor?;
//      //授权按钮字体大小
//    var authzBtnTextSize:int? ;
    var authBtnAttString:NSAttributedString?

    init(dict:[String:Any]) {
        if let orientationsIndex = dict[OLConstant.supportedinterfaceOrientations] as? UInt  {
            self.supportedinterfaceOrientations = UIInterfaceOrientationMask(rawValue: orientationsIndex);
        }
//        if let userinterfaceStyleIndex = dict[OLConstant.supportedinterfaceOrientations] as? Int,let userinterfaceStyle = UIUserInterfaceStyle(rawValue: userinterfaceStyleIndex) {
////            self.userinterfaceStyle = userinterfaceStyle;
//        }
        self.isDialogStyle = parseBool(dict: dict, key: OLConstant.isDialogStyle)
        self.dialogRect =  parseRect(dict: dict, key: OLConstant.dialogRect)
        self.dialogCornersRadius = dict[OLConstant.dialogCornersRadius] as? Double
        self.dialogCornersRadius = parseDouble(dict: dict, key: OLConstant.dialogCornersRadius)
        self.authViewBackgroundImage = parseIntoAssetsImage(dict: dict, key: OLConstant.authViewBackgroundImage)
        self.backgroundColor = parseColor(dict: dict, key: OLConstant.backgroundColor)
        if let statusBarStyleIndex = dict[OLConstant.statusBarStyle] as? Int,
           let statusBarStyle = UIStatusBarStyle(rawValue: statusBarStyleIndex){
            self.statusBarStyle = statusBarStyle
        }
        self.navigationBarColor = parseColor(dict: dict, key: OLConstant.navigationBarColor)
        self.navHidden = parseBool(dict: dict, key: OLConstant.navHidden)
        self.navAttributedString = NSAttributedString.textFontColorString(color: dict[OLConstant.navTextColor] as? UIColor, font: dict[OLConstant.navTextSize] as? Int, text: (dict[OLConstant.navText] as! String), lineSpace: nil, lineSpacingMultiplier: nil)
        self.navBackImage = parseIntoAssetsImage(dict: dict, key: OLConstant.navBackImage)
        self.navBackImageRect = parseRect(dict: dict, key: OLConstant.navBackImageRect)
        self.navBackImageHidden = parseBool(dict: dict, key: OLConstant.navBackImageHidden)
        self.logoImage = parseIntoAssetsImage(dict: dict, key: OLConstant.logoImage)
        self.logoImageRect = parseRect(dict: dict, key: OLConstant.logoImageRect)
        self.logoImageHidden = parseBool(dict: dict, key: OLConstant.logoImageHidden)
        self.logoCornerRadius = parseDouble(dict: dict, key: OLConstant.logoCornerRadius)
        self.numberColor = parseColor(dict: dict, key: OLConstant.numberColor)
        self.numberSize = parseInt(dict: dict, key: OLConstant.numberSize)
        self.numberRect = parseRect(dict: dict, key: OLConstant.numberRect)
        self.switchButtonText = dict[OLConstant.switchButtonText] as? String
        self.switchTextSize = parseInt(dict: dict, key: OLConstant.switchTextSize)
        self.switchButtonColor = parseColor(dict: dict, key: OLConstant.switchButtonColor)
        self.switchButtonHidden = parseBool(dict: dict, key: OLConstant.switchButtonHidden)
        self.switchButtonRect = parseRect(dict: dict, key: OLConstant.switchButtonRect)
        self.authButtonImages = dict[OLConstant.authButtonImages] as? String
        self.authButtonRect = parseRect(dict: dict, key: OLConstant.authButtonRect)
        self.authButtonCornerRadius = parseDouble(dict: dict, key: OLConstant.authButtonCornerRadius)
        self.authBtnAttString = NSAttributedString.textFontColorString(color: dict[OLConstant.authzBtnColor] as? UIColor, font: dict[OLConstant.authzBtnColor] as? Int, text: (dict[OLConstant.authzBtnText] as! String), lineSpace: nil, lineSpacingMultiplier: nil)
    }
    
    
}

extension OLUIConfigure{
//    转成SDK对应model
    func toAuthViewModel() -> OLAuthViewModel{
        let authViewModel = OLAuthViewModel()
        if let supportedInterfaceOrientations = supportedinterfaceOrientations {
            
            authViewModel.supportedInterfaceOrientations = supportedInterfaceOrientations
        }
//        if #available(iOS 12.0, *),let userinterfaceStyle = userinterfaceStyle {
//            authViewModel.userInterfaceStyle = NSNumber(value: userinterfaceStyle.rawValue)
//        }
        if let isDialogStyle = isDialogStyle {
            authViewModel.isPopup = isDialogStyle
        }
        if let popRect = dialogRect {
            authViewModel.popupRect = popRect.olRect()
        }
        if let dialogCornersRadius = dialogCornersRadius{
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
        authViewModel.backgroundColor = backgroundColor
        if let dialogCornersRadius = dialogCornersRadius{
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
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
            authViewModel.backButtonRect = navBackImageRect.olRect()
        }
        if let navBackImageHidden = navBackImageHidden {
            authViewModel.backButtonHidden = navBackImageHidden
        }
        authViewModel.appLogo = logoImage
        if let logoImageRect = logoImageRect {
            authViewModel.logoRect = logoImageRect.olRect()
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
            authViewModel.phoneNumRect = numberRect.olRect()
        }
        authViewModel.switchButtonText = switchButtonText
        authViewModel.switchButtonColor = switchButtonColor
        if let switchTextSize = switchTextSize {
            authViewModel.switchButtonFont = UIFont.systemFont(ofSize: CGFloat(switchTextSize))
        }
        authViewModel.authButtonTitle = authBtnAttString
        
        
        return authViewModel
    }
    
}

extension OLUIConfigure{
    func parseBool(dict:[String:Any],key:String) -> Bool?{
        return dict[OLConstant.navHidden] as? Bool
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
    
    func parseIntoAssetsImage(dict:[String:Any],key:String) -> UIImage?{
        if let imageString = dict[key] as? String,!imageString.isEmpty{
            if let image =  UIImage(named: imageString) {
                return image
            }else{
                debugPrint(iosLog+"\(imageString)该资源路径不存在")
                return nil
            }
        }
        return nil
    }
    
    func parseRect(dict:[String:Any],key:String) -> CGRect{
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
            return CGRect(x: x, y: y, width: width, height: height)
        }
        return CGRect.zero
    }
}

