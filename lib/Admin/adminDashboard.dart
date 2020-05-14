import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../drawer.dart';
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<String>suspectedFirstName=[];
  List<String>suspectedState=[];
  List<String>suspectedDist=[];
  List<String>suspectedCity=[];
  
  int totalReports=0;


  @override
  void initState() {
    fatchData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      drawer: Draw(context),
      body: suspectedCity.length!=totalReports?Center(child: CircularProgressIndicator()):Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Total Reports:",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text("$totalReports",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  )


                ],
              ),
              Divider(
                color: Colors.black,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: totalReports,
                  itemBuilder: (context, index) {
                    return cardview(suspectedState[index],suspectedDist[index],suspectedCity[index]);
                  }

              )
            ],
          ),
        ),
      ),

    );

  }
  Widget cardview(String state,String dist,String city) {
    return Container(
        child: new Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: new EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 6.0),
            elevation: 10.0,
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  setState(() {
                    //SetData.psotUid=postUid;
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("State:",style: TextStyle(

                            fontSize: 18
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text("$state",style: TextStyle(

                                fontSize: 18
                            )),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("District:",style: TextStyle(

                              fontSize: 18
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text("$dist",style: TextStyle(

                                fontSize: 18
                            )),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("City:",style: TextStyle(

                              fontSize: 18
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text("$city",style: TextStyle(

                                fontSize: 18
                            )),
                          )
                        ],
                      )
                    ],
                  )
                )
            )
        )

    );
  }
  fatchData()async{
    try {
      await Firestore.instance.collection("Reports").orderBy("timeStamp",descending: true).getDocuments().then((
          onValue) {
        setState(() {
          totalReports = onValue.documents.length;
        });
        onValue.documents.forEach((f) {
          setState(() {
            suspectedState.add(f.data["suspectedState"]);
            suspectedDist.add(f.data['suspecteddDis']);
            suspectedCity.add(f.data[ 'suspectedCity']);
           

          });
        });
      });
    }
    catch(e){
      print(e);
    }

  }



}
