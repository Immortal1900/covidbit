import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PushFirebase extends StatefulWidget {
  @override
  _PushFirebaseState createState() => _PushFirebaseState();
}

class _PushFirebaseState extends State<PushFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            createRecord();
          },
        ),
      ),
    );
  }

  void createRecord()async {
   await Firestore.instance.collection("l8").document("l8").setData({
      "name": "ha"
    }
    );
    print("added");
  }
}
