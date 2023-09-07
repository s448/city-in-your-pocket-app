import 'package:cityinpocket/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? message;
  Timestamp? date;
  UserModel? user;

  Message({this.message, this.date, this.user});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
