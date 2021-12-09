package com.geetest.gt_onelogin_flutter_plugin

/**
 * 运营商类型，顺序需要和flutter侧的枚举顺序一致
 */
enum class Carrier(val value: Int) {
    unknown(0),
    CM(1),
    CU(2),
    CT(3)
}