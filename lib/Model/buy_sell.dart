import 'package:cityinpocket/Model/user.dart';

class BuySell {
  String? type;
  String? description;
  UserModel? user;
  List<String>? images;

  BuySell({this.type, this.description, this.user, this.images});

  BuySell.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    return data;
  }
}

