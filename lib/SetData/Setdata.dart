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
class stateconfirmed{
  static List <double> confirmed=[];
  static int confirmcount=0;
  stateconfirmed(var as){
    confirmed.add(double.parse(as));
    confirmcount=confirmcount+int.parse(as);
  }
}
class statedeaths{

  static List <double> deaths=[];
  static int deathcount=0;
  statedeaths(var as){
    deaths.add(double.parse(as));
    deathcount=deathcount+int.parse(as);
  }
}

class staterecoverd{
  static int recoverdcount=0;
  static List <double> recovered=[];
  staterecoverd(var as){
    recovered.add(double.parse(as));
    recoverdcount=recoverdcount+int.parse(as);
  }
}
class stateactive{
  static double activecount=0;
  static List <double> active=[];
  stateactive(double as){
    active.add(as);
  }
}

