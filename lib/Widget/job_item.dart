import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Model/job.dart';
import 'package:cityinpocket/Services/text_services.dart';
import 'package:cityinpocket/Services/time_management.dart';
import 'package:cityinpocket/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobItem extends StatelessWidget {
  const JobItem({
    super.key,
    required this.jobItems,
  });

  final List<Job> jobItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobItems.length,
      itemBuilder: (context, index) {
        final item = jobItems[index];
        return InkWell(
          onTap: () {
            Get.toNamed(
              Routes.jobDetails,
              arguments: {"job": item},
            );
          },
          child: Column(
            children: [
              Container(
                decoration: StyleManager.listTileStyle,
                child: SizedBox(
                  width: double.infinity,
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      item.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            removeSpacesAndTabs(item.description.toString()),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "${item.salary}",
                            style: StyleManager.priceStyle,
                          ),
                          const SizedBox(
                            height: 4.0,
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
                                      item.date!.toDate()),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6.0,
              )
            ],
          ),
        );
      },
    );
  }
}
