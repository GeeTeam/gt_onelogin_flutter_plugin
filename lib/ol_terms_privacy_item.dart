part of gt_onelogin_flutter_plugin;

class OLTermsPrivacyItem{
  String title;
  String url;
  OLTermsPrivacyItem(this.title,this.url);

  Map<String,String> toMap(){
    return {
      _OLConstant.termsItemTitle:title,
      _OLConstant.termsItemUrl:url
    };
  }
}