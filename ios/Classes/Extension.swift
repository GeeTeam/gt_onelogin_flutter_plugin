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
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
     
}

extension NSAttributedString{
     public class func textFontColorString(color:UIColor?,font:Int?,text:String?,lineSpace:Double?,lineSpacingMultiplier:Double?) ->NSAttributedString?{
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
    func olRect() -> OLRect{
        return OLRect(portraitTopYOffset: origin.y, portraitCenterXOffset: origin.x, portraitLeftXOffset: 0, landscapeTopYOffset: origin.y, landscapeCenterXOffset:  0, landscapeLeftXOffset:  origin.x, size: size)
    }
}
