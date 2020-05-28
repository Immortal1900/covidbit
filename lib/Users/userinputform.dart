import 'dart:convert';

import 'package:covid19bitdurg/setData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RepoterForm extends StatefulWidget {
  @override
  _RepoterFormState createState() => _RepoterFormState();
}

class _RepoterFormState extends State<RepoterForm> {

  List<String>state=[];
  List<String>stateiteam=[];
  List<String>district=[];
  List<String>districtiteam=[];
  List<String>city=[];
  List<String>cityiteam=[];

  String selectedState;
  String selectedCity;
  String selectedDist;
  String selectedAdd;
  String selectedfirestName;
  String selectedlastname;

  int stateListCount=0;
  int disListCount=0;
  int cityListCount=0;

  bool isStateSearbox=false;
  bool isDistSearcbox=false;
  bool isCitySearcbox=false;
  bool isDisTextField=false;
  bool isCityTextField=false;
  bool isButPressed=false;

  TextEditingController _statecontroller=TextEditingController();
  TextEditingController _distController=TextEditingController();
  TextEditingController _cityController=TextEditingController();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  List<Data> list = List();
  var isLoading = false;
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
      setStates();
    } else {
      throw Exception('Failed to load photos');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Details"),
        backgroundColor: Color(0xFF004272),
        centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.home),
              onPressed: (){

              },)
          ]
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 8.0,bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10.0,


                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.green,
                          height: 5,
                          //color: Colors.indigo,

                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10.0,

                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 5,
                          //color: Colors.indigo,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.horizontal(left:  Radius.circular(10),right:Radius.circular(10)),

                              border: Border.all(width: 1,color: Colors.grey )
                          ),

                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 10.0,

                      ),
                    ],
                  ),
                ),
                isButPressed==false?Container():selectedfirestName==null?Text("* Please fill in the below fields",
                  style: TextStyle(
                      color: Colors.red
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),

                      labelText: "First Name",
                      hintText: "First Name",
                    ),

                    onChanged: (value){
                      setState(() {
                        selectedfirestName=value;

                      });
                    },

                  ),
                ),
                isButPressed==false?Container():selectedlastname==null?Text("* Please fill in the below fields",
                  style: TextStyle(
                      color: Colors.red
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),

                      labelText: "Last Name",
                      hintText: "Last Name",
                    ),

                    onChanged: (value){
                      setState(() {
                        selectedlastname=value;

                      });
                    },

                  ),
                ),
                isButPressed==false?Container():selectedState==null?Text("* Please fill in the below fields",
                  style: TextStyle(
                      color: Colors.red
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: TextField(
                    controller: _statecontroller,
                    onChanged: (value) {

                      searchList(value);
                    },
                    //controller: editingController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),

                      labelText: "State",
                      hintText: "Enter State Name",
                    ),

                  ),
                ),

                isStateSearbox?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder
                      (
                        itemCount:stateListCount,
                        itemBuilder: (BuildContext context, int index) {
                          return  GestureDetector(
                              onTap: (){
                                print(stateiteam[index]);
                                _statecontroller.text=stateiteam[index];
                                setState(() {
                                  isStateSearbox=false;
                                  selectedState=stateiteam[index];
                                  isDisTextField=true;

                                });
                                setDistrict();
                              },
                              child: Text(stateiteam[index])
                          );
                        }
                    ),
                  ),
                ):Container(),
                isButPressed==false?Container():selectedDist==null?Text("* Please fill in the below fields",
                  style: TextStyle(
                      color: Colors.red
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: TextField(
                    controller: _distController,
                    enabled: isDisTextField,
                    onChanged: (value) {

                      searchdistlist(value);
                    },
                    //controller: editingController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
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
                isDistSearcbox?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder
                      (
                        itemCount:disListCount,
                        itemBuilder: (BuildContext context, int index) {
                          return  GestureDetector(
                              onTap: (){
                                print(districtiteam[index]);
                                _distController.text=districtiteam[index];
                                setState(() {
                                  isDistSearcbox=false;
                                  selectedDist=districtiteam[index];
                                  isCityTextField=true;

                                });
                                setCity();
                              },
                              child: Text(districtiteam[index])
                          );
                        }
                    ),
                  ),
                ):Container(),
                isButPressed==false?Container():selectedCity==null?Text("* Please fill in the below fields",
                  style: TextStyle(
                      color: Colors.red
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: TextField(
                    controller: _cityController,
                    enabled: isCityTextField,
                    onChanged: (value) {
                      setState(() {
                        selectedCity=value;
                      });
                      searchCitylist(value);
                    },
                    //controller: editingController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),

                      labelText: "City",
                      hintText: "Enter City Name",
                    ),

                  ),
                ),
                isCitySearcbox?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder
                      (
                        itemCount:cityListCount,
                        itemBuilder: (BuildContext context, int index) {
                          return  GestureDetector(
                              onTap: (){
                                print(cityiteam[index]);
                                _cityController.text=cityiteam[index];
                                setState(() {
                                  isCitySearcbox=false;
                                  selectedCity=cityiteam[index];

                                });
                              },
                              child: Text(cityiteam[index])
                          );
                        }
                    ),
                  ),
                ):Container(),
                isButPressed==false?Container():selectedlastname==null?Text("* Please fill in the below fields",
                  style: TextStyle(
                      color: Colors.red
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                  child: TextField(
                    maxLines: 5,
                    onTap: (){
                      setState(() {
                        isCitySearcbox=false;
                      });

                    },
                    onChanged: (value) {
                      selectedAdd=value;

                    },
                    //controller: editingController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),

                      labelText: "Address",
                      hintText: "Ente Address",
                    ),

                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text("Submit"),
                  onPressed: (){
                    SetData.reporterFirstName=selectedfirestName;
                    SetData.reporterLastName=selectedfirestName;
                    SetData.reporterState= selectedState;
                    SetData.reporterDis= selectedDist;
                    SetData.reporterCity= selectedCity;
                    SetData.reporterAddress= selectedAdd;
                    setState(() {
                      isButPressed=true;
                    });
                    if(selectedCity!=null&&selectedAdd!=null&&selectedDist!=null&&selectedState!=null&&selectedlastname!=null&&selectedlastname!=null)
                    Navigator.of(context).pushNamed('/Submit');

                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
  void searchList(String query) {
    String takequery= query.isNotEmpty?('${query[0].toUpperCase()}${query.substring(1)}'):null;
    print(takequery);
    List<String> dummystateList = [];
    dummystateList.addAll(state);
    if (query.isNotEmpty) {
      print("enter");
      List<String> dummystateData = [];
      dummystateList.forEach((item) {
        if (item.contains(takequery)) {
          setState(() {
            isStateSearbox=true;
          });
          dummystateData.add(item);
        }
      });
      setState(() {
        stateiteam.clear();
        stateiteam.addAll(dummystateData);
        stateListCount=stateiteam.length;
      });
      return;
    } else {
      setState(() {
        print("notEnter");
        stateiteam.clear();
        stateiteam.addAll(state);
        stateListCount=stateiteam.length;
        isStateSearbox=false;
      });
    }
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
          setState(() {
            isDistSearcbox=true;
          });
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
        isStateSearbox=false;
      });
    }
  }
  void searchCitylist(String query) {
    String takequery= query.isNotEmpty?('${query[0].toUpperCase()}${query.substring(1)}'):null;
    print(takequery);
    List<String> dummyCityList = [];
    dummyCityList.addAll(city);
    if (query.isNotEmpty) {
      print("enter");
      List<String> dummyCityData = [];
      dummyCityList.forEach((item) {
        if (item.contains(takequery)) {
          setState(() {
            isCitySearcbox=true;

          });

          dummyCityData.add(item);
        }

      });
      setState(() {
        cityiteam.clear();
        cityiteam.addAll(dummyCityData);
        cityListCount=cityiteam.length;
      });
      return;
    } else {
      setState(() {
        print("notEnter");
        cityiteam.clear();
        cityiteam.addAll(city);
        cityListCount=dummyCityList.length;
        isCitySearcbox=false;
      });
    }
  }

  void setStates() async{
    list.forEach((f){
      setState(() {
        state.add(f.state);
        stateiteam.add(f.state);
      });

    });
    setState(() {
      isLoading=false;
      state=state.toSet().toList();
      stateiteam=stateiteam.toSet().toList();
      stateListCount=stateiteam.length;
      print("length");
      print(state.length);

    });
  }
  void setDistrict() async{
    list.forEach((f){
      if(f.state.contains(selectedState))
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
      });
      print(districtiteam);


    });

  }
  void setCity() async{
    list.forEach((f){
      if(f.dist.contains(selectedDist))
      {
        setState(() {
          city.add(f.title);
          cityiteam.add(f.title);

        });
      }
      setState(() {
        city=city.toSet().toList();
        cityiteam=cityiteam.toSet().toList();
        cityListCount=city.length;
      });
      print(city);


    });

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