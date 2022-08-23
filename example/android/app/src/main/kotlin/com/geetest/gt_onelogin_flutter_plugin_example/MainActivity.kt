package com.geetest.gt_onelogin_flutter_plugin_example

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onStart() {
        super.onStart()
        // 解决弹窗Activity场景息屏亮屏后弹窗的背景黑屏的问题
        flutterEngine?.lifecycleChannel?.appIsResumed()
    }
}
