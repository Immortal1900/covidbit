import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authservice.dart';
import '../setData.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _userid;
  String _userFirestName=" ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getuserid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
               child: new Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('Images/COVID19.jpg'),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Hello"+" "+"$_userFirestName"),
                     ),
                     Text("Welcome to COVID 19 Fighters App ")
                      ,RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                   color: Colors.orange,
                   child: Text('Signout'),
                     onPressed: () {
                          AuthService().signOut();
                          //print(_userFirestName);
                             print(_userid);
                          },
                                 ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height:45.0,
                                width: 45.0,
                                child: Image.asset('Images/bitdurglogo.png')),
                            Text("BIT DURG")
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

        )
    );
  }
  Future<String> _fatchlistcontent()async{
    Firestore.instance
        .collection('UserRecord')
        .document('$_userid')
        .get()
        .then((DocumentSnapshot ds) {
          setState(() {
            _userFirestName=ds.data['firstName'];
          });

          print("user first name is "+_userFirestName);
       
          return(_userFirestName);
    });}
  void _getuserid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      _userid=user.uid;
    });

    print("My user ID "+user.uid);
    _fatchlistcontent();


    // here you write the codes to input the data into firestore
  }
}

