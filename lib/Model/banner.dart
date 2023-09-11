class BannerAd {
  String? details;
  String? imgUrl;
  String? contactUrl;
  BannerAd({this.details, this.imgUrl, this.contactUrl});

  BannerAd.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    imgUrl = json['imgUrl'];
    contactUrl = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details;
    data['imgUrl'] = imgUrl;
    data['contact'] = contactUrl;
    return data;
  }
}
