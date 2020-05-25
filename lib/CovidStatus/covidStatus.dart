import 'package:covid19bitdurg/CovidStatus/choiceDistrict.dart';
import 'package:covid19bitdurg/CovidStatus/choiceState.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Covid19Status extends StatefulWidget {
  @override
  _Covid19StatusState createState() => _Covid19StatusState();
}
class _Covid19StatusState extends State<Covid19Status> {

  ScrollController _controller=ScrollController();
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
                                      return new ChoiceState();
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
                                Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 15.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        lineChart(context,Color(0xFFFF4848)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text: "100",
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
                                                        text: "Active",
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
                                Container(
                                  height: 150,
                                  width: 130,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 15.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //LineReportChart(),
                                        lineChart(context, Color(0xFF36C12C)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child:RichText(
                                                text: TextSpan(
                                                    text: "30",
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
                                Container(
                                  height: 150,
                                  width: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: new EdgeInsets.symmetric(horizontal: 15.0,vertical: 6.0),
                                    elevation: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        // LineReportChart(),
                                        lineChart(context, Color(0xFFFF8748)),
                                        Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: RichText(
                                                text: TextSpan(
                                                    text: "130",
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
                                  return new ChoiceDistrict();
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
                                ),
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


Widget lineChart(BuildContext context,var color){
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
                  spots: getSpots(),
                  isCurved: true,
                  dotData:  FlDotData(show: false),
                  belowBarData: BarAreaData(show: false)

              )]
        )
    ),
  );
}
List<FlSpot> getSpots(){
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