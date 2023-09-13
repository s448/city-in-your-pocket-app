import 'package:cityinpocket/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? message;
  Timestamp? date;
  UserModel? user;
  String? id;

  Message({this.message, this.date, this.user, this.id});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    id = json['id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['date'] = date;
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
