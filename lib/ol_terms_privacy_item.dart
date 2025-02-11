part of 'gt_onelogin_flutter_plugin.dart';

class OLTermsPrivacyItem {
  String title;
  String url;
  OLTermsPrivacyItem(this.title, this.url);

  static OLTermsPrivacyItem fromMap(Map<String, String> map) {
    var title = map[_OLConstant.termsItemTitle];
    var url = map[_OLConstant.termsItemUrl];
    return OLTermsPrivacyItem(title!, url!);
  }

  Map<String, String> toMap() {
    return {_OLConstant.termsItemTitle: title, _OLConstant.termsItemUrl: url};
  }
}
