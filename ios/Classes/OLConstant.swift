//
//  Constant.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/2.
//

import Foundation
struct OLConstant{
    ///方法通道名称
    static let methodChannel = "com.geetest.one_login_plugin";

    ///方法名称
    static let methodNames = "\(methodChannel)/methodNames";
    //初始化
    static let `init` = "\(methodNames)/init";
    static let requestToken = "\(methodNames)/requestToken";
    static let dismissAuthView = "\(methodNames)/dismissAuthView";
    static let sdkVersion = "\(methodNames)/sdkVersion";
    static let carrier = "\(methodNames)/carrier";
    static let isProtocolCheckboxChecked = "\(methodNames)/isProtocolCheckboxChecked";
    static let isReady = "\(methodNames)/isReady";
    static let setLogEnable = "\(methodNames)/setLogEnable";


    ///方法参数
    static let methodParameters = "\(methodNames)/methodParameters";
    static let appId = "\(methodParameters)/appId";
    static let timeout = "\(methodParameters)/timeout";
    static let bool = "\(methodParameters)/bool";

}
