import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/constants/Strings.dart';
import '../model/tracker_model.dart';

class FirebaseHelper {
  static setData({required TrackerModel data}) async {
    try {
      final storage = FirebaseFirestore.instance;
      await storage
          .collection(Strings.getDatabaseName())
          .doc(data.uid)
          .set(data.toMap())
          .onError((error, stackTrace) => log(error.toString()));
    } catch (e) {
      log("------error------$e");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> dataStream() {
    return FirebaseFirestore.instance.collection(Strings.getDatabaseName()).snapshots();
  }

  static deleteDate(TrackerModel item) async {
    final instance = FirebaseFirestore.instance;
    await instance.collection(Strings.getDatabaseName()).doc(item.uid).delete();
  }
}
