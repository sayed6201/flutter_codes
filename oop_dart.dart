-------------------------------------------------
getter setter 
-------------------------------------------------
class Vehicle {
  String make;
  String model;
  int manufactureYear;
  int vehicleAge;
  String color;

  int get age {
    return vehicleAge;
  }

  void set age(int currentYear) {
    vehicleAge = currentYear - manufactureYear;
  }

  // We can also eliminate the setter and just use a getter.
  //int get age {
  //  return DateTime.now().year - manufactureYear;
  //}

  Vehicle({this.make,this.model,this.manufactureYear,this.color,});
}