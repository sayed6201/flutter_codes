/*
===========================================================================================
POST REQUEST
===========================================================================================
*/  
  Future<void> memberRegister(
      {@required String email, @required String password}) async {
    
    String url = DOMAIN + MEMBER_REGISTRATION;
    print("memberRegister called : $url");
    
    try {
      final response = await http.post(url, body: {
        "name": "sayed",
        "email": "email",
        "password": "password",
        "c_password": "c_password",
        "role_id": "role_id",
        "phone": "phone",
        "age": "age",
        "address": "address",
        "gender": "gender",
        "nid": "photo",
        "photo": "photo"
      });

      Map<String, dynamic> decodedData = json.decode(response.body);
      print("memberRegister status code :" + response.statusCode.toString());
      print("memberRegister response: " + decodedData.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      
      print("log in token: " + decodedData['success']['token']);
      
      notifyListeners();
      
    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }

/*
===========================================================================================
POST REQUEST WITH JSON DATA AND TOKEN
===========================================================================================
*/  
   //member reg++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> bookRoom(
      {@required serviceId,
      @required serviceType,
      @required startDate,
      @required endDate,
      @required adultNum,
      @required childNum,
      @required extraPrice}) async {
    String url = DOMAIN + MEMBER_REGISTRATION;
    try {
      final response = await http.post(url,
          headers: {
            'content-type': 'application/json',
           'Authorization': 'Bearer $_token'
          },
          body: json.encode({
            "service_id": serviceId,
            "service_type": serviceType,
            "start_date": startDate,
            "end_date": endDate,
            "adults": adultNum,
            "children": childNum,
            "extra_price": extraPrice,
          }));

      Map<String, dynamic> decodedData = json.decode(response.body);

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("booking status code :" + response.statusCode.toString());
      print("booked response: " + decodedData.toString());

      if (decodedData['url'] != null) {
        roomBookingUrl = decodedData['url'].toString();
        roomBookingUrl = domain + roomBookingUrl.replaceAll(domain, 'api/');
        print("booking url... " + roomBookingUrl);
      } else {
        throw decodedData["message"];
      }

      roomBookingJsonBody = {
        "service_id": serviceId,
        "service_type": serviceType,
        "start_date": startDate,
        "end_date": endDate,
        "adults": adultNum,
        "children": childNum,
        "extra_price": extraPrice,
      };

      print('booking request body :' + roomBookingJsonBody.toString());

      notifyListeners();

      await fetchBookRoomOrderDetail();
    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }


/*
===========================================================================================
GET REQUEST
===========================================================================================
*/ 

  Future<void> fetchExpertCatagoryLIst() async {
    String url = DOMAIN+CATAGORY_LIST;
    try {
      print("fetchExpertCatagoryLIst called");

      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      List<dynamic> catagoryList = json.decode(response.body);

      print("fetchExpertCatagoryLIst status code :" + response.statusCode.toString());
      print("fetchExpertCatagoryLIst list data: " + catagoryList.length.toString());
      notifyListeners();
    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }