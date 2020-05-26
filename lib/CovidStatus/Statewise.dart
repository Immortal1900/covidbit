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


bool listcreted=false;
class statewise extends StatefulWidget {
  @override
  _statewiseState createState() => _statewiseState();
}

class _statewiseState extends State<statewise> {
  @override
  void initState() {
    // TODO: implement initState
    print("SLECTED STATE IS ${setSeletedState.selectedstate}");

    super.initState();
  }
/*
  void getapi() async {
    final response3 = await http.get("https://api.covid19india.org/state_test_data.json");
    if (response3.statusCode == 200) {
      var jsonresponce3=await json.decode(response3.body);

      Slist shape = new Slist.fromJson(jsonresponce3);
      print("data");
      getSeletedData(shape);
      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
  }
*/
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

        SizedBox(height: 20),
        listcreted==true? Container(

            width: MediaQuery.of(context).size.width,
          color: Colors.lightBlueAccent,
            child:Column(
              children: <Widget>[
                Text("POSITIVE CASES GROWTH"),
                Card(child: Sparkline(
                  lineColor: Colors.red,
               //   data: stategraphdata.positive,
                  pointsMode:PointsMode.last,
                )

                ),
              ],
            )
         ):

        Container(
          child: Text("Creating graph...."),
        )


            /*  FutureBuilder(
                builder: (context, projectSnap) {
                  listcreted==true?Container():Container(
                    child: Text("SDA"),
                  );

                },

              )*/
        ],
        ),
        )
        ),
      ),
    );
  }
/*
  void getSeletedData( Statelist shape) {
    bool datefound=false;
    int i=0;
    shape.std.forEach((f){
      if(f.state.contains(setSeletedState.selectedstate)){
        var now = new DateTime.now();
        var previousdate = now.subtract(Duration(days: i));
        var formatter = new DateFormat('dd/MM/yyyy');
        String formattedDate = formatter.format(previousdate);
        if(f.updatedon.contains(formattedDate)) {
          datefound=true;
          print(formattedDate);
          print("NUMBER OF VANTILATOIRS ${f.numofventilators}");
          stateData(f.totaltested, f.numofventilators, f.positive,f.numisolationbeds,f.numicubeds);
        }
      }
    });
    while(!datefound && i<5){
      i++;
      shape.std.forEach((f){
        if(f.state.contains(setSeletedState.selectedstate)){
          var now = new DateTime.now();
          var previousdate = now.subtract(Duration(days: i));
          var formatter = new DateFormat('dd/MM/yyyy');
          String formattedDate = formatter.format(previousdate);
          if(f.updatedon.contains(formattedDate)) {
            datefound=true;
            print(formattedDate);
            print("NUMBER OF VANTILATOIRS ${f.numofventilators}");
            if(f.numofventilators==""){
              print("ASBDKJBSDKBKAJSBDKJSD");
            }
            stateData(f.totaltested, f.numofventilators, f.positive,f.numisolationbeds,f.numicubeds);
            setState(() {
              stateData.numofventilators;
            });
            print("aslkdalsdnasd${stateData.numofventilators}");
          }
        }
      });
    }
    shape.std.forEach((f){
      if(f.state.contains(setSeletedState.selectedstate)){
      stategraphdata(f.positive);
      }
    });
    print("LIST CREATED IS ${stategraphdata.positive}");
    listcreted=true;

    }
}

class Statestotaltested{
  var totaltested;
    var state;
  Statestotaltested({
    this.totaltested,
    this.state,
  });
  factory  Statestotaltested.fromJson(Map<String, dynamic> Json) {
    return Statestotaltested(
        totaltested: Json["totaltested"],
        state: Json["state"]
          );
  }
}
class Slist {
  final List<Statestesteddata> std;
  Slist({
    this.std
  });
  factory  Slist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['states_tested_data'] as List;
    print(list.runtimeType);
    List<Statestesteddata> stateobject = list.map((i) => Statestesteddata.fromJson(i)).toList();
    return Slist(
           std: stateobject
    );
  }*/
}
