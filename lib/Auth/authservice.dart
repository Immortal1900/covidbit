
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../setData.dart';
import 'dashboard.dart';
import 'loginPage.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
              return DashboardPage();
          } else {
            return LoginPage();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) async{
    CircularProgressIndicator();
    await FirebaseAuth.instance.signInWithCredential(authCreds);
    _getuserid();



  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
    
  }
  void _getuserid() async {
    final FirebaseUser user = await auth.currentUser();
    SetData.userId = user.uid;
    print("i am in geruserid"+user.uid);
    _createUserRecord(user.uid);


    // here you write the codes to input the data into firestore
  }
  void  _createUserRecord(String takeuserid) async {
    await Firestore.instance
        .collection('UserRecord').document('$takeuserid').
    setData({
      "firstName": '${SetData.userfirstname}',
      "lastName":'${SetData.userlastname}',
      "phoneNum":'${SetData.userPhoneNum}'

    });
    print("++++++++++++++++++++++++++++++++++++++"+"$takeuserid");

  }
}