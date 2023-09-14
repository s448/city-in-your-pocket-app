import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Controller/jobs_controller.dart';
import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
import 'package:cityinpocket/Model/job.dart';
import 'package:cityinpocket/Widget/job_item.dart';
import 'package:cityinpocket/Widget/reusable_streambuilder.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobPage extends StatelessWidget {
  JobPage({Key? key}) : super(key: key);

  final jobsController = Get.put(JobsController(), permanent: true);
  final _prefs = Get.find<SharedPrefsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("الوظائف"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ReusableStreamBuilder(
            stream: jobsController.getJobs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Job> jobs = snapshot.data!;
                return JobItem(jobItems: jobs);
              } else if (snapshot.hasError) {
                return Text('خطأ: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            _prefs.userAuthenticated()
                ? Get.toNamed(
                    Routes.addJob,
                  )
                : Get.snackbar("يجب تسجيل حساب اولا", '');
          },
          // tooltip: "أضف $title للبيع ",
          child: const Icon(CupertinoIcons.add),
        ));
  }
}
