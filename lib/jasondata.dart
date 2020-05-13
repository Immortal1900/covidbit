import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List<Data> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://indian-cities-api-nocbegfhqg.now.sh/cities");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Data.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   //Text(list[index].title),
                  list[index].state=="Chhattisgarh"?Text(list[index].title):Text("no")

                 // Text(list[index].state),
                 // Text(list[index].dist),
                ],
              );

            }));
  }
}
class Data {
  final String title;
  final String state;
  final String dist;
  Data._({this.title,this.state,this.dist});
  factory Data.fromJson(Map<String, dynamic> json) {
    return new Data._(
      title: json['City'],
      state: json['State'],
      dist: json['District'],

    );
  }
}