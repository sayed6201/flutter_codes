//Auth user data fetch+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchBookingHistory() async {
    if (_token == null) throw "Your are not logged in";
    if (_token.isEmpty) throw "Your are not logged in";

//    if(_profileData.length != 0) return;

    String url = BOOKING_HISTORY;
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      Map<String, dynamic> decodedData = json.decode(response.body);

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("status code :" + response.statusCode.toString());
      print("boking data response: " + decodedData.toString());

      if (decodedData['error'] == null) {
//        _isLoggedIn = true;
      } else {
        throw "Something went wrong";
      }

      bookingData = decodedData["data"]["bookings"];
      completedBokingList = bookingData.where((data) {
        if (data['status'] == COMPLETED_STATUS) {
          return true;
        }
        return false;
      }).toList();
      processingBookingList = bookingData.where((data) {
        if (data['status'] == PROCESSING_STATUS) {
          return true;
        }
        return false;
      }).toList();

      print("Processing data---->: " + processingBookingList.toString());
      confirmedBookingList = bookingData.where((data) {
        if (data['status'] == CONFIRMED_STATUS) {
          return true;
        }
        return false;
      }).toList();
      print("CONFIRMED_STATUS---->: " + confirmedBookingList.toString());

      cancelledBookingList = bookingData.where((data) {
        if (data['status'] == CANCELLED_STATUS) {
          return true;
        }
        return false;
      }).toList();
      paidBookingList = bookingData.where((data) {
        if (data['status'] == PAID_STATUS) {
          return true;
        }
        return false;
      }).toList();
      unpaidBookingList = bookingData.where((data) {
        if (data['status'] == UNPAID_STATUS) {
          return true;
        }
        return false;
      }).toList();

      print("booking data fetched... " + decodedData.toString());
      notifyListeners();
    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }