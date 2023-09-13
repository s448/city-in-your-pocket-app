import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeManager {
// Define a function to display the period based on your condition
  static String displayPesriod(Timestamp timestamp) {
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

  static String formatDateTimeOfMessage(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (dateTime.isAfter(today)) {
      // Message was sent today, so show the time
      return DateFormat.jm().format(dateTime); // Format as 12:00 AM/PM
    } else {
      // Message was sent on a different day, so show the date
      return DateFormat('dd-M-yyyy')
          .format(dateTime); // Format as 01 September 2023
    }
  }
}
