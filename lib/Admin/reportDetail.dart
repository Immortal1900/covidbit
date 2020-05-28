import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReortDetail extends StatefulWidget {
  @override
  _ReortDetailState createState() => _ReortDetailState();
}

class _ReortDetailState extends State<ReortDetail> {
  @override
  Widget build(BuildContext context) {
    final String reportDocID = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Detail"),
        centerTitle: true,
        backgroundColor: Color(0xFF004272),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){

            },
          )
          ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Reports').document(
            reportDocID).snapshots(),
    builder: (BuildContext context, snapshot) {
         if(snapshot.hasData){
          // DocumentSnapshot d = snapshot.data;
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*.07,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.red,
                                Colors.orange
                              ],

                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('SVG/nurse.svg'),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Details', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                  text: "Suspected\n",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )
                              ),
                            )],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person,
                        color: Colors.red),
                        SizedBox(width: 5.0),
                        Text("Name: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),
                        Text(snapshot.data['suspectedFirstName']+" "+snapshot.data['suspectedLastName'],style: TextStyle(
                          fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place,
                        color: Colors.red,),
                        SizedBox(width: 5.0),
                        Text("State: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['suspectedState'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.home,
                            color: Colors.red),
                        SizedBox(width: 5.0),
                        Text("District: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['suspecteddDis'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place,
                            color: Colors.red),
                        SizedBox(width: 5.0),
                        Text("City: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['suspectedCity'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.event_note,
                            color: Colors.red),
                        SizedBox(width: 5.0),
                        Text("Address: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['suspectedAddress'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*.07,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.greenAccent,
                                Colors.green
                              ],

                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(text: 'Details', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                      text: "Reporter\n",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )
                                  ),


                              ),
                              new Expanded(child: SvgPicture.asset('SVG/paramedic.svg')),
                              //SvgPicture.asset('SVG/erlandh_Smartphone_Excitement.svg'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person,
                            color: Colors.green),

                        SizedBox(width: 5.0),
                        Text("Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['reporterFirstName']+" "+snapshot.data['reporterLastName'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place,
                            color: Colors.green),
                        SizedBox(width: 5.0),
                        Text("State: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['reporterState'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.home,
                            color: Colors.green),
                        SizedBox(width: 5.0),
                        Text("District: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['reporterDis'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place,
                            color: Colors.green),
                        SizedBox(width: 5.0),
                        Text("City: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['reporterCity'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.event_note,
                            color: Colors.green),
                        SizedBox(width: 5.0),
                        Text("Address: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        Text(snapshot.data['reporterAddress'],style: TextStyle(
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.indigoAccent,
                                  Color(0xFF004272)
                                ],

                              ),
                            ),
                            child: FlatButton(
                              child: Text("Delete Report",
                              style: TextStyle(
                                color: Colors.white
                              ),),
                              onPressed: (){

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )


                ],
              ),
            );
          }
         else {
           return Center(child: CircularProgressIndicator());
         }

    }
      ),
    );
  }
}
