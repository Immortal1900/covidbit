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
    getapi();
    super.initState();
  }
  void getapi() async {
    final response = await http.get("https://api.covid19india.org/state_test_data.json");
    if (response.statusCode == 200) {
      var jsonresponce=await json.decode(response.body);

      Statelist shape = new Statelist.fromJson(jsonresponce);
      print("data");
      getSeletedData(shape);

      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
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
            Card(
            child: Text("No. of ventilators: "+stateData.numofventilators),
      ),
        Card(
          child: Text("Total Tests: "+stateData.totaltested),
        )
        ,
        Card(
          child: Text("Total Positive cases: "+stateData.positive),
        ),
        Card(
          child: Text("No. of Isolation Beds: "+stateData.numisolationbeds),
        ),
        Card(
          child: Text("No of ICU Beds: "+stateData.numicubeds),
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
                  data: stategraphdata.positive,
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

class Statestesteddata{
  //String title;
  int active;
  var updatedon;
  var totaltested;
  int recovered;
  var numofventilators;
  var state;
  var positive;
  var numicubeds;
  var numisolationbeds;


  //  String dist;
  Statestesteddata({
    //this.title,

    this.updatedon,
    this.totaltested,
    this.recovered,
    this.numofventilators,
    this.positive,
    this.state,
    this.numicubeds,
    this.numisolationbeds
    //this.dist
  });
  factory  Statestesteddata.fromJson(Map<String, dynamic> Json) {
    return Statestesteddata(
        updatedon: Json["updatedon"],
        totaltested: Json["totaltested"],
        numofventilators: Json["numventilators"],
        positive:Json["positive"],
        state: Json["state"],
        numicubeds: Json["numicubeds"],
        numisolationbeds:Json["numisolationbeds"]
          );
  }
}
class Statelist {
  final List<Statestesteddata> std;

  Statelist({
    this.std
  });
  factory  Statelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['states_tested_data'] as List;
    print(list.runtimeType);
    List<Statestesteddata> stateList = list.map((i) => Statestesteddata.fromJson(i)).toList();

    return Statelist(
      //title: json['City'],
      //state: parsedJson["id"],
      //dist: json['District'],
        std: stateList
      //stdl: stdlist
    );
  }
}