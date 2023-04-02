import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget dateInfo() {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text("Hemant Jam"),
Text(DateFormat("dd-MM-yyyy").format(DateTime.now())),
const Text("version : 1.0.0"),
],
);
}