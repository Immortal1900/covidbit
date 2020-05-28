import 'package:covid19bitdurg/CovidStatus/choiceDistrict.dart';
import 'package:covid19bitdurg/CovidStatus/choiceState.dart';
import 'package:covid19bitdurg/SetData/Setdata.dart';
import 'package:covid19bitdurg/CovidStatus/totaltestedmodel.dart';
import 'package:covid19bitdurg/drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid19bitdurg/CovidStatus/Districtdatamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:covid19bitdurg/CovidStatus/getapidata.dart';
import 'package:intl/intl.dart';

import 'Statedatamodel.dart';

Statelist1 shape1;
Statelist shape;
Slist shape3;
bool listcreated=false;
bool districtselected=false;
var jsonresponce1;
var drcorona=SvgPicture.asset("SVG/Drcorona.svg");
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



class Covid19Status extends StatefulWidget {
  @override
  _Covid19StatusState createState() => _Covid19StatusState();
}
class _Covid19StatusState extends State<Covid19Status> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  bool isLoading=true;
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
    final response3 = await http.get("https://api.covid19india.org/state_test_data.json");

    if (response.statusCode == 200) {
      var jsonresponce=await json.decode(response.body);
      shape = new Statelist.fromJson(jsonresponce);
      getSeletedData(shape);
      //setStates();
    } else {
      throw Exception('Failed to load data');
    }




    if (response1.statusCode == 200) {
      jsonresponce1=await json.decode(response1.body);
      shape1 = new Statelist1.fromJson(jsonresponce1);
      getSeletedData1(shape1);
      setState(() {

      });
    } else {
      throw Exception('Failed to load data');
    }
    if (response3.statusCode == 200) {
      var jsonresponce3=await json.decode(response3.body);

      shape3 = new Slist.fromJson(jsonresponce3);

      getSeletedData3(shape3);
      setState(() {
        isLoading=false;

      });
    } else {
      throw Exception('Failed to load data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Draw(context),
      body: isLoading?Center(child: CircularProgressIndicator(),):Container(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              Container(
                child: ClipPath(
                  clipper: ClippingClass(),
                  child: Container(
                    height:MediaQuery.of(context).size.height*.3,
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
                        fit: BoxFit.cover,
                        image: AssetImage("Images/virus.png"
                        ),
                      ),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:28.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                              onTap: ()=> _scaffoldKey.currentState.openDrawer(),
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0,left: 5.0),
                                child: SvgPicture.asset('SVG/menu.svg',
                                  color: Colors.white,),
                              )),
                          drcorona,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 25),
                              Text("All you need",style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white
                              ),),
                              Text("is stay at home.",style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white
                              ),),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),


                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(setSeletedState.selectedstate),

                    IconButton(icon: Icon(Icons.arrow_drop_down),
                      color: Color(0xFFC73830),
                      iconSize: 40,
                      onPressed: (){

                        //isStateCard=true;
                        //choiceState()
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                          builder: (BuildContext context){
                            return new ChoiceState();
                          },
                        ));

                      },)

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(setSeletedState.selectedstate,
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
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Last update On:",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),),
                    RichText(
                        text: TextSpan(
                            text: stateData.totaltested,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            )
                        )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,top:5.0),
                child:  Text(statetotaldata.lastupdatde==null?"date":statetotaldata.lastupdatde,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,left: 8.0,right: 8.0),
                child: Container(
                  //color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 150,
                        width:MediaQuery.of(context).size.width*0.24,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: new EdgeInsets.symmetric(horizontal: 2.0,vertical: 6.0),
                          elevation: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // LineReportChart(),
                              RichText(
                                  text: TextSpan(
                                    text: "[+"+"${stateprevious.preconfirmed}"+"]",
                                    style:
                                    Theme.of(context).textTheme.title.copyWith(
                                        color:  Color(0xFFFF8748),
                                        fontWeight: FontWeight.bold
                                    ),


                                  )
                              ),
                              listcreated?
                              Padding(
                                padding: const EdgeInsets.only(right:5),
                                child: lineChart3(context, Color(0xFFFF8748)),
                              ):
                              dummydata(context,Color(0xFFFF4848)),

                              RichText(
                                  text: TextSpan(
                                      text:listcreated?statetotaldata.confirmed.toString():"0",
                                      style:
                                      Theme.of(context).textTheme.title.copyWith(
                                          color:  Color(0xFFFF8748),
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "CONFIRMED",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                        color:  Color(0xFFFF8748),
                                        fontSize: 10
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      /********************CONFIRMED END****************/
                      Container(
                        height: 150,
                        width:MediaQuery.of(context).size.width*0.24,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: new EdgeInsets.symmetric(horizontal: 1.0,vertical: 6.0),
                          elevation: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //LineReportChart(),
                              SizedBox(height: 20),
                              listcreated?
                              Padding(
                                padding: const EdgeInsets.only(right:5.0),
                                child: lineChart4(context,Color(0xFFFF4848)),
                              ):  dummydata(context,Color(0xFFFF4848)),
                              RichText(
                                  text: TextSpan(
                                      text: listcreated?statetotaldata.active.toString():"0",
                                      style:
                                      Theme.of(context).textTheme.title.copyWith(
                                          color: Color(0xFFFF4848),
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "ACTIVE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF4848),
                                        fontSize: 12
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ) ,
                      /*****************ATCIVE END*******************************/
                      Container(
                        height: 150,
                        width:MediaQuery.of(context).size.width*0.24,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: new EdgeInsets.symmetric(horizontal: 1.0,vertical: 6.0),
                          elevation: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //LineReportChart(),
                              RichText(
                                  text: TextSpan(
                                      text: "[+"+"${stateprevious.prerecovered}"+"]",
                                      style:
                                      Theme.of(context).textTheme.title.copyWith(
                                          color: Color(0xFF36C12C),
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              listcreated?Padding(
                                padding: const EdgeInsets.only(right:5.0),
                                child: lineChart2(context, Color(0xFF36C12C)),
                              ):dummydata(context,Color(0xFFFF4848)),
                              RichText(
                                  text: TextSpan(
                                      text:listcreated?statetotaldata.recovered.toString():"0",
                                      style:
                                      Theme.of(context).textTheme.title.copyWith(
                                          color: Color(0xFF36C12C),
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child:RichText(
                                    text: TextSpan(
                                        text: "RECOVERED",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                            color: Color(0xFF36C12C),
                                            fontSize: 10
                                        )
                                    ),
                                  )

                              )
                            ],
                          ),
                        ),
                      ),
                      /******************************DECEASED START**************/
                      Expanded(
                          child:
                          Container(
                            height: 150,
                            width:MediaQuery.of(context).size.width*0.24,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: new EdgeInsets.symmetric(horizontal: 1.0,vertical: 6.0),
                              elevation: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  //LineReportChart(),
                                  RichText(
                                      text: TextSpan(
                                          text: "[+"+"${stateprevious.predeceased}"+"]",
                                          style:
                                          Theme.of(context).textTheme.title.copyWith(
                                              color: Color(0xFFFF4848),
                                              fontWeight: FontWeight.bold
                                          )
                                      )
                                  ),
                                  listcreated?Padding(
                                    padding: const EdgeInsets.only(right:5.0),
                                    child: lineChart1(context,Color(0xFFFF4848)),
                                  ):dummydata(context,Color(0xFFFF4848)),
                                  RichText(
                                      text: TextSpan(
                                          text: listcreated?statetotaldata.deaths.toString():"0",
                                          style:
                                          Theme.of(context).textTheme.title.copyWith(
                                              color: Color(0xFFFF4848),
                                              fontWeight: FontWeight.bold
                                          )
                                      )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                            text: "DECEASED",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                color: Color(0xFFFF4848),
                                                fontSize: 10
                                            )
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ) )
                      /****************************DECEASED END*********************/

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(districtselected==true?districtData.districtname:"SELECT DISTRICT",

                    ),
                    IconButton(icon: Icon(Icons.arrow_drop_down),
                      color: Colors.indigo,
                      iconSize: 40,
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                          builder: (BuildContext context){
                            return new ChoiceDistrict();
                          },
                        ));
                      },)

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(districtselected==true?districtData.districtname:"Select District",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.indigo
                      ),),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:15.0,bottom: 8.0),
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
                          /*Container(
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
                                ),*/

                          Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: RichText(
                                  text: TextSpan(
                                      text: districtselected==true?districtData.dactive.toString():"0",
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all( color:  Color(0xFFFF4848),width: 2.5 ),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 10,
                                        color:  Color(0xFFFF4848),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text("Active",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:  Color(0xFFFF4848),
                                    ),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: RichText(
                                  text: TextSpan(
                                      text: districtselected==true?districtData.drecoverd.toString():"0",
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Color(0xFF36C12C),width: 2.5 ),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 10,
                                        color: Color(0xFF36C12C),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text("Recoverd",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                   color: Color(0xFF36C12C),
                                    ),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: RichText(
                                  text: TextSpan(
                                      text:districtselected==true?districtData.dconfirmed.toString():"0",
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(  color:Color(0xFFFF8748),width: 2.5 ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 10,
                                        color:Color(0xFFFF8748),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text("CONFIRMED",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:Color(0xFFFF8748),
                                    ),),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
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
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}