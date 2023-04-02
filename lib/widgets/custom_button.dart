import 'package:flutter/material.dart';

import '../provider/tracker_provider.dart';

Widget customButton(
    {required TrackerProvider provider, required double width}) {
  return InkWell(
    onTap: provider.startStopWatch,
    child: Container(
      color: provider.cStopwatch.isRunning && provider.cStopwatch.isRunning
          ? Colors.red
          : Colors.green,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text(
              provider.cStopwatch.isRunning && provider.cStopwatch.isRunning
                  ? "Stop"
                  : "Start"),
        ),
      ),
    ),
  );
}
