class BannerAd {
  String? details;
  String? imgUrl;
  String? contactUrl;
  int? navType;
  BannerAd({this.details, this.imgUrl, this.contactUrl, this.navType});

  BannerAd.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    imgUrl = json['imgUrl'];
    contactUrl = json['contact'];
    navType = json['nav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details;
    data['imgUrl'] = imgUrl;
    data['contact'] = contactUrl;
    data['nav'] = navType;
    return data;
  }
}
