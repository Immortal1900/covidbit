import 'package:flutter/material.dart';
class ChoiceOption extends StatefulWidget {
  @override
  _ChoiceOptionState createState() => _ChoiceOptionState();
}

class _ChoiceOptionState extends State<ChoiceOption> {
  List<String> stateNames=["All State","Andhra Pradesh","Arunachal Pradesh",'Assam',"Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: stateNames.length,
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
                    child: Text(stateNames[index],
                      style: TextStyle(
                          fontSize: 18.0
                      ),

                    ),
                  ),
                ],
              ),
              onTap: (){
                print(stateNames[index]);
                Navigator.of(context).pop();
              },
            );
          }
      ),),
    );
  }
}
