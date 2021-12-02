//
//  CarrierType.swift
//  gt_onelogin_flutter_plugin
//
//  Created by noctis on 2021/12/2.
//

enum CarrierType:String{
   case cm = "CM"    // 移动
   case cu = "CU"  // 联通
   case ct = "CT"  //电信
   case unknow = "unknow"
    
}

extension CarrierType{
    func intValue() -> Int{
        switch self {
        case .cm:
            return 0
        case .cu:
            return 1
        case .ct:
            return 2
        case .unknow:
            return 3
        } 
    }
}
