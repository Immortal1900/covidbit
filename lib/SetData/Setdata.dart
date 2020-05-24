class setSeletedState{
  static var selectedstate="Chhattisgarh";

  setSeletedState(var s){
    selectedstate=s;
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
class stategraphdata{
  static List <double> positive=[];
  stategraphdata(var as){
    positive.add(double.parse(as));
  }
}

