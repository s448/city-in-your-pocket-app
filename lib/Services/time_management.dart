import 'package:cloud_firestore/cloud_firestore.dart';

class TimeManager {
// Define a function to display the period based on your condition
  static String displayPeriod(Timestamp timestamp) {
    DateTime currentTime = DateTime.now();

    Duration timeDifference = currentTime.difference(timestamp.toDate());

    if (timeDifference.inHours < 24) {
      // If less than one day, show the period in hours
      if (timeDifference.inHours == 0) {
        return "${timeDifference.inMinutes} دقيقة";
      } else if (timeDifference.inHours > 2 && timeDifference.inHours < 11) {
        return "${timeDifference.inHours} ساعات";
      } else if (timeDifference.inHours == 1) {
        return "ساعة واحدة";
      } else if (timeDifference.inHours == 2) {
        return "ساعتان";
      } else {
        return "${timeDifference.inHours} ساعة";
      }
    } else {
      // If one day or more, show the period in days
      if (timeDifference.inDays == 1) {
        return "يوم واحد";
      } else if (timeDifference.inHours == 2) {
        return "يومان";
      } else {
        return "${timeDifference.inHours} يوم";
      }
    }
  }
}
