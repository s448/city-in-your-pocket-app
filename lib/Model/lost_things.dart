import 'package:cityinpocket/Model/user.dart';

class LostThings {
  String? description;
  UserModel? user;

  LostThings({this.description, this.user});

  LostThings.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
