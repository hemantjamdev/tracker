import 'package:flutter/material.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       // height: MediaQuery.of(context).size.height/2,
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
                    Text("Hemant"),
                    Text(DateTime.now().toString()),
                    Text("version : 1.0.0"),
                  ],
                ),
                Center(
                  child: Text("00:00:00"),
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
                  width: 2, color: Colors.grey,
                ),
              ),
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, int index) {
                  return Text("data$index");
                },
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total time : 00:00:00"),
            ),
            InkWell(
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(child: Text("Start/Strop")),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
