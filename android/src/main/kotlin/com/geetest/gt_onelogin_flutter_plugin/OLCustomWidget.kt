package com.geetest.gt_onelogin_flutter_plugin

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView

class OLCustomWidget(dict: Map<String, Any>) {
    private var viewId: String? = null // 自定义控件 ID
    private var type: OLCustomWidgetType // 自定义控件类型
    private var rect: OLRect? = null // 控件位置，宽高
    private var olText: String? = null // type 为 TextView 和 Button 时控件文本内容
    private var olTextSize: Int? = null // type 为 TextView 时控件文本字体大小
    private var olTextColor: Int? = null // type 为 TextView 和 Button 时控件文本颜色
    private var olBackgroundImage: String? = null // type 为 Button 时控件背景图片
    private var olImage: String? = null // type 为 ImageView 和 Button 时控件图片
    private var olBackgroundColor: Int? = null // 控件背景颜色
    private var olTextAlignment: Int? = null // type 为 TextView 和 Button 时控件文本对齐方式

    init {
        viewId = dict[Constant.customWidgetsParaViewId] as? String
        type = (dict[Constant.customWidgetsParaType] as? Int)?.let {
            OLCustomWidgetType.values().getOrNull(it)
        } ?: OLCustomWidgetType.VIEW
        rect = (dict[Constant.customWidgetsParaRect] as? Map<*, *>)?.let { convertMapToRect(it) }
        olText = dict[Constant.customWidgetsParaText] as? String
        olTextSize = dict[Constant.customWidgetsParaTextSize] as? Int
        olTextColor = (dict[Constant.customWidgetsParaTextColor] as? String)?.let {
            UIHelper.hexStrToInt(it)
        }
        olBackgroundImage = dict[Constant.customWidgetsParaBackgroundImage] as? String
        olImage = dict[Constant.customWidgetsParaImage] as? String
        olBackgroundColor = (dict[Constant.customWidgetsParaBackgroundColor] as? String)?.let {
            UIHelper.hexStrToInt(it)
        }
        olTextAlignment = (dict[Constant.customWidgetsParaTextAlignment] as? Int)?.let {
            convertTextAlignment(it)
        }
    }

    fun toUIView(context: Context): View {
        return when (type) {
            OLCustomWidgetType.VIEW -> {
                LinearLayout(context).apply {
                    setBasicAttributes(this)
                }
            }

            OLCustomWidgetType.IMAGE_VIEW -> {
                ImageView(context).apply {
                    setBasicAttributes(this)
                    olImage?.let { setImageResource(getDrawableId(it, context)) }
                }
            }

            OLCustomWidgetType.TEXT_VIEW -> {
                TextView(context).apply {
                    setBasicAttributes(this)
                    olText?.let { text = it }
                    olTextColor?.let { setTextColor(findColorFormRes(context, it)) }
                    olTextSize?.let { textSize = it.toFloat() }
                    olTextAlignment?.let { gravity = it }

                }
            }

            OLCustomWidgetType.BUTTON -> {
                Button(context).apply {
                    setBasicAttributes(this)
                    olText?.let { text = it }
                    olTextColor?.let { setTextColor(findColorFormRes(context, it)) }
                    olTextSize?.let { textSize = it.toFloat() }
                    olTextAlignment?.let { textAlignment = it }
                    olBackgroundImage?.let { setBackgroundResource(getDrawableId(it, context)) }
                }
            }
        }
    }

    private fun setBasicAttributes(view: View) {
        viewId.let { view.tag = it }
        view.id = viewId?.hashCode() ?: View.NO_ID
        olBackgroundColor?.let { view.setBackgroundColor(it) }
        rect?.let {
            val layoutParams = RelativeLayout.LayoutParams(
                it.width?.let { width -> dip2px(view.context, width) }
                    ?: ViewGroup.LayoutParams.WRAP_CONTENT,
                it.height?.let { height -> dip2px(view.context, height) }
                    ?: ViewGroup.LayoutParams.WRAP_CONTENT
            )
            layoutParams.addRule(RelativeLayout.ALIGN_PARENT_LEFT)
            layoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP)
            view.x = it.x?.let { x -> dip2px(view.context, x).toFloat() } ?: 0f
            view.y = it.y?.let { y -> dip2px(view.context, y).toFloat() } ?: 0f
            view.layoutParams = layoutParams
        }
    }
}


enum class OLCustomWidgetType {
    VIEW,
    IMAGE_VIEW,
    TEXT_VIEW,
    BUTTON
}
