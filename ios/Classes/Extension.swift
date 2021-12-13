//
//  Extension.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/3.
//

import Foundation
import UIKit
import OneLoginSDK

extension UIColor {
     
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let a,r,g,b:UInt32
        switch hexString.count{
        case 3: (a,r,g,b) = (255,(color >> 8) * 17,(color >> 4 & 0xF) * 17,(color & 0xF) * 17)
        case 6: (a,r,g,b) = (255,color >> 16,color >> 8 & 0xFF,color & 0xFF)
        case 8: (a,r,g,b) = (color >> 24,color >> 16 & 0xFF,color >> 8 & 0xFF, color & 0xFF)
        default: (a,r,g,b) = (255,0,0,0)
        }
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        let alpha = CGFloat(a) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
     
}

extension NSAttributedString {
     public class func textFontColorString(color:UIColor?,font:Int?,text:String?,lineSpace:Double?,lineSpacingMultiplier:Double?) ->NSAttributedString? {
         var attributes :[NSAttributedString.Key:Any] = [:]
        guard let text = text,!text.isEmpty else {
            return nil
        }
        if let color = color {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        if let font = font {
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: CGFloat(font))
        }
        if lineSpace != nil ||  lineSpacingMultiplier != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            if let lineSpace = lineSpace {
                paragraphStyle.lineSpacing = lineSpace
            }
            if let lineSpacingMultiplier = lineSpacingMultiplier {
                paragraphStyle.lineHeightMultiple = lineSpacingMultiplier
            }
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        return NSAttributedString(string: text, attributes: attributes)
    }
}

extension CGRect{
    func olRect(_ isForcePortrait:Bool?) -> OLRect {
//        根据当前屏幕方向设置横竖屏的坐标
        var orientation = UIApplication.shared.statusBarOrientation
        if let isForcePortrait = isForcePortrait{
            orientation = isForcePortrait ? UIInterfaceOrientation.portrait : UIInterfaceOrientation.landscapeLeft
        }
        let isPortrait:Bool = orientation == UIInterfaceOrientation.portrait
        return OLRect(portraitTopYOffset: (isPortrait ? origin.y :0), portraitCenterXOffset: 0, portraitLeftXOffset: (isPortrait ? origin.x:0) , landscapeTopYOffset: (isPortrait ? 0:origin.y), landscapeCenterXOffset:  0, landscapeLeftXOffset:  (isPortrait ? 0:origin.x), size: size)
    }
}
