import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/tracker_provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/info.dart';
import '../widgets/time_list.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dateInfo(),
                Consumer<TrackerProvider>(
                  builder: (context, provider, child) => StreamBuilder<String>(
                      initialData: provider.initialData,
                      stream: provider.currentTimeController.stream,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${snapshot.data}",
                            style: const TextStyle(fontSize: 22),
                          ),
                        );
                      }),
                ),
                const Icon(Icons.logout)
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                child: const TimeList(),
              ),
            ),
            Consumer<TrackerProvider>(
              builder: (context, provider, child) => StreamBuilder<String>(
                  initialData: provider.initialData,
                  stream: provider.totalTimeController.stream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total time : ${snapshot.data}",
                        style: const TextStyle(fontSize: 22),
                      ),
                    );
                  }),
            ),
            Consumer<TrackerProvider>(
              builder: (context, provider, child) => customButton(
                  provider: provider, width: MediaQuery.of(context).size.width),
            )
          ],
        ),
      ),
    );
  }
}
