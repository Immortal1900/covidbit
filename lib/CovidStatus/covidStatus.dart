import 'package:flutter/material.dart';




class Covid19Status extends StatefulWidget {
  @override
  _Covid19StatusState createState() => _Covid19StatusState();
}

class _Covid19StatusState extends State<Covid19Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height*.3,
        decoration: new BoxDecoration(
          color: Colors.orange,
          boxShadow: [
            new BoxShadow(blurRadius: 40.0)
          ],
          borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 100.0)),
        ),
      )
    );
  }
}
