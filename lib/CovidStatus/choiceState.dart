
import 'package:flutter/material.dart';
class ChoiceState extends StatefulWidget {

  @override
  _ChoiceStateState createState() => _ChoiceStateState();
}

class _ChoiceStateState extends State<ChoiceState> {
  List<String> stateNames=["Andhra Pradesh","Arunachal Pradesh",'Assam',"Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
  List<String>stateiteam=[];
  int stateListCount;
  @override
  void initState() {
    // TODO: implement initState
    stateiteam.addAll(stateNames);
    stateListCount=stateiteam.length;
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
                    onTap: (){
                      print(stateiteam[index]);
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
    dummydistList.addAll(stateNames);
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
        stateiteam.addAll(stateNames);
        stateListCount=dummydistList.length;
      });
    }
  }
}

