import 'package:flutter/material.dart';
import 'package:tracker/utils/timer_helper.dart';

class Strings {
  static String getDatabaseName() {
    return TimerHelper.getString(
        format: "dd-MM-yyyy", dateTime: DateTime.now());
  }
}
