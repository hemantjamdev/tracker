class TrackerModel {
  String? uid;
  String? startTime;
  String? stopTime;
  String? timeSpend;

  TrackerModel(
      {required this.uid,
      required this.startTime,
      required this.stopTime,
      required this.timeSpend});

  TrackerModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    startTime = json["startTime"];
    stopTime = json["stopTime"];
    timeSpend = json["timeSpend"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "startTime": startTime,
      "stopTime": stopTime,
      "timeSpend": timeSpend
    };
  }
}
