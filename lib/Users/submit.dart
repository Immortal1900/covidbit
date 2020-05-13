import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19bitdurg/setData.dart';
import 'package:flutter/material.dart';

class SubmitForm extends StatefulWidget {
  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  bool isSubmited=false;
  @override
  void initState() {
    // TODO: implement initState
    uploadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 8.0,bottom: 8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10.0,

                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 5,
                          //color: Colors.indigo,
                         color: Colors.green,

                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10.0,

                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 5,
                          //color: Colors.indigo,
                          color: Colors.green,

                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10.0,

                      ),
                    ],
                  ),
                ),

                   Padding(
                     padding: const EdgeInsets.only(top:250.0),
                     child: isSubmited?
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Text("submited successfully"),
                             Icon(Icons.check ,size: 50,color: Colors.indigo,),
                           ],
                         ),
                         RaisedButton(
                           color: Colors.green,
                           child: Text("Report another person"),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)
                           ),
                           onPressed: (){
                             Navigator.of(context).pushNamedAndRemoveUntil('/SuspectedForm', ModalRoute.withName('/SuspectedForm'));
                           },
                         )
                       ],
                     )
                         :CircularProgressIndicator(),
                   ),


              ],
            ),

          ),
        ),
      ),

    );

  }
  uploadData()async{
    await Firestore.instance.collection("Reports").document().setData({
     'suspectedFirstName':SetData.suspectedFirstName,
     'suspectedLastName':SetData.suspectedLastName,
    'suspectedAddress':SetData.suspectedAddress,
    'suspectedCity':SetData.suspectedCity,
   'suspectedState':SetData.suspectedState,
    'suspecteddDis':SetData.suspecteddDis,

   'reporterFirstName':SetData.reporterFirstName,
    'reporterLastName':SetData.reporterLastName,
     'reporterAddress':SetData.reporterAddress,
     'reporterCity':SetData.reporterCity,
     'reporterState':SetData.reporterState,
     'reporterDis':SetData.reporterDis,

      'timeStamp': FieldValue.serverTimestamp()

    });
    setState(() {
      isSubmited=true;
    });

  }


}
