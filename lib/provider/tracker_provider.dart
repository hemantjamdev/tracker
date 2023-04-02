import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tracker/model/tracker_model.dart';
import 'package:tracker/utils/date_formate.dart';
import 'package:tracker/utils/firebase_helper.dart';
import 'package:tracker/utils/timer_helper.dart';
import 'package:uuid/uuid.dart';

class TrackerProvider extends ChangeNotifier {
  final Uuid uuid = const Uuid();
  final StreamController<String> currentTimeController =
      StreamController<String>();
  final StreamController<String> totalTimeController =
      StreamController<String>();

  final String initialData = "00:00:00";
  final Stopwatch cStopwatch = Stopwatch();
  final Stopwatch tStopwatch = Stopwatch();
  String startTime = "";
  String startTimeForFb = "";

  String stopTime = "";
  String stopTimeForFb = "";
  String totalTime = "";
  String uid = "";

  void startStopWatch() {
    if (cStopwatch.isRunning && tStopwatch.isRunning) {
      stopTimeWatch();
      notifyListeners();
    } else {
      startTimeWatch();
      notifyListeners();
    }
  }

  void startTimeWatch() {
    cStopwatch.start();
    tStopwatch.start();

    uid = uuid.v1();

    startTime = TimerHelper.getString(
        format: "yyyy-MM-dd hh:mm:ss", dateTime: DateTime.now());
    startTimeForFb = DateTime.now().toString();
    stopTime = "";

    TrackerModel data = TrackerModel(
      uid: uid,
      startTime: TimerHelper.getString(
          format: "hh:mm:ss aa",
          dateTime: TimerHelper.getTime(dateTime: startTimeForFb)),
      stopTime: stopTime,
      timeSpend: "",
    );


    FirebaseHelper.setData(data: data);

    addTimeInStream();
  }

  void stopTimeWatch() {
    cStopwatch.stop();
    cStopwatch.reset();
    tStopwatch.stop();

    stopTime = TimerHelper.getString(
        format: "yyyy-MM-dd hh:mm:ss", dateTime: DateTime.now());
    stopTimeForFb = DateTime.now().toString();
    TrackerModel data = TrackerModel(
        uid: uid,
        startTime: TimerHelper.getString(
            format: "hh:mm:ss aa",
            dateTime: TimerHelper.getTime(dateTime: startTimeForFb)),
        stopTime: TimerHelper.getString(format: "hh:mm:ss aa", dateTime:TimerHelper.getTime(dateTime: stopTimeForFb)),
        timeSpend: DateHelper.timeDiff(
          startTime: TimerHelper.getTime(dateTime: startTime),
          stopTime: TimerHelper.getTime(dateTime: stopTime),
        ));
    FirebaseHelper.setData(data: data);
  }

  addTimeInStream() {
    if (cStopwatch.isRunning && tStopwatch.isRunning) {
      Timer.periodic(
        const Duration(milliseconds: 30),
        (timer) {
          String cTime =
              TimerHelper.getTimer(milli: cStopwatch.elapsed.inMilliseconds);
          String tTime =
              TimerHelper.getTimer(milli: tStopwatch.elapsed.inMilliseconds);
          currentTimeController.add(cTime);
          totalTimeController.add(tTime);
        },
      );
    }
  }

  @override
  void dispose() {
    currentTimeController.close();
    totalTimeController.close();
    super.dispose();
  }
}
