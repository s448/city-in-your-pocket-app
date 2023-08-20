import 'package:cityinpocket/Model/user.dart';

class SecondHandStuff {
  String? type;
  String? description;
  User? user;
  List<String>? images;

  SecondHandStuff({this.type, this.description, this.user, this.images});

  SecondHandStuff.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['type'] = type;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    return data;
  }
}