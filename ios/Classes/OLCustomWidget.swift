//
//  OLCustomWidget.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2024/7/19.
//

import Foundation
import UIKit
import OneLoginSDK

class OLCustomWidget {
    var viewId:String?   //自定义控件 ID
    var type:OLCustomWidgetType    //自定义控件类型，当前只支持 View, ImageView, TextView，Button，其中只有Button 可点击
    var rect:CGRect?    //控件位置，宽高
    var text:String?    //type 为 TextView 和 Button 时控件文本内容
    var textSize:Int?    //type 为 TextView 时控件文本字体大小，单位: 安卓 sp ios pt
    var textColor:UIColor?    //type 为 TextView 和 Button 时控件文本颜色
    var backgroundImage:UIImage?    //type 为 Button 时控件背景图片
    var image:UIImage?    //type 为 ImageView 和 Button 时控件图片
    var backgroundColor:UIColor?    //控件背景颜色
    var cornerRadius:Double?    //控件圆角大小，仅 iOS 支持
    var textAlignment:NSTextAlignment    //type 为 TextView 和 Button 时控件文本对齐方式
    
    init(dict:[String:Any]) {
        
        self.viewId = DictParseUtil.parseString(dict:dict,key: OLConstant.customWidgetsParaViewId)
        self.type = OLCustomWidgetType(rawValue: DictParseUtil.parseInt(dict:dict,key: OLConstant.customWidgetsParaType) ?? 0) ?? OLCustomWidgetType.view
        self.rect = DictParseUtil.parseCGRect(dict:dict,key:OLConstant.customWidgetsParaRect)
        self.text = DictParseUtil.parseString(dict:dict,key: OLConstant.customWidgetsParaText)
        self.textSize = DictParseUtil.parseInt(dict:dict,key: OLConstant.customWidgetsParaTextSize)
        self.textColor = DictParseUtil.parseColor(dict:dict,key: OLConstant.customWidgetsParaTextColor)
        if let backgroundImageKey = dict[OLConstant.customWidgetsParaBackgroundImage] {
            self.backgroundImage = DictParseUtil.parseIntoAssetsImage(backgroundImageKey)
        }
        if let imageKey = dict[OLConstant.customWidgetsParaImage] as? String{
            self.image = DictParseUtil.parseIntoAssetsImage(imageKey)
        }
        self.backgroundColor = DictParseUtil.parseColor(dict:dict,key: OLConstant.customWidgetsParaBackgroundColor)
        self.cornerRadius = DictParseUtil.parseDouble(dict:dict, key:OLConstant.customWidgetsParaCornerRadius)
        self.textAlignment = NSTextAlignment(rawValue: DictParseUtil.parseInt(dict:dict,key: OLConstant.customWidgetsParaTextAlignment) ?? 0) ?? .left
    }
    
    func toUIView(target:Any?,action:Selector) -> UIView? {
        
        if type == .view {
            let view = UIView()
            setViewBasicAttributes(view: view)
            return view;
        }
        
        if type == .imageView {
            let imageView = UIImageView()
            setViewBasicAttributes(view: imageView)
            if let image = image {
                imageView.image = image;
            }
            return imageView
        }
        
        if type == .textView {
            let label = UILabel()
            setViewBasicAttributes(view: label)
            if let title = text {
                label.text = title
            }
            if let textColor = textColor {
                label.textColor = textColor
            }
            if let textSize = textSize {
                label.font = UIFont.systemFont(ofSize: CGFloat(textSize))
            }
            label.textAlignment = textAlignment
            return label;
        }
        
        if type == .button {
            let button = UIButton()
            setViewBasicAttributes(view: button)
            if let title = text {
                button.setTitle(title, for: .normal)
            }
            if let textColor = textColor {
                button.setTitleColor(textColor, for: .normal)
            }
            if let textSize = textSize {
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(textSize))
            }
            if let backgroundImage = backgroundImage {
                button.setBackgroundImage(backgroundImage, for: .normal)
            }
            button.titleLabel?.textAlignment = textAlignment
            button.addTarget(target, action: action, for: .touchUpInside)
            return button
        }
        
        return nil
    }
    
    func setViewBasicAttributes(view: UIView) {
        view.viewId = viewId ?? "";
        if let backgroundColor = backgroundColor {
            view.backgroundColor = backgroundColor
        }
        if let cornerRadius = cornerRadius, cornerRadius>0 {
            view.layer.masksToBounds = true
            view.layer.cornerRadius = cornerRadius
        }
        if let rect = rect {
            view.frame = rect
        }
    }
}


enum OLCustomWidgetType:Int {
    case view = 0
    case imageView = 1
    case textView = 2
    case button = 3
}
