import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/colors.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Controller/jobs_controller.dart';
import 'package:cityinpocket/Model/job.dart';
import 'package:cityinpocket/Services/time_management.dart';
import 'package:cityinpocket/Services/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class JobDetails extends StatelessWidget {
  JobDetails({Key? key}) : super(key: key);
  final jobsController = Get.find<JobsController>();
  final Job _job = Get.arguments['job'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("تفاصيل الوظيفة"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //the publisher info
            ListTile(
              title: Text(_job.user!.name.toString()),
              subtitle: Text(_job.company.toString()),
              leading: const Icon(
                Icons.home_repair_service_rounded,
                size: 45,
                color: ColorManager.primaryColorLight,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "الراتب :  ",
                        style: StyleManager.bodyText1,
                      ),
                      Text(
                        _job.salary ?? "غير محدد",
                        style: StyleManager.priceStyle,
                      )
                    ],
                  ),
                  const VerticalDivider(
                    thickness: 1.5,
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        color: Colors.redAccent[400],
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      SizedBox(
                        width: Get.width * 0.25,
                        child: Text(
                          TimeManager.formatDateTimeOfMessage(
                              _job.date!.toDate()),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            //job title
            Text(
              _job.title.toString(),
              style: StyleManager.title,
            ),
            const SizedBox(
              height: 12,
            ),
            //job details
            const Text(
              "التفاصيل",
              style: StyleManager.headline1,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              _job.description.toString(),
              style: StyleManager.bodyText1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.1,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 20),
            InkWell(
                onTap: () {
                  UrlLauncherService.launch(
                      'https://wa.me/+20${_job.user?.phone}/?text=${Uri.encodeQueryComponent('رأيت اعلانك علي تطبيق $appName')}');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: StyleManager.roundedBoxDecoration,
                  child: Icon(
                    Ionicons.logo_whatsapp,
                    size: 30,
                    color: Colors.greenAccent.shade700,
                  ),
                )),
            const SizedBox(width: 6),
            Expanded(
              child: InkWell(
                onTap: () {
                  //TODO finish mail parameters
                  UrlLauncherService.sendEmail(_job.user!.email, "", "");
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: StyleManager.shadowBoxDecoration,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'التقديم',
                        style: StyleManager.headlineWhite,
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Icon(
                        CupertinoIcons.mail_solid,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
