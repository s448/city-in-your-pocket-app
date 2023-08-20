import 'package:cityinpocket/Model/user.dart';

class Shop {
  String? name;
  String? type;
  String? activity;
  String? description;
  User? user;
  List<String>? images;

  Shop(
      {this.name,
        this.type,
        this.activity,
        this.description,
        this.user,
        this.images});

  Shop.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    activity = json['activity'];
    description = json['description'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['activity'] = activity;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    return data;
  }
}