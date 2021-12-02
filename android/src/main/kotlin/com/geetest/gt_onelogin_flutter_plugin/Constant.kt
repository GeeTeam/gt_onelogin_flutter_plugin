package com.geetest.gt_onelogin_flutter_plugin

class Constant {
    companion object {
        ///方法通道名称
        val methodChannel = "com.geetest.one_login_plugin";

        ///方法名称
        val methodNames = "$methodChannel/methodNames";
        //初始化
        val init = "$methodNames/init";
        val requestToken = "$methodNames/requestToken";
        val dismissAuthView = "$methodNames/dismissAuthView";
        val sdkVersion = "$methodNames/sdkVersion";
        val carrier = "$methodNames/carrier";
        val isProtocolCheckboxChecked = "$methodNames/isProtocolCheckboxChecked";
        val isReady = "$methodNames/isReady";


        ///方法参数
        val methodParameters = "$methodChannel/methodParameters";
        val appId = "$methodParameters/appId";
        val timeout = "$methodParameters/timeout";
        val bool = "$methodParameters/bool";
    }
}