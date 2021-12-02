//
//  CarrierType.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/2.
//

enum OLCarrierType:String{
   case unknow = "unknow"
   case cm = "CM"    // 移动
   case cu = "CU"  // 联通
   case ct = "CT"  //电信
}

extension OLCarrierType{
    func intValue() -> Int{
        switch self {
        case .unknow:
            return 0
        case .cm:
            return 1
        case .cu:
            return 2
        case .ct:
            return 3
        } 
    }
}
