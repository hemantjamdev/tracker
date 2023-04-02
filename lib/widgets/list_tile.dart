import 'package:flutter/material.dart';

import '../model/tracker_model.dart';
import '../utils/firebase_helper.dart';

Widget buildCard(
    {required TrackerModel item,
    required String startTime,
    required String stopTime}) {
  return Card(
    child: ListTile(
      onTap: () async {
        FirebaseHelper.deleteDate(item);
      },
      title: Text("$startTime - $stopTime"),
      trailing: Text(item.timeSpend.toString()),
    ),
  );
}
