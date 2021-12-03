//
//  OLUIConfigure.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/3.
//

import Foundation
import OneLoginSDK


@available(iOS 12.0, *)
class OLUIConfigure{
    //Only for iOS 授权页面支持的横竖屏方向
    var supportedinterfaceOrientations:UIInterfaceOrientationMask?
      //Only for iOS 授权页面界面样式

    var userinterfaceStyle:UIUserInterfaceStyle?

      ///--------------弹窗----------------
      //是否是弹框样式
    var isDialogStyle:Bool?;
      //弹窗size，位置
    var dialogRect:CGRect?;
      //弹窗圆角
    var dialogCornersRadius:Double? ;

      ///--------------背景----------------
      //设置背景图片
    var authViewBackgroundImage:String?
      //Only for iOS 设置背景颜色
    var backgroundColor:UIColor?;

    init(dict:[String:Any]) {
        if let orientationsIndex = dict[OLConstant.supportedinterfaceOrientations] as? UInt  {
            self.supportedinterfaceOrientations = UIInterfaceOrientationMask(rawValue: orientationsIndex);
        }
        if let userinterfaceStyleIndex = dict[OLConstant.supportedinterfaceOrientations] as? Int,let userinterfaceStyle = UIUserInterfaceStyle(rawValue: userinterfaceStyleIndex) {
            self.userinterfaceStyle = userinterfaceStyle;
        }
        if let isDialogStyle = dict[OLConstant.isDialogStyle] as? Bool{
            self.isDialogStyle = isDialogStyle
        }
        if let dialogRectDict = dict[OLConstant.dialogRect] as? [String:Double] {
            var width:Double = 0
            var height:Double = 0
            var x:Double = 0
            var y:Double = 0
            if let w = dialogRectDict[OLConstant.rectWidth] {
                width = w
            }
            if let h = dialogRectDict[OLConstant.rectHeight] {
                height = h
            }
            if let _x = dialogRectDict[OLConstant.rectX] {
                x = _x
            }
            if let _y = dialogRectDict[OLConstant.rectY] {
                y = _y
            }
            self.dialogRect = CGRect(x: x, y: y, width: width, height: height)
        }
        if let dialogCornersRadius = dict[OLConstant.dialogCornersRadius] as? Double {
            self.dialogCornersRadius = dialogCornersRadius
        }
    }
    
    func toAuthViewModel() -> OLAuthViewModel{
        let authViewModel = OLAuthViewModel()
        if let supportedInterfaceOrientations = supportedinterfaceOrientations {
            
            authViewModel.supportedInterfaceOrientations = supportedInterfaceOrientations
        }
        if let userinterfaceStyle = userinterfaceStyle{
            authViewModel.userInterfaceStyle = NSNumber(value: userinterfaceStyle.rawValue)
        }
        if let isDialogStyle = isDialogStyle {
            authViewModel.isPopup = isDialogStyle
        }
        if let popRect = dialogRect {
            authViewModel.popupRect = OLRect(portraitTopYOffset: popRect.origin.y, portraitCenterXOffset: popRect.origin.y, portraitLeftXOffset: popRect.origin.y, landscapeTopYOffset: popRect.origin.x, landscapeCenterXOffset:  popRect.origin.x, landscapeLeftXOffset:  popRect.origin.x, size: popRect.size)
        }
        if let dialogCornersRadius = dialogCornersRadius{
            authViewModel.popupCornerRadius = dialogCornersRadius
        }
        return authViewModel
    }
     
}
