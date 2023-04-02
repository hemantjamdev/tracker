import 'package:intl/intl.dart';

class TimerHelper {
  static String getTimer({required int milli}) {
    String second = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = (((milli ~/ 1000) ~/ 60) % 60).toString().padLeft(2, "0");
    String hours = (((milli ~/ 1000) ~/ 3600) % 24).toString().padLeft(2, "0");
    return "$hours:$minutes:$second";
  }

 static String getString({required String format, required DateTime dateTime}) =>
      DateFormat(format).format(dateTime);

 static DateTime getTime({required String dateTime}) => DateTime.parse(dateTime);
}
