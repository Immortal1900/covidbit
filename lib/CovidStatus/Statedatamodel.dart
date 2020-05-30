class Statestesteddata{
  //String title;
  var active;
  var confirmed;
  var deaths;
  var recovered;
  var state;
  var updateon;

  Statestesteddata({
    this.active,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.state,
    this.updateon
    //this.dist
  });
  factory  Statestesteddata.fromJson(Map<String, dynamic> Json) {
    return Statestesteddata(
        active: Json["active"],
        confirmed: Json["confirmed"],
        deaths: Json["deaths"],
        recovered: Json["recovered"],
        state: Json["state"],
        updateon: Json["lastupdatedtime"]
    );
  }
}
class indiatestedata{
  var dailyconfirmed;
  var dailydeceased;
  var dailyrecovered;
  var totalconfirmed;
  var totaldeceased;
  var totalrecovered;
  indiatestedata({
  this.dailyconfirmed,
  this.dailydeceased,
  this.dailyrecovered,
  this.totalconfirmed,
  this.totaldeceased,
  this.totalrecovered,

});
  factory indiatestedata.fromJson(Map<String, dynamic> Json){
return indiatestedata(
    dailyconfirmed:  Json["dailyconfirmed"],
      dailydeceased: Json["dailydeceased"],
    dailyrecovered:  Json["dailyrecovered"],
    totalconfirmed:  Json["totalconfirmed"],
      totaldeceased: Json["totaldeceased"],
    totalrecovered:  Json["totalrecovered"]
);
}

}
class Statelist {
  final List<Statestesteddata> std;
  final List<indiatestedata>itd;
  Statelist({
    this.std,
    this.itd
  });
  factory  Statelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['statewise'] as List;
    var list1= parsedJson['cases_time_series'] as List;


    List<Statestesteddata> stateList = list.map((i) => Statestesteddata.fromJson(i)).toList();
    List<indiatestedata> indialist = list1.map((i) => indiatestedata.fromJson(i)).toList();
    return Statelist(
        std: stateList,
        itd:indialist
    );

  }
}