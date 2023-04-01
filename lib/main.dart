import 'package:flutter/material.dart';

import 'home_page.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Tracker());
}
class Tracker extends StatelessWidget {
  const Tracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tracker",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
