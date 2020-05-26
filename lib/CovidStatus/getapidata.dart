import 'package:covid19bitdurg/CovidStatus/choiceDistrict.dart';
import 'package:covid19bitdurg/CovidStatus/choiceState.dart';
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:covid19bitdurg/CovidStatus/totaltestedmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid19bitdurg/CovidStatus/Districtdatamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'Statedatamodel.dart';
import 'covidStatus.dart';
void getSeletedData( Statelist shape) {
  shape.std.forEach((f){
    if(f.state.contains(setSeletedState.selectedstate)){
      print("ACTTIVE CASEE${f.active}");
      print("CONFIRMED CASEE${f.confirmed}");
      print("DEATHS CASEE${f.deaths}");
      print("RECOVERED CASEE${f.recovered}");
      print("LAST UPDATED ON ${f.updateon}");
      statetotaldata(f.active,f.confirmed,f.deaths,f.recovered,f.state,f.updateon);
    }
  });
  //  print("LIST CREATED IS ${stategraphdata.positive}");

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
  double k=0,p=0;
  for(int i=0;i<stateconfirmed.confirmed.length;i++){
    k=k+stateconfirmed.confirmed[i];
    p=p+staterecoverd.recovered[i];
    stateactive(k-p);
  }
  stateactive.activecount=stateactive.active[stateactive.active.length-1];
  listcreated=true;
  //  print("LIST CREATED IS ${stategraphdata.positive}");

}
void getSeletedData2( Shape shape1) {
  print(shape1.stateUuassigned.districtData.unassigned.active);
  districtData(shape1.stateUuassigned.districtData.unassigned.active,shape1.stateUuassigned.districtData.unassigned.recovered,shape1.stateUuassigned.districtData.unassigned.confirmed);
}

void getSeletedData3( Slist shape) {
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
        print(f.totaltested);
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
          print("TOTAL TESTED ${f.totaltested}");
          stateData(f.totaltested);
        }
      }
    });
  }
}