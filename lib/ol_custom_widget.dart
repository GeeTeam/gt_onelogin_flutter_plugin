part of gt_onelogin_flutter_plugin;

class OLCustomWidget {
  String?	viewId;	//自定义控件 ID，如果是 Button 类型的组件，在 onCustomWidgetsClick 回调中通过 这个ID 区分不同组件的点击事件
  OLCustomWidgetType?	type;	///自定义控件类型，当前只支持 View, ImageView, TextView，Button，其中只有Button 可点击
  OLRect?	rect;	//控件位置，宽高
  String?	text;	//type 为 TextView 和 Button 时控件文本内容
  int?	textSize;	//type 为 TextView 时控件文本字体大小，单位: 安卓 sp ios pt
  Color?	textColor;	//type 为 TextView 和 Button 时控件文本颜色
  String?	backgroundImage;	//type 为 Button 时控件背景图片
  String?	image;	//type 为 ImageView 和 Button 时控件图片
  Color?	backgroundColor;	//控件背景颜色
  double?	cornerRadius;	//控件圆角大小，仅 iOS 支持
  OLTextAlignment?	textAlignment;	//type 为 TextView 和 Button 时控件文本对齐方式

  Map<String, dynamic> toMap() {

    return {
      _OLConstant.customWidgetsParaViewId:viewId,
      _OLConstant.customWidgetsParaType: type?.index ?? 0,
      _OLConstant.customWidgetsParaRect: rect?.toMap(),
      _OLConstant.customWidgetsParaText: text,
      _OLConstant.customWidgetsParaTextSize: textSize,
      _OLConstant.customWidgetsParaTextColor:textColor?.hexString,
      _OLConstant.customWidgetsParaBackgroundImage: backgroundImage,
      _OLConstant.customWidgetsParaImage: image,
      _OLConstant.customWidgetsParaBackgroundColor: backgroundColor?.hexString,
      _OLConstant.customWidgetsParaCornerRadius: cornerRadius,
      _OLConstant.customWidgetsParaTextAlignment: textAlignment?.index ?? 0
    }..removeWhere((key, value) => value == null);
  }
}