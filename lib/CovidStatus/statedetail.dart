import 'dart:convert';

import 'dart:ui';
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:covid19bitdurg/CovidStatus/covidStatus.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
//import 'package:covid19bitdurg/Users/covidreport.dart';

class statedetail extends StatefulWidget {
  @override
  _statedetailState createState() => _statedetailState();
}
bool listcreted=false;
class _statedetailState extends State<statedetail> {
  @override
  void initState() {
    // TODO: implement initState
    print("SLECTED STATE IS ${setSeletedState.selectedstate}");
    getapi();
    super.initState();
  }
  void getapi() async {
    final response = await http.get("https://api.covid19india.org/data.json");
    final response1=await http.get("https://api.covid19india.org/states_daily.json");
    if (response.statusCode == 200) {
      var jsonresponce=await json.decode(response.body);
      Statelist shape = new Statelist.fromJson(jsonresponce);
      getSeletedData(shape);
      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
    if (response1.statusCode == 200) {
      var jsonresponce1=await json.decode(response1.body);
      Statelist1 shape1 = new Statelist1.fromJson(jsonresponce1);
     getSeletedData1(shape1);
      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
  }
  void getSeletedData( Statelist shape) {
    shape.std.forEach((f){
      if(f.state.contains(setSeletedState.selectedstate)){
      print("ACTTIVE CASEE${f.active}");
      print("CONFIRMED CASEE${f.confirmed}");
      print("DEATHS CASEE${f.deaths}");
      print("RECOVERED CASEE${f.recovered}");
      }
    });
  //  print("LIST CREATED IS ${stategraphdata.positive}");
    listcreted=true;
  }
  void getSeletedData1( Statelist1 shape1) {
print(shape1.std1.length);
int a=shape1.std1.length;

shape1.std1.forEach((f){
    if(f.status.contains("Confirmed")) {
      stateconfirmed(f.statec);
    }
    if(f.status.contains("Recovered")) {
      staterecoverd(f.statec);
    }
    if(f.status.contains("Deceased")) {
      statedeaths(f.statec);
    }
});
listcreted=true;
print(statedeaths.deaths);
print(staterecoverd.recovered);

    //  print("LIST CREATED IS ${stategraphdata.positive}");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
      ),
      body:
      Center(
        child: Container(
            width: MediaQuery.of(context).size.width*0.8,

            child: Padding(
              padding: EdgeInsets.fromLTRB(20,20,20,20),
              child:  ListView(
                children: <Widget>[
                  Text(setSeletedState.selectedstate,
                    style: TextStyle(height: 5, fontSize:30),
                  ),
                  Text("RECOEVRED"),
                  listcreted==false?Container():Container(
                    child: Sparkline(
                      lineColor: Colors.green,
                      data:staterecoverd.recovered,
                      pointsMode:PointsMode.last,
                    ),
                  ),
                  Text("Confirmed"),
               AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              child: Sparkline(
                lineColor: Colors.red,
                data:statedeaths.deaths,
                pointsMode:PointsMode.last,
              ),
            )
    ),
                  Text("DECEASED"),
                  Container(
                    child: Sparkline(
                      lineColor: Colors.red,
                      data:statedeaths.deaths,
                      pointsMode:PointsMode.last,
                    ),
                  )


                ],
              ),
            )
        ),
      ),
    );
  }
}
//****************************************************************************GRAPH MODEL*****************************************************

class Statestesteddata1{

  var statec;
  var status;
  Statestesteddata1({
   this.statec,
    this.status
    //this.dist
  });
  factory  Statestesteddata1.fromJson(Map<String, dynamic> Json) {
    return Statestesteddata1(
      statec: Json[setSeletedState.selectedstatecode],
        status:Json["status"]
    );
  }
}
class Statelist1 {
  final List<Statestesteddata1> std1;

  Statelist1({
    this.std1
  });
  factory  Statelist1.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['states_daily'] as List;
    print(list.runtimeType);
    List<Statestesteddata1> stateList1 = list.map((i) => Statestesteddata1.fromJson(i)).toList();
    return Statelist1(
        std1: stateList1
    );
  }
}

class Statestesteddata{
  //String title;
  var active;
  var confirmed;
  var deaths;
  var recovered;
  var state;

  Statestesteddata({
    this.active,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.state,
    //this.dist
  });
  factory  Statestesteddata.fromJson(Map<String, dynamic> Json) {
    return Statestesteddata(
        active: Json["active"],
        confirmed: Json["confirmed"],
        deaths: Json["deaths"],
        recovered: Json["recovered"],
        state: Json["state"]
    );
  }
}
class Statelist {
  final List<Statestesteddata> std;

  Statelist({
    this.std
  });
  factory  Statelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['statewise'] as List;
    print(list.runtimeType);
    List<Statestesteddata> stateList = list.map((i) => Statestesteddata.fromJson(i)).toList();
    return Statelist(
        std: stateList
    );
  }
}
