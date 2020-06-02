import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
class apidata extends StatefulWidget {
  @override
  _apidataState createState() => _apidataState();
}
class Property{
  double width;
  double breadth;

  Property({
    this.width,
    this.breadth
  });
  factory Property.fromJson(Map<String, dynamic> json){
    return Property(
        width: json['width'],
        breadth: json['breadth']
    );
  }
}
class delta{
  String confirmed;
  String deceased;
  String recovered;
  delta({this.confirmed,this.deceased,this.recovered});
  factory delta.fromJson(Map<String,dynamic> json){
    return delta(
      confirmed:json['confirmed'],
      deceased: json['deceased'],
      recovered:json['recovered']
    );
  }
}
class district{

  String notes;
  String active;
  String confirmed;
  String deceased;
  String recovered;
  delta dlta;
  district({this.notes,this.active,this.confirmed,this.deceased,this.recovered,this.dlta});
  factory district.fromJson(Map<String,dynamic> json){
    return district(
        confirmed:json['confirmed'],
        deceased: json['deceased'],
        recovered:json['recovered']
    );
  }
}
class Shape{
  String shapeName;
  Property property;

  Shape({
    this.shapeName,
    this.property
  });
  factory Shape.fromJson(Map<String, dynamic> parsedJson){
    return Shape(
        shapeName: parsedJson['shape_name'],
        property: Property.fromJson(parsedJson['property'])
    );
  }
}
class Payments {
  //String result;
  int count;
  List<Payment> payments;

  Payments.fromJson(String jsonStr) {
    final _map = jsonDecode(jsonStr);
    //this.result = _map['result'];
    this.count = _map['count'];
    this.payments = [];
    final _paymentList = _map['payments'];

    for (var i = 0; i < (this.count); i++) {
      this.payments.add(new Payment.fromJson(_paymentList[i]));
    }
  }
}
class Payment {
  double amount;
  String source, destination;
  DateTime executedTime;

  Payment.fromJson(Map<String, dynamic> jsonMap) {
    this.amount = double.parse(jsonMap['amount']);
    this.source = jsonMap['source'];
    this.destination = jsonMap['destination'];
    this.executedTime = DateTime.parse(jsonMap['executed_time']);
  }
}

class _apidataState extends State<apidata> {
  List maindata=[];

 void getdata() async {
    print("GETDATA CALLED");
  // var response= await http.get(
   //     "https://github.com/PoojaB26/ParsingJSON-Flutter/blob/master/assets/shape.json");
    var response=
    """{
      "shape_name":"rectangle",
      "property":{
        "width":5.0,
        "breadth":10.0
      }
    }""";
   print("response");

    final jsonResponse = json.decode(response.toString());
    Shape student = new Shape.fromJson(jsonResponse);
    district dst=new district.fromJson(jsonResponse);
    print(student.property);

  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API FETCH"),
      ),
      body: Container(),
    );
  }
}


class dem {
  final String statecode;


  dem(this.statecode);

  factory dem.fromJson(List<dynamic> json) =>
      dem(json[0]);
}
