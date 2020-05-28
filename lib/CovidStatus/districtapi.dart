import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChoiceDistrict extends StatefulWidget {
  @override
  _ChoiceDistrictState createState() => _ChoiceDistrictState();
}

class _ChoiceDistrictState extends State<ChoiceDistrict> {
 List<String>district = [];
  List<String>districtiteam = [];
  bool isLoading = true;
  int disListCount;

  @override
  void initState() {
    // TODO: implement initState
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select District"),
        backgroundColor: Color(0xFF004272),
      ),
      body: Container()
    );
  }

  _fetchData() async {
    String jsonString = await rootBundle.loadString(
        'lib/states-and-districts.json');
    final jsonResponse = json.decode(jsonString);
    Structure1 sh = new Structure1.fromJson(jsonResponse);
    print("????????????????????????????");

    print(sh.std[0].district);
  }

/*void setDistrict() async{
    list.forEach((f){
      if(f.state.contains(setSeletedState.selectedstate))
      {
        setState(() {
          district.add(f.dist);
          districtiteam.add(f.dist);
        });
      }
      setState(() {
        district=district.toSet().toList();
        districtiteam=districtiteam.toSet().toList();
        disListCount=district.length;
        isLoading=false;
      });

      // print(districtiteam);


    });

  }*/ /*
  void searchdistlist(String query) {
    String takequery= query.isNotEmpty?('${query[0].toUpperCase()}${query.substring(1)}'):null;
    print(takequery);
    List<String> dummydistList = [];
    dummydistList.addAll(district);
    if (query.isNotEmpty) {
      print("enter");
      List<String> dummyDistData = [];
      dummydistList.forEach((item) {
        if (item.contains(takequery)) {
          dummyDistData.add(item);
        }
      });
      setState(() {
        districtiteam.clear();
        districtiteam.addAll(dummyDistData);
        disListCount=districtiteam.length;
      });
      return;
    } else {
      setState(() {
        print("notEnter");
        districtiteam.clear();
        districtiteam.addAll(district);
        disListCount=dummydistList.length;
      });
    }
  }
}*/
}
class Structure1 {
  final List<Structure2> std;

  Structure1({
    this.std
  });
  factory  Structure1.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['states'] as List;
    print("**************");

    List<Structure2> stateList = list.map((i) => Structure2.fromJson(i)).toList();
    return Structure1(
        std: stateList
    );
  }
}
class Structure2{
  //String title;
  var state;
  List <dynamic> district;
  // final List<String> district;

  Structure2({
    this.state,
    this.district
  });
  factory  Structure2.fromJson(Map<String, dynamic> Json) {
    return Structure2(
      state: Json["state"],
      district:Json["districts"]
    );
  }
}