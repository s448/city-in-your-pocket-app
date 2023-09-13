// import 'package:cityinpocket/Controller/shared_prefs_controller.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// class NotificationsPage extends StatelessWidget {
//   NotificationsPage({super.key});
//   final _prefs = Get.find<SharedPrefsController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("الأشعارات"),
//       ),
//       body: FutureBuilder(
//         future: _prefs.getSavedNotifications(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             List<Map<String, String>>? notifications = snapshot.data;
//             return ListView.builder(
//               itemCount: notifications!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(notifications[index]['title']!),
//                   subtitle: Text(notifications[index]['body']!),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
