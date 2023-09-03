import 'package:cityinpocket/Model/user.dart';

class BuySell {
  String? type;
  String? title;
  String? description;
  UserModel? user;
  List<String>? images;

  BuySell({this.type, this.title, this.description, this.user, this.images});

  BuySell.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    return data;
  }
}
