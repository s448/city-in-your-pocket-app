class Banner {
  String? routeUrl;
  String? imgUrl;

  Banner({this.routeUrl, this.imgUrl});

  Banner.fromJson(Map<String, dynamic> json) {
    routeUrl = json['routeUrl'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['routeUrl'] = routeUrl;
    data['imgUrl'] = imgUrl;
    return data;
  }
}