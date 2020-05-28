import 'package:covid19bitdurg/SetData/Setdata.dart';

class Shape{
  StateUnassigned stateUuassigned;
  Shape({
    this.stateUuassigned,
  });

  factory Shape.fromJson(Map<String, dynamic> parsedJson) {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAA ${setSeletedState.selectedstate}");
    return Shape(

      stateUuassigned:StateUnassigned.fromJson(parsedJson[setSeletedState.selectedstate]),
      // districtData: DistrictData.fromJson(parsedJson['districtData'])
    );
  }
}

class StateUnassigned{
  //String title;

  DistrictData districtData;
  //  String dist;
  StateUnassigned({


    this.districtData
    //this.dist
  });
  factory  StateUnassigned.fromJson(Map<String, dynamic>parsedJson) {
    return  StateUnassigned(

        districtData: DistrictData.fromJson(parsedJson['districtData'])

    );
  }

}

class DistrictData{
  //String title;
  Unassigned unassigned;
  //  String dist;
  DistrictData({
    //this.title,
    this. unassigned,
    //this.dist
  });
  factory  DistrictData.fromJson(Map<String, dynamic> parsedJson) {
    return DistrictData(
        unassigned: Unassigned.fromJson(parsedJson[districtData.districtname])

    );
  }
}
class Unassigned{
  //String title;
  int active;
  int confirmed;
  int deceased;
  int recovered;

  //  String dist;
  Unassigned({
    //this.title,
    this.active,
    this.confirmed,
    this.deceased,
    this.recovered

  });
  factory  Unassigned.fromJson(Map<String, dynamic> Json) {
    return  Unassigned(
        active: Json["active"],
        confirmed: Json["confirmed"],
        deceased: Json['deceased'],
        recovered: Json['recovered']
    );
  }
}