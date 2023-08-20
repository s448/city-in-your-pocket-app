import 'package:cityinpocket/Model/shop.dart';
import 'package:cityinpocket/Model/user.dart';

class Discount {
  int? discount;
  String? description;
  User? user;
  Shop? shop;
  Discount({this.discount, this.description, this.user, this.shop});

  Discount.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    description = json['description'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount'] = discount;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    return data;
  }
}
