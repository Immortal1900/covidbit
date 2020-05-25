class setSeletedState{
  static var selectedstate="Chhattisgarh";
  static var selectedstatecode="ct";
  setSeletedState(var s,var sc){
    selectedstate=s;
    selectedstatecode=sc;
  }
}
class stateData{
static var totaltested="";
static var numofventilators="";
static var positive="";
static var numisolationbeds="";
static var numicubeds="";
stateData(var tt,var nv,var pos,var nib,var ncb){

  totaltested=tt;
  numofventilators=nv;
  positive=pos;
  numisolationbeds=nib;
  numicubeds=ncb;
}
}
class stateactive{
  static List <double> active=[];
  stateactive(var as){
    active.add(double.parse(as));
  }
}
class statedeaths{
  static List <double> deaths=[];
  stateadeaths(var as){
    deaths.add(double.parse(as));
  }
}

class staterecoverd{
  static List <double> recovered=[];
  staterecoverd(var as){
    recovered.add(double.parse(as));
  }
}

