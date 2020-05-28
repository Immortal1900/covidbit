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