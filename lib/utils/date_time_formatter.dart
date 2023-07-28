import 'package:intl/intl.dart';

class DateTimeFormatter {
  //Type1
  static String formatApiDateTime(String apiDateTime) {
    final apiDateFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final apiDateTimeObject = apiDateFormat.parse(apiDateTime);

    final outputFormat = DateFormat('dd/MM/yyyy, hh:mm a');
    final outputDateTime = outputFormat.format(
        apiDateTimeObject);

    return outputDateTime;
  }

  //Type2
  static String formatTimeAgo(String apiDateTime) {
    final apiDateFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final apiDateTimeObject = apiDateFormat.parse(apiDateTime);

    final now = DateTime.now();
    final difference = now.difference(apiDateTimeObject);

    if (difference.inSeconds < 60) {
      return 'Cách đây ít phút';
    } else if (difference.inMinutes < 60) {
      return 'Cách đây ${difference.inMinutes} phút';
    } else if (difference.inHours < 24) {
      return 'Cách đây ${difference.inHours} giờ';
    } else {
      final outputFormat = DateFormat('dd/MM/yyyy, hh:mm a');
      final outputDateTime = outputFormat.format(apiDateTimeObject);
      return 'Ngày: $outputDateTime';
    }
  }
}
