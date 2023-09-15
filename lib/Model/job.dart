import 'package:cityinpocket/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String? title;
  String? salary;
  String? company;
  String? description;
  Timestamp? date;
  UserModel? user;
  String? docId;

  Job({
    this.title,
    this.salary,
    this.company,
    this.description,
    this.date,
    this.user,
    this.docId,
  });

  Job.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    salary = json['salary'];
    company = json['company'];
    date = json['date'];
    docId = json['docid'];
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['salary'] = salary;
    data['company'] = company;
    data['date'] = date;
    data['docid'] = docId;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
