

import 'package:covid19bitdurg/Admin/adminDashboard.dart';

import 'package:covid19bitdurg/CovidStatus/choiceDistrict.dart';


import 'package:covid19bitdurg/CovidStatus/covidStatus.dart';
import 'package:covid19bitdurg/CovidStatus/stateDetail.dart';
import 'package:covid19bitdurg/Users/submit.dart';
import 'package:covid19bitdurg/Users/suspectedIndputForm.dart';
import 'package:covid19bitdurg/Users/userinputform.dart';
import 'package:flutter/material.dart';
import 'Auth/authservice.dart';





void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home:
        //statewise(),
        //CovidReports(),
        //MainFetchData(),
        //AuthService().handleAuth(),
        //PushFirebase()
       //SuspectedForm(),
         //AdminDashboard(),
        //SubmitForm(),
        //CovidReports(),
      Covid19Status(),
        //StateDetail(),
        //RepoterForm(),
        //
      //  Check(),

      routes: <String, WidgetBuilder> {
      '/SuspectedForm': (BuildContext context) => SuspectedForm(),
        '/UserForm':(BuildContext context) => RepoterForm(),
        '/Submit':(BuildContext context) => SubmitForm(),
     '/Admin Dashboard':(BuildContext context) => AdminDashboard(),
        '/CovidStatus':(BuildContext context) => Covid19Status(),


    },

    );
  }
}
