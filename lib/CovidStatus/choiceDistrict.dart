import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class ChoiceDistrict extends StatefulWidget {
  @override
  _ChoiceDistrictState createState() => _ChoiceDistrictState();
}

class _ChoiceDistrictState extends State<ChoiceDistrict> {
  //List<String> stateNames=["All State","Andhra Pradesh","Arunachal Pradesh",'Assam',"Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
  List<String>district=[];
  List<String>districtiteam=[];
  bool isLoading=true;
  List<Data> list = List();
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
                      onTap: (){
                        print(district[index]);
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
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://indian-cities-api-nocbegfhqg.now.sh/cities");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Data.fromJson(data))
          .toList();
      setDistrict();
    } else {
      throw Exception('Failed to load photos');
    }
  }
  void setDistrict() async{
    list.forEach((f){
      if(f.state.contains("Chhattisgarh"))
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

  }
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
}
class Data {
  final String title;
  final String state;
  final String dist;
  Data._({this.title,this.state,this.dist});
  factory Data.fromJson(Map<String, dynamic> json) {
    return new Data._(
      title: json['City'],
      state: json['State'],
      dist: json['District'],

    );
  }
}
