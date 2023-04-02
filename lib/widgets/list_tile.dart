import 'package:flutter/material.dart';

import '../model/tracker_model.dart';
import '../utils/firebase_helper.dart';

Widget buildCard(
    {required TrackerModel item,
    required String startTime,
    required String stopTime,
    required int index}) {
  return Card(
    child: ListTile(
      leading: Text((index + 1).toString()),
      onTap: () async {
        FirebaseHelper.deleteDate(item);
      },
      title: Text("$startTime - $stopTime"),
      trailing: Text(item.timeSpend.toString()),
    ),
  );
}
