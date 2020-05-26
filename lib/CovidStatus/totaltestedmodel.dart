
class Statestotaltested{
  var totaltested;
  var updatedon;
  var state;
  Statestotaltested({
    this.totaltested,
    this.state,
    this.updatedon
  });
  factory  Statestotaltested.fromJson(Map<String, dynamic> Json) {
    return Statestotaltested(
        totaltested: Json["totaltested"],
        state: Json["state"],
        updatedon:Json["updatedon"]
    );
  }
}
class Slist {
  final List<Statestotaltested> std;
  Slist({
    this.std
  });
  factory  Slist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['states_tested_data'] as List;
    print(list.runtimeType);
    List<Statestotaltested> stateobject = list.map((i) => Statestotaltested.fromJson(i)).toList();
    return Slist(
        std: stateobject
    );
  }
}