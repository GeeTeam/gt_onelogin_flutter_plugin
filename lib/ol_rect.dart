part of gt_onelogin_flutter_plugin;

class OLRect{
  double? width;
  double? height;
  double? x;
  double? y;

  OLRect({this.height,this.width,this.x,this.y});

  Map<String,dynamic> toMap(){
    return {
      _OLConstant.rectWidth:width,
      _OLConstant.rectHeight:height,
      _OLConstant.rectX:x,
      _OLConstant.rectY:y
    }..removeWhere((key, value) => value == null);
  }
}