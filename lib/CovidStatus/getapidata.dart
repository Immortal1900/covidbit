
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:covid19bitdurg/CovidStatus/totaltestedmodel.dart';
import 'package:covid19bitdurg/CovidStatus/covidStatus.dart';
import 'package:covid19bitdurg/CovidStatus/Districtdatamodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'Statedatamodel.dart';
/*
initalizedb(){
  shape.std.forEach((f) async {
     print("UPDATING DATABASE");
    await Firestore.instance.collection("l8").document(f.state).updateData({
      'confirmed':f.confirmed,
      'active':f.active,
      'recovered':f.recovered,
      'deceased':f.deaths,
      "lastupdate":f.updateon,
      'preconfirmed':0,
      'preactive':0,
      'prerecovered':0,
      'predecesed':0
    }).catchError((e){
      print("ERRRROR IS $e");
    });
  });
}*/

Future<void> getSeletedData( Statelist shape) async {
  var lastupdated;
  int size=shape.itd.length-1;
  //GRAPH DATA
  indiadata.totalc.clear();
  for(int i=shape.itd.length-1;i>size-30;i--){
    indiadata.totalc.add(double.parse(shape.itd[i].totalconfirmed));
  }
  //reverse the LIST
  print(indiadata.totalc);
  indiadata.totalc=new List.from(indiadata.totalc.reversed);
  indiadata(shape.itd[shape.itd.length-1].totalconfirmed,shape.itd[shape.itd.length-1].totaldeceased,shape.itd[shape.itd.length-1].totalrecovered);
  print(indiadata.totalc);
  //INDIA DATA COMPLETED
  shape.std.forEach((f){
    if(f.state.contains(setSeletedState.selectedstate)){
      print("ACTTIVE CASEE${f.active}");
      print("CONFIRMED CASEE${f.confirmed}");
      print("DEATHS CASEE${f.deaths}");
      print("RECOVERED CASEE${f.recovered}");
      print("LAST UPDATED ON ${f.updateon}");
      statetotaldata(f.active,f.confirmed,f.deaths,f.recovered,f.state,f.updateon);
    }
  }  );

  String pc;String pa;String pr;String pd;
  await Firestore.instance
      .collection('l8')
      .document(setSeletedState.selectedstate)
      .get()
      .then((DocumentSnapshot ds) {
    lastupdated= ds.data['lastupdate'];
    pc= ds.data['confirmed'];
    pa= ds.data['active'];
    pr= ds.data['recovered'];
    pd= ds.data['deceased'];
  });
  print("LASTUPDATE IS $lastupdated");

  if(lastupdated==statetotaldata.lastupdatde){
    print("JSON not updated showing previous data");
    await Firestore.instance
        .collection('l8')
        .document(setSeletedState.selectedstate)
        .get()
        .then((DocumentSnapshot ds) {
      stateprevious.preconfirmed=ds.data['preconfirmed'];
      stateprevious.preactive=ds.data['preactive'];
      stateprevious.prerecovered=ds.data['prerecovered'];
      stateprevious.predeceased=ds.data['predecesed'];
    });
  }
  else{
    print("SHOWING NEW DATA");
    shape.std.forEach((f) async {
      if(f.state==setSeletedState.selectedstate){
        stateprevious.preconfirmed=int.parse(statetotaldata.confirmed)-int.parse(pc);
        stateprevious.prerecovered=int.parse(statetotaldata.recovered)-int.parse(pr);
        stateprevious.preactive=int.parse(statetotaldata.active)-int.parse(pa);
        stateprevious.predeceased=int.parse(statetotaldata.deaths)-int.parse(pd);
      }
    });
    print("UPDATING DATABASE");
    await Firestore.instance.collection("l8").document(setSeletedState.selectedstate).updateData({
      'confirmed':statetotaldata.confirmed,
      'active':statetotaldata.active,
      'recovered':statetotaldata.recovered,
      'deceased':statetotaldata.deaths,
      "lastupdate":statetotaldata.lastupdatde,
      'preconfirmed':int.parse(statetotaldata.confirmed)-int.parse(pc),
      'preactive':int.parse(statetotaldata.active)-int.parse(pa),
      'prerecovered':int.parse(statetotaldata.recovered)-int.parse(pr),
      'predecesed':int.parse(statetotaldata.deaths)-int.parse(pd),
    }).catchError((e){
      print("ERRRROR IS $e");
    });
    print("DATABASE UPDATE FINISHED");
  }


  //  print("LIST CREATED IS ${stategraphdata.positive}");
}
void getSeletedData1( Statelist1 shape1) {
  int a =shape1.std1.length;
  statedeaths.deaths.clear();
  stateconfirmed.confirmed.clear();
  stateactive.active.clear();
  staterecoverd.recovered.clear();
  shape1.std1.forEach((f){
    if(f.status.contains("Confirmed")) {
      stateconfirmed.confirmed.add(double.parse(f.statec));
    }
    if(f.status.contains("Recovered")) {
      staterecoverd.recovered.add(double.parse(f.statec));
    }
    if(f.status.contains("Deceased")) {
      statedeaths.deaths.add(double.parse(f.statec));
    }
  }
  );

  double k=0,p=0,z=0;
  for(int i=0;i<stateconfirmed.confirmed.length;i++){
    k=k+stateconfirmed.confirmed[i];
    p=p+staterecoverd.recovered[i];
    z=k-p;
    stateactive.active.add(z);
  }
  stateactive.activecount=stateactive.active[stateactive.active.length-1];

  stateconfirmed.confirmed=stateconfirmed.confirmed.sublist((stateconfirmed.confirmed.length-1)-40,stateconfirmed.confirmed.length-1);
  staterecoverd.recovered= staterecoverd.recovered.sublist(( staterecoverd.recovered.length-1)-40, staterecoverd.recovered.length-1);
  statedeaths.deaths=statedeaths.deaths.sublist((statedeaths.deaths.length-1)-40,statedeaths.deaths.length-1);
  stateactive.active=stateactive.active.sublist((stateactive.active.length-1)-40,stateactive.active.length-1);
  listcreated=true;
  //  print("LIST CREATED IS ${stategraphdata.positive}");

}
getSeletedData2() async {
  final response2 = await http.get("https://api.covid19india.org/state_district_wise.json");
  if (response2.statusCode == 200) {
    var jsonresponce2=await json.decode(response2.body);
    Shape shape2 = new Shape.fromJson(jsonresponce2);
    print(shape2);
    print(setSeletedState.selectedstate);
    print("${shape2.stateUuassigned.districtData.unassigned.active},${shape2.stateUuassigned.districtData.unassigned.recovered}${shape2.stateUuassigned.districtData.unassigned.confirmed}");
    districtData(shape2.stateUuassigned.districtData.unassigned.active,shape2.stateUuassigned.districtData.unassigned.recovered,shape2.stateUuassigned.districtData.unassigned.confirmed);

  } else {
    throw Exception('Failed to load data');
  }
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
          stateData(f.totaltested);
        }
      }
    });
  }

}
getSeletedData4() async {
  final response2 = await http.get("https://api.covid19india.org/state_district_wise.json");
  if (response2.statusCode == 200) {
    var jsonresponce2=await json.decode(response2.body);
    Shape shape2 = new Shape.fromJson(jsonresponce2);
    print(shape2);
    print(setSeletedState.selectedstate);
    print("${shape2.stateUuassigned.districtData.unassigned.active},${shape2.stateUuassigned.districtData.unassigned.recovered}${shape2.stateUuassigned.districtData.unassigned.confirmed}");
    districtData(shape2.stateUuassigned.districtData.unassigned.active,shape2.stateUuassigned.districtData.unassigned.recovered,shape2.stateUuassigned.districtData.unassigned.confirmed);

  } else {
    throw Exception('Failed to load data');
  }
}