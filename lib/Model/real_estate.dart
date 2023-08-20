import 'package:cityinpocket/Model/user.dart';

class RealEstate {
  String? address;
  String? description;
  User? user;
  List<String>? images;

  RealEstate({this.address, this.description, this.user, this.images});

  RealEstate.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    description = json['description'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    return data;
  }
}