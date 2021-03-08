/*
===========================================================================================
POST: json body passs
---'content-type': 'application/json'----
===========================================================================================
*/

Future<void> bookTour({@required serviceId, @required serviceType, @required startDate, @required guest}) async {
    if (_token == null) throw "Null token";
    if (_token.isEmpty) throw "Empty token";

//    if(_profileData.length != 0) return;

    String url = BOOKING_URI;
    try {
      final response = await http.post(
          url,
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $_token'
          },
          body: json.encode (
              {
                "service_id" : "3",
                "service_type" : "tour",
                "start_date" : "2020-01-28",
                "person_types": [
                  {
                    "name": "Adult",
                    "desc": null,
                    "min": "1",
                    "max": "10",
                    "price": "1000",
                    "number":"1"
                  },
                  {
                    "name": "Child",
                    "desc": null,
                    "min": "0",
                    "max": "10",
                    "price": "300",
                    "number":"1"
                  }
                ],
                "extra_price": [
                  {
                    "name": "Clean",
                    "price": "100",
                    "type": "one_time",
                    "number" : "0",
                    "enable" : "true",
                    "price_type" : null
                  },
                  {
                    "name": "lundry",
                    "price": "50",
                    "type": "one_time",
                    "number" : "0",
                    "enable" : "true",
                    "price_type" : null
                  }
                ],
                "step" : "1",
                "guests" : "1"
              }
          )
      );

      Map<String, dynamic> decodedData = json.decode(response.body);
      print("booking status code :" + response.statusCode.toString());
      print("booked response: " + decodedData.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      if (decodedData['url'] != null) {
        bookingUrl = decodedData['url'];
      }else{
        throw "url is not found";
      }

      print("booking url... "+decodedData['url']);
      notifyListeners();

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }


/*
===========================================================================================
POST: json body passs
---'content-type': 'application/json'----
===========================================================================================
*/
    //booking transport code & detail
    fetch++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchBookTransportOrderDetail() async {
    if (_token == null) throw "Your are not logged in";
    if (_token.isEmpty) throw "Your are not logged in";

// if(_profileData.length != 0) return;

    String url = transportBookingUrl;
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});

      Map<String, dynamic> decodedData = json.decode(response.body);

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      print("booking status code :" + response.statusCode.toString());
      print("booked response: " + decodedData.toString());

      _transportBookingOrderDetail = decodedData['data'];
      print("_tourBookingOrderDetail: " +
          _transportBookingOrderDetail.toString());

      notifyListeners();
    } catch (error) {
      print("auth provider error 2: " + error.toString());
      throw error;
    }
  }