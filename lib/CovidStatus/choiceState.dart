
import 'package:covid19bitdurg/CovidStatus/covidStatus.dart';
import 'package:covid19bitdurg/CovidStatus/getapidata.dart';
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ChoiceState extends StatefulWidget {

  @override
  _ChoiceStateState createState() => _ChoiceStateState();
}

class _ChoiceStateState extends State<ChoiceState> {
  List <String> stateitem=[
    "Andaman and Nicobar Islands",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli and Daman and Diu",
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
    "dn",
    "dl",
    "ga",
    "gj",
    "hr",
    "hp",
    "jk",
    "jh",
    "ka",
    "kl",
    "la",
    "ld",
    "mp",
    "mh",
    "mn",
    "ml",
    "mz",
    "nl",
    "or",
    "py",
    "pb",
    "rj",
    "sk",
    "tn",
    "tg",
    "tr",
    "up",
    "ut",
    "wb"
  ];
  List<String>stateiteam=[];
  int stateListCount;
  @override
  void initState() {
    // TODO: implement initState
    stateiteam.addAll(stateitem);
    stateListCount=stateiteam.length;
   // getfirstdistrict();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select State"),
        backgroundColor: Color(0xFF004272),
      ),
      body: Container(
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
                hintText: "Enter State Name",
              ),

            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: stateListCount,
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
                          child: Text(stateiteam[index],
                            style: TextStyle(
                                fontSize: 18.0
                            ),

                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      print(stateiteam[index]);
                      print(stateitem.length);
                      print(statecode.length);
                      setSeletedState.selectedstate=stateiteam[index];
                      setSeletedState.selectedstatecode=statecode[index];
                      print("SELECTED STATENAME ${setSeletedState.selectedstate}");
                      print("SELECTED STATECODE ${setSeletedState.selectedstatecode}");
                      await getSeletedData(shape);
                      Statelist1 s = new Statelist1.fromJson(jsonresponce1);
                      getSeletedData1(s);
                      //getSeletedData2(shape2);
                      districtselected=false;
                      getSeletedData3(shape3);
                      setState(() {

                      });
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

  void searchdistlist(String query) {
    String takequery= query.isNotEmpty?('${query[0].toUpperCase()}${query.substring(1)}'):null;
    print(takequery);
    List<String> dummydistList = [];
    dummydistList.addAll(stateitem);
    if (query.isNotEmpty) {
      print("enter");
      List<String> dummyDistData = [];
      dummydistList.forEach((item) {
        if (item.contains(takequery)) {
          dummyDistData.add(item);
        }
      });
      setState(() {
        stateiteam.clear();
        stateiteam.addAll(dummyDistData);
        stateListCount=stateiteam.length;
      });
      return;
    } else {
      setState(() {
        print("notEnter");
        stateiteam.clear();
        stateiteam.addAll(stateitem);
        stateListCount=dummydistList.length;
      });
    }
  }
}

