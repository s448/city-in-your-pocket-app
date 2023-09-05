import 'package:cityinpocket/Model/user.dart';

class BuySell {
  String? type;
  String? title;
  String? description;
  String? id;
  String? price;
  UserModel? user;
  List<dynamic>? images;

  BuySell(
      {this.type,
      this.title,
      this.id,
      this.description,
      this.user,
      this.price,
      this.images});

  BuySell.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    id = json['id'];
    price = json['price'];
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['id'] = id;
    data['price'] = price;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    return data;
  }
}
