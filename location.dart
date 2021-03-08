
//initialization...........................

  var location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;


//service request...........................
    _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        print("_serviceEnabled");
        if (!_serviceEnabled) {
          print("_serviceEnabled NOT");
          return;
        }
      }



//permission request...........................

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    print( "Lat: "+_locationData.latitude.toString() + "- Lon:" + _locationData.longitude.toString());
