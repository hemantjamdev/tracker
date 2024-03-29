import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracker/utils/firebase_helper.dart';
import 'package:tracker/widgets/widgets.dart';

import '../model/tracker_model.dart';
import 'list_tile.dart';

class TimeList extends StatelessWidget {
  const TimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseHelper.dataStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot doc = snapshot.data as QuerySnapshot;
            if (doc.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int index) {
                    TrackerModel item = TrackerModel.fromJson(
                        doc.docs[index].data() as Map<String, dynamic>);

                    return buildCard(
                      index: index,
                      item: item,
                      startTime: item.startTime!,
                      stopTime: item.stopTime != "" ? item.stopTime! : "Running",
                    );
                  });
            } else {
              return Widgets.noData();
            }
          } else {
            return Widgets.emptyStream();
          }
        });
  }
}
