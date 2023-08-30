class UserModel {
  String? id;
  String? phone;
  String? name;
  String? imgUrl;
  String? email;

  UserModel({this.id, this.phone, this.name, this.imgUrl, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    imgUrl = json['imgUrl'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['email'] = email;
    return data;
  }
}
