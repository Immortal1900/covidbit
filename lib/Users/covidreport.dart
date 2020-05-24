import 'dart:convert';
import 'package:covid19bitdurg/CovidStatus/Statewise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid19bitdurg/SetData/Setdata.dart';
String SelectedState;
var jsondecoded;
class CovidReports extends StatefulWidget {
  @override
  _CovidReportsState createState() => _CovidReportsState();
}
class _CovidReportsState extends State<CovidReports> {
String SelectedState;

List <String> states=["Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  "Uttar Pradesh",
  "West Bengal",
  "Andaman and Nicobar Islands",
  "Chandigarh",
  "Dadra and Nagar Haveli",
  "Daman and Diu",
  "Delhi",
  "Lakshadweep",
  "Puducherry"];
@override
  void initState() {
    // TODO: implement initState
  _fetchData();
    super.initState();
  }
  @override
  var isLoading = false;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });


    final response = await http.get("https://api.covid19india.org/state_district_wise.json");
    if (response.statusCode == 200) {
      var jsonresponce=await json.decode(response.body);
      jsondecoded=jsonresponce;
      print("JSON DECDED IS$jsondecoded");
      Shape shape = new Shape.fromJson(jsonresponce);
     // print(jsonresponce);

     // print("Statecode:"+"${shape.statecode}");
      //print("confirmed:"+"${shape.stateUuassigned.districtData.unassigned.confirmed}");
     // print("recovered:"+"${shape.stateUuassigned.districtData.unassigned.recovered}");
     // print("deceased:"+"${shape.stateUuassigned.districtData.unassigned.deceased}");

      setState(() {
        isLoading=false;
      });


      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
  }
  /*void setStates() async{
    list.forEach((f){
      setState(() {
        state.add(f.state);
      });
    });
    print(state);
    isLoading=false;
  }*/
Widget projectWidget() {
  return FutureBuilder(
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return Center(
         child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: ListView.builder(
              itemCount: states.length,
              itemBuilder: (context, index) {
                return Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 30,
                    child:Card(

                        child:InkWell(
                          onTap:  (){
                            setSeletedState.selectedstate=states[index];
                            print(setSeletedState.selectedstate);
                            Navigator.push(context,MaterialPageRoute(builder: (context) => statewise()));
                          },
                          child: Text(states[index],
                          textAlign: TextAlign.center,),
                        )
                    )
                );
              },
            ),
          )
      );
    },

  );
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satte wise COVID Report"),
      ),
      body:  projectWidget()
    );
  }

}


class Shape{
  StateUnassigned stateUuassigned;
  Statecode statecode;
  Shape({
    this.stateUuassigned,
  });
  factory Shape.fromJson(Map<String, dynamic> parsedJson) {
    return Shape(
      stateUuassigned:StateUnassigned.fromJson(parsedJson['State Unassigned']),

       // districtData: DistrictData.fromJson(parsedJson['districtData'])
    );
  }
}
class Statecode{

  String statecode;
  Statecode({

    this.statecode,
  });
  factory  Statecode.fromJson(Map<String, dynamic> Json) {
    return Statecode(
          statecode: Json['statecode']
      // districtData: DistrictData.fromJson(parsedJson['districtData'])
    );
  }
}
class StateUnassigned{
   //String title;
   String statecode;
   DistrictData districtData;
 //  String dist;
   StateUnassigned({
    //this.title,
    this.statecode,
     this.districtData
    //this.dist
  });
  factory  StateUnassigned.fromJson(Map<String, dynamic>parsedJson) {
    return  StateUnassigned(

        districtData: DistrictData.fromJson(parsedJson['districtData'])

    );
  }

}

class DistrictData{
  //String title;
  Unassigned unassigned;
  //  String dist;
  DistrictData({
    //this.title,
    this. unassigned,
    //this.dist
  });
  factory  DistrictData.fromJson(Map<String, dynamic> parsedJson) {
    return DistrictData(
      //title: json['City'],
      //state: parsedJson["id"],
      //dist: json['District'],
        unassigned: Unassigned.fromJson(parsedJson['Unassigned'])

    );
  }
}
class Unassigned{
  //String title;
  int active;
  int confirmed;
  int deceased;
  int recovered;

  //  String dist;
  Unassigned({
    //this.title,
    this.active,
    this.confirmed,
    this.deceased,
    this.recovered
    //this.dist
  });
  factory  Unassigned.fromJson(Map<String, dynamic> Json) {
    return  Unassigned(
      //title: json['City'],
      //state: parsedJson["id"],
      //dist: json['District'],
        active: Json["active"],
        confirmed: Json["confirmed"],
        deceased: Json['deceased'],
         recovered: Json['recovered']
    );
  }
}