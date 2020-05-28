import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'dart:convert';
import 'package:covid19bitdurg/CovidStatus/covidStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'getapidata.dart';

class ChoiceDistrict extends StatefulWidget {
  @override
  _ChoiceDistrictState createState() => _ChoiceDistrictState();
}

class _ChoiceDistrictState extends State<ChoiceDistrict> {
  List<dynamic>district = [];
  List<dynamic>districtiteam = [];
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
      body: isLoading?Center(child: CircularProgressIndicator(),):Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                //controller: _distController,
                onChanged: (value) {
                  searchdistlist(value);
                },
                //controller: editingController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),

                  labelText: "District",
                  hintText: "Enter District Name",
                ),

              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: disListCount,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.green,width: 2.5 ),
                              ),
                              child: CircleAvatar(
                                radius: 2.5,
                                backgroundColor: Colors.white,

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(districtiteam[index],
                              style: TextStyle(
                                  fontSize: 18.0
                              ),

                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        print(district[index]);
                        districtData.districtname=districtiteam[index];

                        print("STATE IS ${setSeletedState.selectedstate}");
                        print("DISTRICT IS ${districtData.districtname}");
                        districtselected=true;
                        await getSeletedData2();
                        Navigator.of(context).pop();

                      },
                    );
                  }

              ),
            ),
          ],
        ),),
    );
  }

  _fetchData() async {
    String jsonString = await rootBundle.loadString(
        'lib/states-and-districts.json');
    final jsonResponse = json.decode(jsonString);
    Structure1 sh = new Structure1.fromJson(jsonResponse);
    print("????????????????????????????");
    print(sh.std[0].district);
    setDistrict(sh);
  }

  void setDistrict( Structure1 sh) async{
    sh.std.forEach((f){
      if(f.state.contains(setSeletedState.selectedstate))
      {

        setState(() {
          district=f.district.toList();
          districtiteam=f.district.toList();
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

  }
  void searchdistlist(String query) {
    String takequery= query.isNotEmpty?('${query[0].toUpperCase()}${query.substring(1)}'):null;
    print(takequery);
    List<dynamic> dummydistList = [];
    dummydistList.addAll(district);
    if (query.isNotEmpty) {
      print("enter");
      List<dynamic> dummyDistData = [];
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