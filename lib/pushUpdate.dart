import 'package:covid19bitdurg/CovidStatus/choiceOptions.dart';
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

bool listcreated=false;
class Statestesteddata1{

  var statec;
  var status;
  Statestesteddata1({
    this.statec,
    this.status
    //this.dist
  });
  factory  Statestesteddata1.fromJson(Map<String, dynamic> Json) {
    return Statestesteddata1(
        statec: Json[setSeletedState.selectedstatecode],
        status:Json["status"]
    );
  }
}
class Statelist1 {
  final List<Statestesteddata1> std1;

  Statelist1({
    this.std1
  });
  factory  Statelist1.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['states_daily'] as List;
    print(list.runtimeType);
    List<Statestesteddata1> stateList1 = list.map((i) => Statestesteddata1.fromJson(i)).toList();
    return Statelist1(
        std1: stateList1
    );
  }
}

class Statestesteddata{
  //String title;
  var active;
  var confirmed;
  var deaths;
  var recovered;
  var state;

  Statestesteddata({
    this.active,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.state,
    //this.dist
  });
  factory  Statestesteddata.fromJson(Map<String, dynamic> Json) {
    return Statestesteddata(
        active: Json["active"],
        confirmed: Json["confirmed"],
        deaths: Json["deaths"],
        recovered: Json["recovered"],
        state: Json["state"]
    );
  }
}
class Statelist {
  final List<Statestesteddata> std;

  Statelist({
    this.std
  });
  factory  Statelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['statewise'] as List;
    print(list.runtimeType);
    List<Statestesteddata> stateList = list.map((i) => Statestesteddata.fromJson(i)).toList();
    return Statelist(
        std: stateList
    );
  }
}


class Covid19Status extends StatefulWidget {
  @override
  _Covid19StatusState createState() => _Covid19StatusState();
}

class _Covid19StatusState extends State<Covid19Status> {

  ScrollController _controller=ScrollController();
  void initState() {
    // TODO: implement initState
    print("SLECTED STATE IS ${setSeletedState.selectedstate}");
    getapi();
    super.initState();
  }
  void getapi() async {
    final response = await http.get("https://api.covid19india.org/data.json");
    final response1=await http.get("https://api.covid19india.org/states_daily.json");
    if (response.statusCode == 200) {
      var jsonresponce=await json.decode(response.body);
      Statelist shape = new Statelist.fromJson(jsonresponce);
      getSeletedData(shape);
      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
    if (response1.statusCode == 200) {
      var jsonresponce1=await json.decode(response1.body);
      Statelist1 shape1 = new Statelist1.fromJson(jsonresponce1);
      getSeletedData1(shape1);
      //setStates();
    } else {
      throw Exception('Failed to load data');
    }
  }
  void getSeletedData( Statelist shape) {
    shape.std.forEach((f){
      if(f.state.contains(setSeletedState.selectedstate)){
        print("ACTTIVE CASEE${f.active}");
        print("CONFIRMED CASEE${f.confirmed}");
        print("DEATHS CASEE${f.deaths}");
        print("RECOVERED CASEE${f.recovered}");
      }
    });
    //  print("LIST CREATED IS ${stategraphdata.positive}");
    listcreated=true;
  }
  void getSeletedData1( Statelist1 shape1) {
    print(shape1.std1.length);
    int a=shape1.std1.length;

    shape1.std1.forEach((f){
      if(f.status.contains("Confirmed")) {
        stateconfirmed(f.statec);
      }
      if(f.status.contains("Recovered")) {
        staterecoverd(f.statec);
      }
      if(f.status.contains("Deceased")) {
        statedeaths(f.statec);
      }
    });
    double k=0,p=0;
    for(int i=0;i<stateconfirmed.confirmed.length;i++){
      k=k+stateconfirmed.confirmed[i];
      p=p+staterecoverd.recovered[i];
      print("TOTAL TIL NOW ${k}");
      print(staterecoverd.recovered[i]);
      stateactive(k-p);
    }
    print("${stateactive.active}");
    stateactive.activecount=stateactive.active[stateactive.active.length-1];
    listcreated=true;
    print("${stateconfirmed.confirmed}");
    print(staterecoverd.recovered);
    print(statedeaths.deaths);

    setState(() {
      listcreated;
    });
    //  print("LIST CREATED IS ${stategraphdata.positive}");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Stack(

              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  child: ClipPath(
                    clipper: ClippingClass(),
                    child: Container(
                      height:MediaQuery.of(context).size.height*.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF3383CD),
                            Color(0xFF11249F),
                          ],

                        ),
                        image: DecorationImage(
                          image: AssetImage("Images/virus.png"),
                        ),

                      ),
                    ),


                  ),
                ),
                Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*.3,
                        child: SvgPicture.asset("SVG/Drcorona.svg",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("All you need",style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                          Text("is stay at home.",style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),)
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 250.0,
                    left: 8.0,
                    right: 8.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Chhattisgarh"),

                            IconButton(icon: Icon(Icons.arrow_drop_down),
                              color: Color(0xFFC73830),
                              onPressed: (){
                                //isStateCard=true;
                                //choiceState()
                                Navigator.of(context).push(new MaterialPageRoute<Null>(
                                  builder: (BuildContext context){
                                    return new ChoiceOption();
                                  },
                                ));

                              },)

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Chhattisgarh",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Color(0xFFC73830)
                              ),),
                            Text("Tested",
                              style: TextStyle(
                                  fontSize: 15.0
                              ),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Last Update On 23.05.2020",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),),
                              RichText(
                                  text: TextSpan(
                                      text: "1500",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      )
                                  )
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: Container(
                            //color: Colors.red,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                listcreated==true?      Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        // LineReportChart(),
                                        lineChart3(context, Color(0xFFFF8748)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: RichText(
                                                text: TextSpan(
                                                    text:stateconfirmed.confirmcount.toString(),
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color:  Color(0xFFFF8748),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFFFF8748),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFFFF8748)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child:
                                                RichText(
                                                  text: TextSpan(
                                                      text: "Confirmed",
                                                      style: TextStyle(
                                                          color:  Color(0xFFFF8748),
                                                          fontSize: 14
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ):      Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        // LineReportChart(),
                                        dummydata(context, Color(0xFFFF8748)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: RichText(
                                                text: TextSpan(
                                                    text: "0",
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color:  Color(0xFFFF8748),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFFFF8748),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFFFF8748)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child:
                                                RichText(
                                                  text: TextSpan(
                                                      text: "Confirmed",
                                                      style: TextStyle(
                                                          color:  Color(0xFFFF8748),
                                                          fontSize: 14
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                /********************CONFIRMED END****************/
                                listcreated==true? Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        lineChart4(context,Color(0xFFFF4848)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text: stateactive.activecount.toString(),
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color: Color(0xFFFF4848),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFFFF4848),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFFFF4848)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:RichText(
                                                    text: TextSpan(
                                                        text: "ACTIVE",
                                                        style: TextStyle(
                                                            color: Color(0xFFFF4848),
                                                            fontSize: 14
                                                        )
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ): Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        dummydata(context,Color(0xFFFF4848)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text: "0",
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color: Color(0xFFFF4848),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFFFF4848),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFFFF4848)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:RichText(
                                                    text: TextSpan(
                                                        text: "ACTIVE",
                                                        style: TextStyle(
                                                            color: Color(0xFFFF4848),
                                                            fontSize: 14
                                                        )
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                /*****************ATCIVE END*******************************/
                                listcreated==true?Container(
                                  height: 150,
                                  width: 130,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        lineChart2(context, Color(0xFF36C12C)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text:staterecoverd.recoverdcount.toString(),
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color: Color(0xFF36C12C),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFF36C12C),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFF36C12C)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:RichText(
                                                    text: TextSpan(
                                                        text: "Recovered",
                                                        style: TextStyle(
                                                            color: Color(0xFF36C12C),
                                                            fontSize: 14
                                                        )
                                                    ),
                                                  )

                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ):Container(
                                  height: 150,
                                  width: 130,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        dummydata(context, Color(0xFF36C12C)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text:"0",
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color: Color(0xFF36C12C),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFF36C12C),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFF36C12C)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:RichText(
                                                    text: TextSpan(
                                                        text: "Recovered",
                                                        style: TextStyle(
                                                            color: Color(0xFF36C12C),
                                                            fontSize: 14
                                                        )
                                                    ),
                                                  )

                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                /******************************DECEASED START**************/
                                Expanded(child:             listcreated==true? Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        lineChart1(context,Color(0xFFFF4848)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text: statedeaths.deathcount.toString(),
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color: Color(0xFFFF4848),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFFFF4848),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFFFF4848)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:RichText(
                                                    text: TextSpan(
                                                        text: "DECEASED",
                                                        style: TextStyle(
                                                            color: Color(0xFFFF4848),
                                                            fontSize: 14
                                                        )
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ): Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        dummydata(context,Color(0xFFFF4848)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text: "0",
                                                    style:
                                                    Theme.of(context).textTheme.title.copyWith(
                                                        color: Color(0xFFFF4848),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color:  Color(0xFFFF4848),width: 2.5 ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 10,
                                                        color:   Color(0xFFFF4848)
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 2.5,
                                                  backgroundColor: Colors.white,

                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:RichText(
                                                    text: TextSpan(
                                                        text: "DECEASED",
                                                        style: TextStyle(
                                                            color: Color(0xFFFF4848),
                                                            fontSize: 14
                                                        )
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                                /****************************DECEASED END*********************/

                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text("Bhilai",
                            ),
                            IconButton(icon: Icon(Icons.arrow_drop_down),
                              color: Colors.indigo,
                              onPressed: (){
                                Navigator.of(context).push(new MaterialPageRoute<Null>(
                                  builder: (BuildContext context){
                                    return new ChoiceOption();
                                  },
                                ));
                              },)

                          ],
                        ),
                        Text("Bhilai",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.indigo
                          ),),

                        Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: Container(
                            //color: Colors.red,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:  Color(0xFFFF4848),width: 5.0 ),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 10,
                                              color:   Color(0xFFFF4848)
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 5.0,
                                        backgroundColor: Colors.white,

                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: RichText(
                                            text: TextSpan(
                                                text: "20",
                                                style:
                                                Theme.of(context).textTheme.title.copyWith(
                                                    color: Color(0xFFFF4848),
                                                    fontWeight: FontWeight.bold
                                                )
                                            )
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Text("Active",
                                        style: TextStyle(
                                          color:  Color(0xFFFF4848),
                                        ),),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0xFF36C12C),width: 5.0 ),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 10,
                                              color:   Color(0xFF36C12C)
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 5.0,
                                        backgroundColor: Colors.white,


                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: RichText(
                                            text: TextSpan(
                                                text: "10",
                                                style:
                                                Theme.of(context).textTheme.title.copyWith(
                                                    color: Color(0xFF36C12C),
                                                    fontWeight: FontWeight.bold
                                                )
                                            )
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Text("Recovered",style: TextStyle(
                                          color: Color(0xFF36C12C)
                                      ),),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0xFFFF8748),width: 5.0 ),
                                        boxShadow: [

                                          BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 10,
                                              color:  Color(0xFFFF8748)
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 5.0,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: RichText(
                                            text: TextSpan(
                                                text: "100",
                                                style:
                                                Theme.of(context).textTheme.title.copyWith(
                                                    color:Color(0xFFFF8748),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
                                                )
                                            )
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Text("Confirmed",
                                        style: TextStyle(
                                            color: Color(0xFFFF8748)
                                        ),),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                ),
              ]
          ),
        ),
      ),


    );
  }
}



Widget lineChart1(BuildContext context,var color){
  return AspectRatio(
    aspectRatio: 2.2,
    child: LineChart(
        LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                  colors:[color],
                  spots: getSpots1(),
                  isCurved: true,
                  dotData:  FlDotData(show: false),
                  belowBarData: BarAreaData(show: false)

              )]
        )
    ),
  );
}
Widget lineChart2(BuildContext context,var color){
  return AspectRatio(
    aspectRatio: 2.2,
    child: LineChart(
        LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                  colors:[color],
                  spots: getSpots2(),
                  isCurved: true,
                  dotData:  FlDotData(show: false),
                  belowBarData: BarAreaData(show: false)

              )]
        )
    ),
  );
}
Widget lineChart4(BuildContext context,var color){
  return AspectRatio(
    aspectRatio: 2.2,
    child: LineChart(
        LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                  colors:[color],
                  spots: getSpots4(),
                  isCurved: true,
                  dotData:  FlDotData(show: false),
                  belowBarData: BarAreaData(show: false)

              )]
        )
    ),
  );
}
Widget lineChart3(BuildContext context,var color){
  return AspectRatio(
    aspectRatio: 2.2,
    child: LineChart(
        LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                  colors:[color],
                  spots: getSpots3(),
                  isCurved: true,
                  dotData:  FlDotData(show: false),
                  belowBarData: BarAreaData(show: false)

              )]
        )
    ),
  );
}
Widget dummydata(BuildContext context,var color){
  print("SHOWING DUMMY DTAT");
  return AspectRatio(
    aspectRatio: 2.2,
    child: LineChart(
        LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                  colors:[color],
                  spots: dummyspots(),
                  isCurved: true,
                  dotData:  FlDotData(show: false),
                  belowBarData: BarAreaData(show: false)

              )]
        )
    ),
  );
}
List<FlSpot> dummyspots(){
  return[
    FlSpot(0,.5),
    FlSpot(1,1.5),
    FlSpot(2,.5),
    FlSpot(3,.7),
    FlSpot(4,.2),
    FlSpot(5,1.5),
    FlSpot(6,1.5),
    FlSpot(7,1.7),
    FlSpot(8,1),
    FlSpot(9,2.8),
    FlSpot(10,2.65),
  ];
}

List<FlSpot> getSpots1(){
  List<FlSpot> lo=[];
  for(int i=0;i<statedeaths.deaths.length;i++){
    lo.add(FlSpot(i.toDouble(),statedeaths.deaths[i]));
  }
  return lo;
}
List<FlSpot> getSpots4(){
  List<FlSpot> lo=[];
  for(int i=0;i<stateactive.active.length;i++){
    lo.add(FlSpot(i.toDouble(),stateactive.active[i]));
  }
  return lo;
}
List<FlSpot> getSpots2(){
  List<FlSpot> lo=[];
  for(int i=0;i<staterecoverd.recovered.length;i++){
    lo.add(FlSpot(i.toDouble(),staterecoverd.recovered[i]));
  }

  return lo;
}
List<FlSpot> getSpots3(){
  List<FlSpot> lo=[];
  for(int i=0;i<stateconfirmed.confirmed.length;i++){
    lo.add(FlSpot(i.toDouble(),stateconfirmed.confirmed[i]));
  }
  return lo;
}


class ClippingClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}