

import 'package:covid19bitdurg/Admin/adminDashboard.dart';
import 'package:covid19bitdurg/Users/submit.dart';
import 'package:covid19bitdurg/Users/suspectedIndputForm.dart';
import 'package:covid19bitdurg/Users/userinputform.dart';
import 'package:covid19bitdurg/jasondata.dart';
import 'package:covid19bitdurg/pushUpdate.dart';
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
        //AuthService().handleAuth(),
        //PushFirebase()
     //UserInputForm()
      SuspectedForm(),
        //AdminDashboard(),
        //SubmitForm(),

        //MainFetchData()

      routes: <String, WidgetBuilder> {
      '/SuspectedForm': (BuildContext context) => SuspectedForm(),
        '/UserForm':(BuildContext context) => RepoterForm(),
        '/Submit':(BuildContext context) => SubmitForm(),
    '/Admin Dashboard':(BuildContext context) => AdminDashboard()



    },

    );
  }
}
