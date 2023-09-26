import 'package:cityinpocket/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuySell {
  String? title;
  String? description;
  String? id;
  String? docId;
  String? price;
  UserModel? user;
  List<dynamic>? images;
  Timestamp? date;
  String? phone;
  bool? household;
  bool? rental;

  BuySell({
    this.title,
    this.id,
    this.docId,
    this.description,
    this.user,
    this.price,
    this.images,
    this.date,
    this.phone,
    this.household,
    this.rental,
  });

  BuySell.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    date = json['date'];
    docId = json['docid'];
    price = json['price'];
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    images = json['images'].cast<String>();
    phone = json['phone'];
    household = json['household'];
    rental = json['rental'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['id'] = id;
    data['docid'] = docId;
    data['price'] = price;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['images'] = images;
    data['phone'] = phone;
    data['household'] = household;
    data['rental'] = rental;
    return data;
  }
}
