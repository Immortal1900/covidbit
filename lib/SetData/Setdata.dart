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
  stateData(var tt){
    totaltested=tt;
  }
}
class districtData{
  static var statename="Chhattisgarh";
  static var districtname="Durg";
  static var dactive=0;
  static var drecoverd=0;
  static var ddeceased=0;
  static var dconfirmed=0;
  districtData(var a,var b, var c){
    dactive=a;
    drecoverd=b;
    dconfirmed=c;
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
class stateprevious{
  static var preactive;
  static var preconfirmed;
  static var prerecovered;
  static var predeceased;
  stateprevious(var a, var b ,var c){
    preconfirmed=a;prerecovered=b;predeceased=c;
  }
}
class statetotaldata{
  static var active;
  static var confirmed;
  static var deaths;
  static var recovered;
  static var state;
  static var lastupdatde;
  statetotaldata(var a,var b,var c,var d,var f,var g){
    active=a;confirmed=b;deaths=c;recovered=d;state=f;lastupdatde=g;
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
class indiadata{
  static List<double> totalc=new List();
  static List<double> totalr=new List();
  static List <double> totald=new List();
  static var date;
  static var totalconfirmed;
  static var totaldeceased;
  static var totalrecovered;

  static var cdaily;
  static var rdaily;
  static var ddaily;
  static var adaily;
  indiadata(var a, var b, var c) {
    totalconfirmed = a;
    totaldeceased = b;
    totalrecovered = c;
  }
}