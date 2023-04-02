class DateHelper {
  static String timeDiff(
      {required DateTime startTime, required DateTime stopTime}) {
    Duration diff = stopTime.difference(startTime);

    String hours = diff.inHours.remainder(24).toString().padLeft(2, "0");
    String minutes = diff.inMinutes.remainder(60).toString().padLeft(2, "0");
    String seconds = diff.inSeconds.remainder(60).toString().padLeft(2, "0");

    return "$hours:$minutes:$seconds";
  }
}
