import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/user_controller.dart';
import 'package:cityinpocket/Model/job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class JobsController extends GetxController {
  final CollectionReference jobsRef =
      FirebaseFirestore.instance.collection('jobs');
  final userController = Get.find<UserController>();
  final addJobKey = GlobalKey<FormState>();
  var uuid = const Uuid();

  var title = ''.obs;
  var description = ''.obs;
  var company = ''.obs;
  var salary = ''.obs;
  var email = ''.obs;
  var isUploading = false.obs;
  Timestamp timestamp = Timestamp.now();

  Future<void> createJobItem() async {
    var docId = uuid.v1();
    if (addJobKey.currentState!.validate()) {
      try {
        isUploading.value = true;

        Job model = Job(
          title: title.value,
          company: company.value,
          description: description.value,
          salary: salary.value,
          user: userController.userModel,
          date: timestamp,
          email: email.value,
          docId: docId,
        );
        userController.loadUserData();
        await jobsRef.doc(docId).set(model.toJson()).then((value) {
          isUploading.value = false;
          Get.back();
          customSnackbar("تم النشر", "يمكنك الان تلقي طلبات التقديم");
        });
      } catch (e) {
        customSnackbar("خطأ", e.toString());
      }
    } else {
      return;
    }
  }

  Stream<List<Job>> getJobs() {
    return jobsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
        return Job.fromJson(data);
      }).toList();
    });
  }

  deleteJob(String? docId) async {
    await jobsRef.doc(docId).delete();
    customSnackbar("تم حذف الاعلان", '');
  }

  isPublisher(Job job) {
    return job.user!.id == userController.userModel.id;
  }
}
