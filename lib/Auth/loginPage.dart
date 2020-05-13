import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../setData.dart';

import 'authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;
 // TextEditingController _firstnameController = TextEditingController();
  //TextEditingController _lastnameController = TextEditingController();

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('Images/COVID19.jpg'),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 8.0),
                    child: TextField(

                      decoration: InputDecoration(
                          labelText: "First Name",
                          hintText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                      onChanged: (value){
                        setState(() {
                          SetData.userfirstname=value;


                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)))),

                      onChanged: (value){
                        setState(() {
                          SetData.userlastname=value;

                        });
                      },

                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 8.0,bottom: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Enter phone number',
                        prefixText: "+91"),
                        onChanged: (val) {
                          setState(() {
                            this.phoneNo = "+91"+"$val";
                            SetData.userPhoneNum= "+91"+"$val";
                          });
                        },
                      )),
                  codeSent ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Enter OTP'),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;

                          });
                        },
                      )) : Container(),
                  Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                          color: Colors.green,
                          child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                          onPressed: () {
                            codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                          })),
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
            )),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 1),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }


}