import 'package:cityinpocket/Constant/app_details.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Services/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.url,
      required this.isShare});
  final String title;
  final Icon icon;
  final String url;
  final bool isShare;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            isShare
                ? FlutterShare.share(
                    title: 'حمل تطبيق $appName من خلال الرابط $url')
                : UrlLauncherService.launch(url);
          },
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: StyleManager.title,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
