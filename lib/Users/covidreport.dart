import 'dart:convert';
import 'package:covid19bitdurg/CovidStatus/Statewise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:covid19bitdurg/CovidStatus/statedetail.dart';
String SelectedState;
var jsondecoded;
class CovidReports extends StatefulWidget {
  @override
  _CovidReportsState createState() => _CovidReportsState();
}
class _CovidReportsState extends State<CovidReports> {
String SelectedState;
List <String> states=[
"Andaman and Nicobar Islands",
"Andhra Pradesh",
"Arunachal Pradesh",
"Assam",
"Bihar",
"Chandigarh",
"Chhattisgarh",
"Dadra and Nagar Haveli",
"Daman and Diu",
"Delhi",
"Goa",
"Gujarat",
"Haryana",
"Himachal Pradesh",
"Jammu and Kashmir",
"Jharkhand",
"Karnataka",
"Kerala",
"Ladakh",
"Lakshadweep",
"Madhya Pradesh",
"Maharashtra",
"Manipur",
"Meghalaya",
"Mizoram",
"Nagaland",
"Odisha",
"Puducherry",
"Punjab",
"Rajasthan",
"Sikkim",
"Tamil Nadu",
"Telangana",
"Tripura",
"Uttar Pradesh",
"Uttarakhand",
"West Bengal"
];

List <String> statecode=[
  "an",
  "ap",
  "ar",
  "as",
  "br",
  "ch",
  "ct",
  "dd",
  "dl",
  "dn",
  "ga",
  "gj",
  "hp",
  "hr",
  "jh",
  "jk",
  "ka",
  "kl",
  "la",
  "ld",
  "mh",
  "ml",
  "mn",
  "mp",
  "mz",
  "nl",
  "or",
  "pb",
  "py",
  "rj",
  "sk",
  "tg",
  "tn",
  "tr",
  "tt",
  "un",
  "up",
  "ut",
  "wb"
];
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
                            setSeletedState.selectedstatecode=statecode[index];
                            print(setSeletedState.selectedstate);
                            print(setSeletedState.selectedstatecode);
                            Navigator.push(context,MaterialPageRoute(builder: (context) => statedetail()));
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