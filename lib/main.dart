import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/firebase_options.dart';

import 'provider/tracker_provider.dart';
import 'view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Tracker());
}

class Tracker extends StatelessWidget {
  const Tracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrackerProvider>(
      create: (context) => TrackerProvider(),
      child: MaterialApp(
        title: "Tracker",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
