import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/tracker_provider.dart';
import 'package:intl/intl.dart';
import 'package:tracker/tracker_model.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hemant Jam"),
                    Text(DateFormat("dd-MM-yyyy").format(DateTime.now())),
                    Text("version : 1.0.0"),
                  ],
                ),
                Consumer<TrackerProvider>(
                  builder: (context, provider, child) => StreamBuilder<String>(
                      initialData: provider.initialData,
                      stream: provider.totalTimeController.stream,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${snapshot.data}",
                            style: TextStyle(fontSize: 22),
                          ),
                        );
                      }),
                ),
                Icon(Icons.logout)
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("tracking").orderBy("uid",descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        QuerySnapshot doc = snapshot.data as QuerySnapshot;
                        if (doc.docs.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, int index) {
                                TrackerModel item = TrackerModel.fromJson(
                                    doc.docs[index].data()
                                        as Map<String, dynamic>);
                                return Card(
                                  child: ListTile(

                                    title: Text(
                                        "start time : ${item.startTime.toString()}"),
                                    subtitle: Text(
                                        "stopped time : ${item.stopTime.toString()}"),
                                    trailing:
                                        Text("${item.timeSpend.toString()}"),
                                  ),
                                );
                              });
                        } else {
                          return Text("no data");
                        }
                      } else {
                        return Text("no data");
                      }
                    }),
              ),
            ),
            Consumer<TrackerProvider>(
              builder: (context, provider, child) => StreamBuilder<String>(
                  initialData: provider.initialData,
                  stream: provider.currentTimeController.stream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total time : ${snapshot.data}",
                        style: TextStyle(fontSize: 22),
                      ),
                    );
                  }),
            ),
            Consumer<TrackerProvider>(
              builder: (context, provider, child) => InkWell(
                onTap: provider.startStopWatch,
                child: Container(
                  color:
                      provider.stopwatch.isRunning ? Colors.red : Colors.green,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child:
                          Text(provider.stopwatch.isRunning ? "Stop" : "Start"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
