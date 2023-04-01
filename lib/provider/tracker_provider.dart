import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/tracker_model.dart';
import 'package:uuid/uuid.dart';

class TrackerProvider extends ChangeNotifier {
  Uuid uuid = const Uuid();
  StreamController<String> currentTimeController = StreamController<String>();
  StreamController<String> totalTimeController = StreamController<String>();

  final String initialData = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  String startTime = "";
  String stopTime = "";
  String totalTime = "";
  String uid = "";

  void startStopWatch() {
    if (stopwatch.isRunning) {
      // stopTime = DateFormat("hh:mm").format(DateTime.now());

      stopwatch.stop();
      // uid = uuid.v1();
      stopTime = DateFormat("yyyy-mm-dd hh:mm:ss").format(DateTime.now());
      TrackerModel data = TrackerModel(
          uid: uid,
          startTime: startTime,
          stopTime: stopTime,
          timeSpend: dateFormat(startTime, stopTime));
      setData(data);
      notifyListeners();
    } else {
      stopwatch.start();

      uid = uuid.v1();
      startTime = DateFormat("yyyy-mm-dd hh:mm:ss").format(DateTime.now());
      TrackerModel data = TrackerModel(
          uid: uid, startTime: startTime, stopTime: stopTime, timeSpend: "");
      setData(data);
      startWatch();
      notifyListeners();
    }
  }

  startWatch() {
    if (stopwatch.isRunning) {
      Timer.periodic(
        const Duration(milliseconds: 30),
        (timer) {
          var milli = stopwatch.elapsed.inMilliseconds;
          String second = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
          String minutes =
              (((milli ~/ 1000) ~/ 60) % 60).toString().padLeft(2, "0");
          String hours =
              (((milli ~/ 1000) ~/ 3600) % 24).toString().padLeft(2, "0");
          currentTimeController.add("$hours:$minutes:$second");
          totalTimeController.add("$hours:$minutes:$second");
        },
      );
    }
  }

  setData(TrackerModel time) async {
    try {
      final storage = FirebaseFirestore.instance;
      await storage
          .collection("tracking")
          .doc(time.uid)
          .set(time.toMap())
          .onError((error, stackTrace) => log(error.toString()));
      stopTime = "";
    } catch (e) {
      log("------errror------$e");
    }
  }

  String dateFormat(String startTime, String endTime) {
    DateTime _startTime = DateTime.parse(startTime);
    DateTime _endTime = DateTime.parse(endTime);
    Duration difference = _endTime.difference(_startTime);
    return "${difference.inHours}:${difference.inMinutes.remainder(60)}:${difference.inSeconds.remainder(60)}";
  }
}
