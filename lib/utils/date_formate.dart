class DateHelper {
  static String timeDiff(
      {required String startTime, required String stopTime}) {
    DateTime startingTime = DateTime.parse(startTime);
    DateTime endingTime = DateTime.parse(stopTime);

    Duration diff = endingTime.difference(startingTime);

    String hours = diff.inHours.remainder(24).toString().padLeft(2, "0");
    String minutes = diff.inMinutes.remainder(60).toString().padLeft(2, "0");
    String seconds = diff.inSeconds.remainder(60).toString().padLeft(2, "0");

    return "$hours:$minutes:$seconds";
  }
}
