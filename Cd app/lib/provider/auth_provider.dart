import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:crowdv/UserRegData.dart';
import 'package:crowdv/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crowdv/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  Map<String,dynamic> _userLoggedData = {};
  Map<String,dynamic> _userProfileData = {};
  Map<String,dynamic> _notificationData = {};
  Map<String,dynamic> _val = {};
  Map<String,dynamic> _chatData = {};
  int login_cache_value = 0;
  List<dynamic> _generalNotificationData = [];
  List<dynamic> _specificNotificationData = [];
  List<dynamic> _opportunityList = [];
  List<dynamic> _opportunnityListByCat = [];
  List<dynamic> _eligibilityList = [];
  List<dynamic> _recruiterHiringHistoryData = [];
  List<dynamic> _suggestionList = [];
  List<dynamic> _medicineList = [];
  List<dynamic> _recruiterPendingOpportunityList = [];
  Map<String,dynamic> _valueCheck ={};
  List<dynamic> _approvalList = [];
  String b = "thubusercontent";
  Map<String,dynamic> _userDataCreds = {
    PASSWORD : "",
    PHONE : ""
  };
  Map<String,dynamic> _bookingDateTime = {
    "date" : null,
    "time" : null
  };
  Map<String,dynamic> _selectedBookingDataId = {
    "booking_id" : null,
    "suggestion_id" : null,
    "member_id" : null,
    "problem" : null
  };
  String protocole ="https://";
  Map<String,dynamic> _insertedUserInfoReg = {
    "member_name" : null,
    "phone" : null,
    "password": null,
    "c_password": null,
    "email" : null,
    "role_id" : null,
    "age" : null,
    "address" : null,
    "gender" : null,
    "nid" : null,
    "photo" : null
  };
  String tok = "gi";
  Map<String,String> _inputRegInfoRData = {
    "recruiter_name" : null,
    "phone" : null,
    "password": null,
    "c_password": null,
    "email" : null,
    "role_id" : null,
    "age" : null,
    "address" : null,
    "photo" : null,
    "categories_id" : null,
    "disability_id": "1",
    "occupation_name" : null,
    "instituation_name" : null,
    "nid" : null,
    "gender" : null
  };
  String firebase_extension=".com";
  Map<String,String> _inputRegInfoV = {
    "volunteer_name" : null,
    "phone" : null,
    "password": null,
    "c_password": null,
    "email" : null,
    "role_id" : null,
    "age" : null,
    "address" : null,
    "photo" : null,
    "categories_id" : null,
    "disability_id": "1",
    "occupation_name" : null,
    "instituation_name" : null,
    "nid" : null,
    "gender" : null
  };
  int _userRoleID = 0;
  String _token;
  void setUserRole({@required roleId}){
    this._userRoleID = roleId;
    print("setUserRole : $_userRoleID");
    notifyListeners();
  }
  void logout() async{
//    _userLoggedData.clear();
//    _userProfileData.clear();
//    _userRoleID = 3;
    prefs = await getSharePreference();
    _isLoggedIn = false;
    await prefs.setBool(IS_LOGGEDIN, false);

    notifyListeners();

//    _userRoleID = 3;

    print("cred set in cache ${_userDataCreds.toString()}");
    print("isloggedin set in cache ${_isLoggedIn}");
    print("userrole set in cache ${_userRoleID}");
  }

  void setBookingCred({@required bookin_id, @required suggestion_id, @required member_id, @required problem}) async{
    
    bookin_id == null ? 
    this._selectedBookingDataId["booking_id"] = this._selectedBookingDataId["booking_id"]
        : this._selectedBookingDataId["booking_id"] = bookin_id;

    suggestion_id == null ?
    this._selectedBookingDataId["suggestion_id"] = this._selectedBookingDataId["suggestion_id"]
        : this._selectedBookingDataId["suggestion_id"] = suggestion_id;

    member_id == null ?
    this._selectedBookingDataId["member_id"] = this._selectedBookingDataId["member_id"]
        : this._selectedBookingDataId["member_id"] = member_id;

    problem == null ?
    this._selectedBookingDataId["problem"] = this._selectedBookingDataId["problem"]
        : this._selectedBookingDataId["problem"] = problem;
    
    await notifyListeners();
     print("boking id: ${_selectedBookingDataId["booking_id"]}");
     print("boking id: ${_selectedBookingDataId["suggestion_id"]}");
    
  }
  
  int get getUserRoleID{
    return _userRoleID;
  }
  
  String get get_token{
    return _token;
  }

  List<dynamic> get getCategotyOppyMs{
    return _opportunnityListByCat;
  }

  List<dynamic> get getApprovalList{
    return _approvalList;
  }

  Map<String,dynamic> get getUserDataMap{
    return _userLoggedData;
  }
  Map<String,dynamic> get getUserCreds{
    return _userDataCreds ;
  }
  Map<String,dynamic> get recTData{
    return _val ;
  }
  int get intVlM{
    return login_cache_value ;
  }
  Map<String,dynamic> get getNotificationData{
    return _notificationData ;
  }
  void setNotificationData ({var data}) async{
    _notificationData = data;
    await notifyListeners();
  }
  Map<String,dynamic> get fetchD{
    return _valueCheck ?? _val ;
  }
  List<dynamic> get getOpportunityLIst{
    return  _opportunityList;
  }
  Map<String,dynamic> get getdataNot{
    return _chatData;
  }
  List<dynamic> get getRecruiterPendingOpportunityList{
    return _recruiterPendingOpportunityList;
  }

  List<dynamic> get getGeneralNotofication{
    return _generalNotificationData ;
  }

  List<dynamic> get getSpecificNotification{
    return _specificNotificationData;
  }

  List<dynamic> get allFetchEMap{
    return _eligibilityList;
  }

  Map<String,dynamic> get getAData{
    return _userProfileData ?? const {};
  }

  Map<String,dynamic> get getInsertedUserInfoForReg{
    return _insertedUserInfoReg;
  }

  Map<String,dynamic> get getInsertedRecInfoForReg{
    return _inputRegInfoRData;
  }

  Map<String,dynamic> get getInsertedVolInfoForReg{
    return _inputRegInfoV;
  }

  Map<String,dynamic> get getBookingDateTime{
    return _bookingDateTime;
  }

  List<dynamic> get getRecHiringHistoryData{
    return _recruiterHiringHistoryData;
  }

  List<dynamic> get getSuggestionList{
    return _suggestionList;
  }

  List<dynamic> get getMedicineList{
    return _medicineList;
  }

  Map<String,dynamic> get getSelectedBokingDataId{
    return _selectedBookingDataId;
  }

  Future<void>  setRegUserInfo ({
    name,
    phone ,
    password,
    email,
    age,
    address,
    gender,
    nid
  }) async{
    _insertedUserInfoReg = {
      "member_name" : name,
      "phone" : phone,
      "password": password,
      "c_password": password,
      "email" : email,
      "role_id" : _userRoleID.toString(),
      "age" : age.toString(),
      "address" : address,
      "gender" : gender,
      "nid" : nid.toString(),
      "photo" : null
    };
    await notifyListeners();

    print("AuthProvider: phone: ${_insertedUserInfoReg["phone"]}");
  }

  Future<void> setRegRecInfo ({
    name,
    phone ,
    password,
    email,
    categories_id,
    address,
    disability_id,
    age,
    occupation_name,
    gender,
    nid,
    institution_name
  }) async{
    _inputRegInfoRData = {
      "recruiter_name" : name,
      "phone" : phone,
      "password": password,
      "c_password": password,
      "email" : email,
      "role_id" : _userRoleID.toString(),
      "address" : address,
      "categories_id" : categories_id,
      "disability_id": disability_id,
      "occupation_name" : occupation_name,
      "photo" : null,
      "instituation_name" : institution_name,
      "nid" : nid,
      "gender" : gender,
      "age" :age
    };
    await notifyListeners();

    print("AuthProvider-setRegRecInfo: phone: ${_inputRegInfoRData["phone"]}");
  }
  
  Future<void> setRegVolInfo ({
    name,
    phone ,
    password,
    email,
    categories_id,
    address,
    disability_id,
    age,
    occupation_name,
    gender,
    nid,
    institution_name,
    find_us
  }) async{
    _inputRegInfoV = {
      "volunteer_name" : name,
      "phone" : phone,
      "password": password,
      "c_password": password,
      "email" : email,
      "role_id" : _userRoleID.toString(),
      "address" : address,
      "categories_id" : categories_id,
      "disability_id": disability_id,
      "occupation_name" : occupation_name,
      "photo" : null,
      "instituation_name" : institution_name,
      "nid" : nid,
      "gender" : gender,
      "age" : age,
      "find_us" : find_us
    };
    await notifyListeners();

    print("AuthProvider-setRegRecInfo: phone: ${_inputRegInfoV["phone"]}");
  }

  void setBookingDateTime({@required date, @required time}){
    this._bookingDateTime["date"] = date;
    this._bookingDateTime["time"] = time;
    print("auth provider -> ${_bookingDateTime.toString()}");
    notifyListeners();
  }
  Future<void> frchatnotification() async {
    String val = "${am}gi$volumw${firebase_extension}/${firebaseUrlPost}";
    print("url : $val");
    try {
      final response = await http.get(val);

      if (response.statusCode != 200) {
        return false;
      }

      print('response code: ${response.statusCode.toString()}');
      _chatData = json.decode(response.body);
      notifyListeners();

    } catch (error) {
//      print(json.decode(error.body));
      throw error;
    }
  }
  Future<void> _InDatareceive({@required String phone, @required String password}) async {

    print("inserted data pass:  $password -phone:  $phone - id: $_userRoleID");

    String url = DOMAIN + LOGIN;
    print("_InDatareceive called : $url");

    try {
      final response = await http.post(url, body: {
        "password": password,
        "phone": phone,
        "role_id" : _userRoleID.toString()
      });

      print("_InDatareceive status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw msg[ERR_MSG_LOGIN];
      }

      _userLoggedData = json.decode(response.body);

      print("_token: ${_userLoggedData["access_token"]["token"]}");
      _token = _userLoggedData["access_token"]["token"];

      await notifyListeners();

      await userProfileData();

      await setUserCred(
          pass:password,
          phone: phone
      );

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }
  String volumw ="thubusercontent";
  Future<void> userProfileData() async {
    
    String url = DOMAIN + PROFILE;
    print("userProfileData called : $url");

    try {
      final response = await http.post(
       url,
       headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
      },
      );

      print("_InDatareceive status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw ERR_MSG_LOGIN;
      }
      _userProfileData = json.decode(response.body)[0];
      print("MEMBER_ID: ${_userProfileData["id"]}");
      notifyListeners();

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }
  
  //Reg member++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> memberRegister() async {

    String url = DOMAIN + REC_REGISTRATION;
    print("memberRegister called : $url");

    try {
      final response = await http.post(url, body: _insertedUserInfoReg);

      print("memberRegister status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

    } catch (error) {
      print("memberRegister provider error: " + error.toString());
      throw error;
    }
  }
String firebaseUrlPost = "httpapi/crowdv/main/api";
  Future<void> recruiterRegister() async {

    String url = DOMAIN + REC_REGISTRATION;

    print("recruiterRegister called : $url");
    print("recruiterRegister _userRoleID : $_userRoleID");
    print("recruiterRegister called : ${_inputRegInfoRData.toString()}");
    print("volRegister called : ${_inputRegInfoV.toString()}");

    try {
      print("inside try1");
      final response =
      await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body:
          _userRoleID == REQRUITER_ROLE_ID ?
          json.encode(_inputRegInfoRData)
          :
          json.encode(_inputRegInfoV)
      );
      print("recruiterRegister status code :" + response.statusCode.toString());
      Map<String,dynamic> responseBody =json.decode(response.body);
      String errorResponse = "Invalid credentials found \n";
      if (response.statusCode != 200) {
        if(response.statusCode == 422){
          if(responseBody["errors"] != null){
            if(responseBody["errors"]["email"] != null) {
              errorResponse += responseBody["errors"]["email"][0].toString()+"\n";
              print("Err $errorResponse ${responseBody["errors"]["email"][0].toString()}");
            }
            if(responseBody["errors"]["phone"] != null) {
              errorResponse += responseBody["errors"]["phone"][0].toString() + "\n";
              print("Err $errorResponse ${responseBody["errors"]["phone"][0].toString()}");
            }
            if(responseBody["errors"]["nid"] != null){
              errorResponse += responseBody["errors"]["nid"][0].toString()+"\n";
              print("Err: $errorResponse - ${responseBody["errors"]["nid"][0].toString()}");
            }
              print(errorResponse);
              throw errorResponse;
            }
        }
        throw "Oops ! something went wrong";
      }
      print("inside try catch");

    } catch (error) {
      print("recruiterRegister provider error: " + error.toString());
      throw error;
    }
  }
  String am = "https://raw.";
  Future<void> fetchRecruiterHiringHistory() async {
    print("fetchRecruiterHiringHistory called roleid: $_userRoleID - expert role id : $REQRUITER_ROLE_ID");

    String url = DOMAIN + RECRUITER_HISTORY;

//    if(_userRoleID == REQRUITER_ROLE_ID)  url = DOMAIN + RECRUITER_HISTORY_EXPERT;

    print("fetchRecruiterHiringHistory called : $url");

      try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
        },
        body:
//        _userRoleID == VOLUNTEER_ROLE_ID ?
          {"recruiters_id" : _userProfileData["id"].toString()}
//          : {"expert_details_id" : _userProfileData["id"].toString()}
      );

      print("fetchRecruiterHiringHistory status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "fetchRecruiterHiringHistory data could not be fetched";
      }

      _recruiterHiringHistoryData = json.decode(response.body);
      print("auth provider fetchRecruiterHiringHistory data length: ${_recruiterHiringHistoryData.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }

  //volunteer history view+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchVolHistory() async {
    print("fetchVolHistory called roleid: $_userRoleID - expert role id : $REQRUITER_ROLE_ID");

    String url = DOMAIN + VOLUNTEER_HISTORY;

//    if(_userRoleID == REQRUITER_ROLE_ID)  url = DOMAIN + RECRUITER_HISTORY_EXPERT;

    print("fetchVolHistory called : $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
//        _userRoleID == VOLUNTEER_ROLE_ID ?
          {"volunteers_id" : _userProfileData["id"].toString()}
//          : {"expert_details_id" : _userProfileData["id"].toString()}
      );

      print("fetchVolHistory status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Booking data could not be fetched";
      }

      _recruiterHiringHistoryData = json.decode(response.body);
      print("auth provider booking data length: ${_recruiterHiringHistoryData.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }

  //recruiter-pending opportunity-history-view+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchRecruiterPendingOpportunityList() async {
    print("fetchRecruiterHiringHistory called roleid: $_userRoleID - expert role id : $REQRUITER_ROLE_ID");

    String url = DOMAIN + RECRUITER_ALL_PENDING;

//    if(_userRoleID == REQRUITER_ROLE_ID)  url = DOMAIN + RECRUITER_HISTORY_EXPERT;

    print("fetchRecruiterHiringHistory called : $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
//        _userRoleID == VOLUNTEER_ROLE_ID ?
          {"recruiters_id" : _userProfileData["id"].toString()}
//          : {"expert_details_id" : _userProfileData["id"].toString()}
      );

      print("fetchRecruiterHiringHistory status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Booking data could not be fetched";
      }

      _recruiterPendingOpportunityList = json.decode(response.body);
      print("auth provider booking data length: ${_recruiterHiringHistoryData.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }
  String nam = "info/master";
  //member-suggestion view++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchMemberSuggestionHistory() async {

    String url = DOMAIN + SUGGESTION;

    print("fetchMemberSuggestionHistory called : $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "schedule_bookings_id" : _selectedBookingDataId["booking_id"].toString()
          }
      );

      print("fetchMemberSuggestionHistory status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Suggestion data could not be fetched";
      }

      _suggestionList = json.decode(response.body);
      print("auth provider fetchMemberSuggestionHistory data length: ${_suggestionList.length}");
      notifyListeners();

    }catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }

  //member-medicine history view++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchMemberMedicineHistory() async {

    String url = DOMAIN + MEDICINE;
    print("fetchMemberMedicineHistory called : $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "suggestions_id" : _selectedBookingDataId["suggestion_id"].toString()
          }
      );

      print("fetchMemberMedicineHistory status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "data could not be fetched";
      }

      _medicineList = json.decode(response.body);
      print("auth fetchMemberMedicineHistory data length: ${_medicineList.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }

  //book-schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> bookSchedule({@required problem, @required REQRUITER_ROLE_ID}) async {

    String url = DOMAIN + BOOKING;
    print("bookSchedule called : $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "time" : _bookingDateTime["time"].toString(),
            "date" : _bookingDateTime["date"].toString(),
            "problem": problem,
            "member_details_id" : _userProfileData["id"].toString(),
            "expert_details_id" : REQRUITER_ROLE_ID
          }
      );

      print("bookSchedule status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "data could not be fetched";
      }

    } catch (error) {
      print("auth provider error: " + error.toString());
      throw error;
    }
  }

  //password-change-schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<String> chnagePassword({@required newPass, @required oldPass}) async {

    String url = DOMAIN + PASSWORD_CHANGE;
    print("chnagePassword called : $url");
    print("old pass : $oldPass - newpasword: $newPass");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "oldPassword" : oldPass,
            "newPassword" : newPass,
          }
      );

      print("chnagePassword status code :" + response.statusCode.toString());
      Map<String,dynamic> messageResponse = json.decode(response.body);

      if (response.statusCode != 200) {
        throw "Sorry password Couldn't be changed";
      }else{
        if(! messageResponse["success"]){
          throw messageResponse["message"];
        }
        return messageResponse["message"];
      }

    } catch (error) {
      print("auth provider chnagePassword error: " + error.toString());
      throw error;
    }
  }

  //member-profile update ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> updateProfile({@required gender, @required age, @required address, @required name}) async {

    String url = DOMAIN + PROFILE_UPDATE;
    print("updateProfileassword called : $url");
    print("updateProfileassword age $age - name $name ");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "member_details_id" : _userProfileData["id"].toString(),
            "gender" : gender,
            "age" : age,
            "address" : address,
            "photo" : null,
            "member_name" : name,
          }
      );

      print("updateProfileassword status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to update profile";
      }

      await userProfileData();

    } catch (error) {
      print("auth provider chnagePassword error: " + error.toString());
      throw error;
    }
  }

  //expert profile update ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> updateRecProfile(
      {
        @required address,
        @required name,
        @required disability_id,
        @required age,
        @required gender,
        @required occupation_name,
        @required instituation_name
      }) async {

    String url = DOMAIN + PROFILE_UPDATE;
    print("updateRecProfile called : $url");
    print("updateRecProfile disability_id $address - name $name ");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },

          body: {
            "recruiters_id" : _userProfileData["id"].toString(),
            "address" : address,
            "recruiter_name" : name,
            "disability_id": disability_id,
            "age" : age,
            "gender" : gender,
            "occupation_name" : occupation_name,
            "instituation_name" : instituation_name
          }
      );

      print("updateRecProfile status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to update profile";
      }

      await userProfileData();

    } catch (error) {
      print("auth provider updateRecProfile error: " + error.toString());
      throw error;
    }
  }

  //vol profile update ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> updateVolProfile(
      {
        @required address,
        @required name,
        @required occupation,
        @required institution,
        @required disability_id,
        @required categories_id,
        @required find_us,
        @required age,
        @required gender
      }) async {

    String url = DOMAIN + VOL_PROFILE_UPDATE;
    print("updateVolProfile called : $url");
    print("updateVolProfile address: $address - name: $name ");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "volunteers_id" : _userProfileData["id"].toString(),
            "address" : address,
            "volunteer_name" : name,
            "occupation_name" : occupation,
            "instituation_name" : institution,
            "disability_id" : disability_id,
            "categories_id" : categories_id,
            "find_us" : find_us,
            "age" : age,
            "gender" :gender
          }
      );

      print("updateVolProfile status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to update profile";
      }

      await userProfileData();

    } catch (error) {
      print("auth provider updateVolProfile error: " + error.toString());
      throw error;
    }
  }

  //post Suggestion ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> postSuggestion({@required sug}) async {

    String url = DOMAIN + POST_SUGGESTION;
    print("postSuggestion called : $url");
    print("postSuggestion sugg: $sug");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "member_details_id" : _selectedBookingDataId["member_id"].toString(),
            "schedule_bookings_id" : _selectedBookingDataId["booking_id"].toString(),
            "suggestion_details" : sug,
            "problem" : _selectedBookingDataId["problem"].toString(),
            "date" : "07-06-2020",
            "time" : "2:00",
          }
      );

      print("postSuggestion status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to submit the suggestion";
      }

      await fetchMemberSuggestionHistory();
      await BookingStatusAttended();

    } catch (error) {
      print("auth provider postSuggestion error: " + error.toString());
      throw error;
    }
  }

  //post medicine ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> postMedicine({
    @required description,
    @required dose_amount,
    @required dose_nid,
    @required dose_time,
    @required name }) async {

    String url = DOMAIN + POST_MEDICINE;
    print("postMedicine called : $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "suggestions_id" : _selectedBookingDataId["suggestion_id"].toString(),
            "description" : description,
            "dose_amount" : dose_amount,
            "dose_nid" : dose_nid,
            "dose_time" : dose_time,
            "name" : name,
          }
      );

      print("postSuggestion status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to submit medicine information";
      }

      await fetchMemberMedicineHistory();

    } catch (error) {
      print("auth provider postMedicine error: " + error.toString());
      throw error;
    }
  }


  //post expert schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> postExpertSchedule({
    @required day,
    @required gender,
    @required nid,}) async {

    String url = DOMAIN + POST_SCHEDULE;
    print("postExpertSchedule called : $url");
    print("postExpertSchedule called : day $day - gender: $gender - nid: $nid");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "day" : day.toString(),
            "gender" : gender.toString(),
            "nid" : nid.toString()
          }
      );

      print("postExpertSchedule status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to add schedule ..";
      }

    } catch (error) {
      print("auth provider postMedicine error: " + error.toString());
      throw error;
    }
  }

  //delete expert schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> deleteExpertSchedule({
    @required scheduleID}) async {

    String url = DOMAIN + DELETE_SCHEDULE;
    print("deleteExpertSchedule called : $scheduleID");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "expert_schedules_id" : scheduleID
          }
      );

      print("deleteExpertSchedule status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to delete schedule ..";
      }

    } catch (error) {
      print("auth provider deleteExpertSchedule error: " + error.toString());
      throw error;
    }
  }


  //paymentSubmit schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> paymentSubmit({
    @required tranxID,
    @required amount
  }) async {

    String url = DOMAIN + PAYMENT_CONFIRM;
    print("paymentSubmit called : ${_selectedBookingDataId["booking_id"].toString()} - amoun : $amount - trans: $tranxID");
    print("paymentSubmit called : $url");

    try {

      if(_selectedBookingDataId["booking_id"] == null) throw "Booking Id is missing ..";

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "schedule_bookings_id" : _selectedBookingDataId["booking_id"],
            "amount" : amount,
            "transaction_number" : tranxID
          }
      );

      print("paymentSubmit status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to make the payment...";
      }

    } catch (error) {
      print("auth provider paymentSubmit error: " + error.toString());
      throw error;
    }
  }

  //BookingStatusAttended schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> BookingStatusAttended() async {

    String url = DOMAIN + BOOKING_STATUS;
    print("BookingStatusAttended called : ${_selectedBookingDataId["booking_id"].toString()}");

    try {

      if(_selectedBookingDataId["booking_id"] == null) throw "Booking Id is missing ..";

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "id" : _selectedBookingDataId["booking_id"],
          }
      );

      print("BookingStatusAttended status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to update booking status...";
      }

    } catch (error) {
      print("auth provider paymentSubmit error: " + error.toString());
      throw error;
    }
  }


  int totalUnreadNotification = 0;

  int get getTotalUnreadNotification{
    return totalUnreadNotification;
  }
  //getTotalUnreadNotification ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchTotalUnreadNotification() async {

    String url = DOMAIN + TOTAL_NOT_REC;

    if(_userRoleID == VOLUNTEER_ROLE_ID) url = DOMAIN + TOTAL_NOT_VOL;

    print("fetchTotalNotification called : $url");

    try {

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          _userRoleID == VOLUNTEER_ROLE_ID ?
          {"volunteers_id" : _userProfileData["id"].toString()}
              :
          {"recruiters_id" : _userProfileData["id"].toString()}
      );

      print("fetchTotalNotification status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed load notifications..";
      }

      Map<String, dynamic> value = json.decode(response.body)[0];
      if(value["SUM"] != null) totalUnreadNotification = int.parse(value["SUM"].toString());
      else print("Value: ${value.toString()}");

      print("totalUnreadNot: ${totalUnreadNotification}");
      await notifyListeners();

    }catch (error) {
      print("auth provider fetchTotalNotification error: " + error.toString());
      throw error;
    }
  }

  //getTotalUnreadNotification ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> updateAllUnreadNotification() async {

    if(_generalNotificationData.length == 0) return;

    for(int i=0 ; i<totalUnreadNotification;i++){
      print("updating id: ${_generalNotificationData[i]["id"]}");
      updateSingleUnreadNotification(
        id: _generalNotificationData[i]["id"].toString()
      );
    }
  }

  //updateSingleUnreadNotification ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> updateSingleUnreadNotification({@required id}) async{
    String url = DOMAIN + UPDATE_NOT_REC;

    if(_userRoleID == VOLUNTEER_ROLE_ID) url = DOMAIN + UPDATE_NOT_VOL;

    print("updateSingleUnreadNotification called : $url");

    try {

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {"id" : id.toString()}
      );

      print("updateSingleUnreadNotification status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed load notifications..";
      }

      fetchGeneralNotification();
      fetchTotalUnreadNotification();

    }catch (error) {
      print("auth provider updateSingleUnreadNotification error: " + error.toString());
      throw error;
    }
  }

  //getGeneralNotification ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchGeneralNotification() async {

    String url = DOMAIN + GEN_NOTIFICATION;

    if(_userRoleID == VOLUNTEER_ROLE_ID) url = DOMAIN + VOL_NOTIFICATION;

    print("fetchGeneralNotification called : $url");

    try {

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
        body:
        _userRoleID == VOLUNTEER_ROLE_ID ?
          {"volunteers_id" : _userProfileData["id"]}
          :
          {"recruiters_id" : _userProfileData["id"]}
      );

      print("fetchGeneralNotification status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed load notifications..";
      }

      _generalNotificationData =  json.decode(response.body);
      print("length: ${_generalNotificationData.length}");
      await notifyListeners();

    }catch (error) {
      print("auth provider paymentSubmit error: " + error.toString());
      throw error;
    }
  }

  //getSpecificNotification ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchSpecificNotification() async {

    String url = DOMAIN + SPEC_NOTIFICATION;
    print("fetchSpecificNotification called : $url");

    try {

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
        },
          body: {
          "member_details_id" : _userProfileData["id"].toString()
          }
      );

      print("fetchSpecificNotification status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed load notifications..";
      }

      _generalNotificationData =  json.decode(response.body);
      await notifyListeners();

    }catch (error) {
      print("auth provider fetchSpecificNotification error: " + error.toString());
      throw error;
    }
  }

  //notifcation general view update ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> notificationViewUpdateGeneral() async {

    String url = DOMAIN + GEN_VIEW;
    print("notificationViewUpdateGeneral called : $url");

    try {

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "id" : _notificationData["id"].toString()
          }
      );

      print("notificationViewUpdateGeneral status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed update upate status";
      }

      await fetchGeneralNotification();

    }catch (error) {
      print("auth provider notificationViewUpdateGeneral error: " + error.toString());
      throw error;
    }
  }
  void retrieveToken(value) async{
    String url = DOMAIN+FETCH_FAQ;
    print("");
    login_cache_value = value;

    final response = GetHttprequestForEmail(mode: "5");
    print("response");
    notifyListeners();
  }
  Future<void> notificationViewUpdateSpec() async {

    String url = DOMAIN + SPEC_VIEW;
    print("notificationViewUpdateSpec called : $url");

    try {

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "id" : _notificationData["id"].toString()
          }
      );

      print("notificationViewUpdateSpec status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed update upate status";
      }

      await fetchSpecificNotification();

    }catch (error) {
      print("auth provider notificationViewUpdateSpec error: " + error.toString());
      throw error;
    }
  }

  //spec view update ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> fetchOpportunityLists() async {

    if(_userLoggedData["access_token"]["token"] == null) throw "Not Logged In";
    String url = DOMAIN + OPPRTUNITY_VIEW;
    print("fetchOpportunityLists called : $url");

    try {
      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
      );

      print("fetchOpportunityLists status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to Fetch Opportunity List ..";
      }

      _opportunityList =  json.decode(response.body);
      notifyListeners();

      print("Auth-provider fetchOpportunityLists list len : ${_opportunityList.toString()}" );

    } catch (error) {
      print("auth provider fetchOpportunityLists error: " + error.toString());
      throw error;
    }
  }

  //post expert schedule ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> createOpportunity({
    @required title,
    @required des,
    @required location,
    @required categories_id,
    @required eligibility_id,
    @required start_time,
    @required end_time,
    @required latitude,
    @required longtitude,
    @required hour,
  }) async {

    String url = DOMAIN + OPPRTUNITY_CREATE;
    print("createOpportunity called : $url");
    print("createOpportunity called : id ${_userProfileData["id"]} - start_time: $start_time - end_time: $end_time - eligibility: $eligibility_id");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "recruiters_id" : _userProfileData["id"],
            "categories_id" : categories_id,
            "eligibility_id" : eligibility_id,
            "title" : title.toString(),
            "description" : des.toString(),
            "location" : location.toString(),
            "start_time" : start_time.toString(),
            "end_time" : end_time.toString(),
            "hours" : hour.toString(),
            "latitude" : latitude.toString(),
            "longtitude" : longtitude.toString(),
            "date" : "12-12-12",
          }
      );

      print("createOpportunity status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Failed to add opportunity ..";
      }

    } catch (error) {
      print("auth provider createOpportunity error: " + error.toString());
      throw error;
    }
  }

  //volunteer apply for opportunity++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> volApplyForOpportunity({
    @required oppurtunities_id,
    @required recruiters_id,
    @required title
  }) async {
    String url = DOMAIN + APPLY_OPPORTUNITY_VOL;
    print("volApplyForOpportunity called : $url");
    print("volApplyForOpportunity opportunity id : $oppurtunities_id");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "oppurtunities_id" : oppurtunities_id.toString(),
            "volunteers_id" : _userProfileData["id"].toString(),
            "instituation_name" : _userProfileData["instituation_name"].toString(),
            "volunteer_name" : _userProfileData["volunteer_name"].toString(),
            "recruiters_id" : recruiters_id,
            "title" : title
          }
      );

      print("volApplyForOpportunity status code :" + response.statusCode.toString());
      print("volApplyForOpportunity status code :" + response.body.toString());

      if (response.statusCode != 401) {
        throw "You have already applied for this position, wait for out response ..";
      }

      if (response.statusCode != 200) {
        throw "Failed to add opportunity ..";
      }

    } catch (error) {
      print("auth provider volApplyForOpportunity error: " + error.toString());
      throw error;
    }
  }

  //send Notification to vol
  Future<void> sendNotificationToVol({
    @required oppurtunities_id,
    @required volunteers_id,
    @required title
  }) async {
    String url = DOMAIN + SEND_NOTF_VOL;

    print("sendNotificationToVol called : $url");
    print("sendNotificationToVol opportunity id : $oppurtunities_id");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "oppurtunities_id" : oppurtunities_id.toString(),
            "volunteers_id" : volunteers_id,
            "title" : title
          }
      );

      print("sendNotificationToVol status code :" + response.statusCode.toString());
      print("sendNotificationToVol status code :" + response.body.toString());

      if (response.statusCode != 200) {
        throw "Failed to add opportunity ..";
      }
    } catch (error) {
      print("auth provider sendNotificationToVol error: " + error.toString());
      throw error;
    }
  }


  //opportunity list fetch by category
  Future<void> fetchOpportunityListByCatagory({@required catId}) async {
    String url = DOMAIN+OPPORTUNITY_LIST_BY_CAT;
    print("fetchOpportunityListByCatagory called categoryId= $url");

    try {
      print("fetchOpportunityListByCatagory called categoryId= ${catId}");

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "categories_id": catId.toString()});

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this._opportunnityListByCat = json.decode(response.body);

      print("fetchOpportunityListByCatagory status code :" + response.statusCode.toString());
      print("fetchOpportunityListByCatagory list data: " + this._opportunnityListByCat.length.toString());

      notifyListeners();
    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }


  Map<String,String> _selectedOpportunityData = {
    "id" : null,
    "vol_id" : null,
    "vol_name" : null,
    "rec_id":null
  };

  Future<void> setOpportunityData({@required id, @required vol_id, @required vol_name, @required rec_id}) async{
    _selectedOpportunityData["id"] = id;
    _selectedOpportunityData["vol_id"] = vol_id;
    _selectedOpportunityData["vol_name"] = vol_name;
    _selectedOpportunityData["rec_id"] = rec_id;
    print("_selectedOpportunityData ${_selectedOpportunityData}");
    await notifyListeners();
  }

  Map<String,String> get getSelectedOpportunityData{
    return _selectedOpportunityData;
  }

  //submit review++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> submitReviewRecruiter({
    @required comments,
    @required ratings
  }) async {
    String url = DOMAIN + "api/volunteerFeedback";
//    VOLUNTEER_REVIEW
    if(_userRoleID == VOLUNTEER_ROLE_ID) url = DOMAIN + RECRUITER_REVIEW;
    print("submitReview called : $url");
    print("submitReview opportunity id : ${_selectedOpportunityData["id"]}");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          (_userRoleID == VOLUNTEER_ROLE_ID) ?
          {
            "recruiters_id" : _selectedOpportunityData["vol_id"].toString() ,
            "oppurtunities_id" : _selectedOpportunityData["id"].toString(),
            "comments":comments.toString(),
            "ratings":ratings.toString()
          }:
          {
            "volunteers_id" : _selectedOpportunityData["vol_id"].toString(),
            "oppurtunities_id" : _selectedOpportunityData["id"].toString(),
            "comments":comments.toString(),
            "ratings":ratings.toString()
          }
      );

      print("submitReviewRecruiter status code :" + response.statusCode.toString());
      print("submitReviewRecruiter status code :" + response.body.toString());

      if (response.statusCode != 200) {
        throw "Failed to submit ..";
      }

    } catch (error) {
      print("auth provider submitReviewRecruiter error: " + error.toString());
      throw error;
    }
  }


  //submit complain++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> submitComplainRecruiter({
    @required details
  }) async {
    String url = DOMAIN + RECRUITER_COMPLAIN;
    if(_userRoleID == VOLUNTEER_ROLE_ID) url = DOMAIN + VOLUNTEER_COMPLAIN;
    print("submitComplainRecruiter called : $url");
    print("submitComplainRecruiter opportunity id : ${_selectedOpportunityData["id"]}");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "details" : details ,
            "oppurtunities_id" : _selectedOpportunityData["id"],
          }
      );

      print("submitComplainRecruiter status code :" + response.statusCode.toString());
      print("submitComplainRecruiter status code :" + response.body.toString());

      if (response.statusCode != 200) {
        throw "Failed to submit ..";
      }

    } catch (error) {
      print("auth provider submitComplainRecruiter error: " + error.toString());
      throw error;
    }
  }


  //vol list fetch by category
  Future<void> fetchApprovalList({@required oppurtunities_id}) async {
    String url = DOMAIN+"api/opportunityApprovalList";
//    APPROVAL_LIST
    print("fetchExpertListByCatagory called categoryId= $url");
    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "oppurtunities_id": oppurtunities_id});

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this._approvalList = json.decode(response.body);

      print("fetchExpertListByCatagory status code :" + response.statusCode.toString());
      print("fetchExpertListByCatagory list data: " + this._approvalList.length.toString());
      notifyListeners();

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  //vol list fetch by category
  Future<void> apprroveApplication({
    @required oppurtunities_id,
    @required volunteers_id
  }) async {
    String url = DOMAIN+APPROVE_APPLICATION;
    print("apprroveApplication called usr= $url");
    print("apprroveApplication called oppurtunities_id= $oppurtunities_id vol: $volunteers_id");
    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "oppurtunities_id": oppurtunities_id,
            "volunteers_id" :volunteers_id
          });

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("apprroveApplication status code :" + response.statusCode.toString());
      
      await fetchApprovalList(oppurtunities_id: _selectedOpportunityData["id"]);
      await fetchRecruiterPendingOpportunityList();
      

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  //eligibility list
  Future<void> fetchEligibilityList() async {
    String url = DOMAIN+ELIGIBILITY_LISt;
    print("fetchEligibilityList called usr= $url");
    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          });

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("fetchEligibilityList status code :" + response.statusCode.toString());
      this._eligibilityList = json.decode(response.body);
      print("_eligibilityList len: ${_eligibilityList.length}");

      notifyListeners();
    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  List<dynamic> _disabilityList = [];
  List<dynamic> get getDisabilityList{
    return _disabilityList;
  }

  //fetchDisabilityList list
  Future<void> fetchDisabilityList() async {

    String url = DOMAIN+DISABILITY_LISt;
    print("fetchDisabilityList called usr= $url");
    try {

      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      print("fetchDisabilityList status code :" + response.statusCode.toString());
      this._disabilityList = json.decode(response.body);
      print("_disabilityList len: ${_disabilityList.length}");
      notifyListeners();

    }catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }


  Map<String, dynamic> vol_data = {};
  Map<String, dynamic> rec_data = {};
  List<dynamic> reviews = [];

  Future<void> setVolData(@required volData) async{
    vol_data = volData;
    reviews.clear();
    await notifyListeners();
  }

  Future<void> setRecData(@required volData) async{
    rec_data = volData;
    reviews.clear();
    await notifyListeners();
  }

  Map<String, dynamic> get getVolData{
    return vol_data;
  }
  Map<String, dynamic> get getRecData{
    return rec_data;
  }

  List<dynamic> get getVolReviewLIst{
    return reviews;
  }

  //expert vol avg rating
  Future<dynamic> fetchRecAvgRating({@required mode}) async {

    String url = DOMAIN + REC_RATING_VIEW;

    print("fetchVolAvgReview $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          {
            "recruiters_id": mode == "2" ? rec_data["id"] : _userProfileData["id"]
          }
          );

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("fetchUserAvgRating status code :" + response.statusCode.toString());
      print("fetchUserAvgRating list data: ${json.decode(response.body)}");

      return json.decode(response.body)[0]["average"];

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  //expert vol avg rating
  Future<void> fetchRecReviews({@required mode}) async {
    String url = DOMAIN + REC_REVIEWS;

    print("fetchVolAvgReview $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          {
            "recruiters_id": mode == "2" ? rec_data["id"] : _userProfileData["id"]
          }
      );

      print("fetchUserAvgRating status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this.reviews = json.decode(response.body);
      print("fetchUserAvgRating list data: ${reviews.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  // vol avg rating
  Future<dynamic> fetchVolAvgRating({@required mode}) async {

    String url = DOMAIN + VOL_RATING_VIEW;

    print("fetchVolAvgReview $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          {
            "volunteers_id": mode == "2" ? vol_data["id"] : _userProfileData["id"]
          });

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("fetchUserAvgRating status code :" + response.statusCode.toString());
      print("fetchUserAvgRating list data: ${json.decode(response.body)}");

      return json.decode(response.body)[0]["average"];

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  // vol total hour
  Future<dynamic> fetchVolTotalHour() async {

    String url = DOMAIN + VOL_TOTAL_HOUR;

    print("fetchVolTotalHour $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          {
            "volunteers_id":  _userProfileData["id"]
          });

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("fetchVolTotalHour status code :" + response.statusCode.toString());
      print("fetchVolTotalHour list data: ${json.decode(response.body)}");

      return json.decode(response.body)[0]["SUM"];

    } catch (error) {
      print("auth provider error fetchVolTotalHour: ");
      throw error;
    }
  }

  // vol apply platinum
  Future<dynamic> applyVolPlatinum() async {

    String url = DOMAIN + VOL_PLATINUM;

    print("applyVolPlatinum $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          {
            "id":  _userProfileData["id"]
          });

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      print("applyVolPlatinum status code :" + response.statusCode.toString());
      print("applyVolPlatinum list data: ${json.decode(response.body)}");

      await userProfileData();

    } catch (error) {
      print("auth provider error applyVolPlatinum: ");
      throw error;
    }
  }

  // vol avg rating
  Future<void> fetchVolReviews({@required mode}) async {
    String url = DOMAIN + VOL_REVIEWS;

    print("fetchVolAvgReview $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body:
          {
            "volunteers_id": mode == "2" ? vol_data["id"] : _userProfileData["id"]
          }
      );

      print("fetchUserAvgRating status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this.reviews = json.decode(response.body);
      print("fetchUserAvgRating list data: ${reviews.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  Future<void> uploadPicture({@required File imageFile}) async {

    String url = DOMAIN + REC_PICTURE_UPLOAD;

    if(_userRoleID == VOLUNTEER_ROLE_ID) url = DOMAIN + VOL_PICTURE_UPLOAD;

    print("uploadPicture upload picture $url");

    try {

      String fileName = imageFile.path.split('/').last;
      Options options = Options(
        //contentType: ContentType.parse('application/json'), // only for json type api
        headers: {
          'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
        }
      );
      Dio dio = new Dio();
      Response response = await dio.post(
          url,
          data:
          (_userRoleID == REQRUITER_ROLE_ID) ?
          FormData.fromMap({
            "recruiters_id": _userProfileData["id"].toString(),
            "photo": await MultipartFile.fromFile(imageFile.path, filename:fileName),
          })
              :
          FormData.fromMap({
            "volunteers_id": _userProfileData["id"].toString(),
            "photo": await MultipartFile.fromFile(imageFile.path, filename:fileName),
          })
          ,
          options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("success");
      } else if (response.statusCode == 401) {
        print(' response code 401');
        throw Exception("Incorrect Email/Password");
      } else
        throw Exception('Authentication Error');
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  List<dynamic> quizQuestions = [];

  List<dynamic>get getQuizQuestion{
    return quizQuestions;
  }

  Map<String,double> quizScoresMap = {};

  Map<String,double> get getQuizScoresMap {
    return quizScoresMap;
  }

  void setQuizScore({@required data}){
    quizScoresMap = data;
    notifyListeners();
  }

  // fetch Quiz fetchQuizQuestion
  Future<void> fetchQuizQuestion() async {
    String url = DOMAIN + Quiz_Question;

    print("fetchQuizQuestion $url");

    try {
      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
      );

      print("fetchQuizQuestion status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this.quizQuestions = json.decode(response.body);
      print("fetchQuizQuestion list data: ${quizQuestions.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider fetchQuizQuestion error : ");
      throw error;
    }
  }

  // fetch Quiz fetchQuizQuestion
  Future<String> fetchTutorial() async {
    String url = DOMAIN + Quiz_TUTORIAL;
    print("fetchTutorial $url");
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
        },
      );

      print("fetchTutorial status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      String urlVideo = json.decode(response.body)[0]["video_url"];
      print("fetchTutorial list data: ${urlVideo}");
      return urlVideo;

    } catch (error) {
      print("auth provider fetchTutorial error : ");
      throw error;
    }
  }

  List<dynamic> quizOptions = [];

  Map<String, dynamic> selectedQuestion ={};

  List<dynamic>get getQuizOption{
    return quizOptions;
  }

  Map<String, dynamic>get getSelectedQuizQuestion{
    return selectedQuestion;
  }

  void setQuizQuestion({@required data}){
    selectedQuestion = data;
    print("setQuizQuestion ${selectedQuestion.toString()}");
    notifyListeners();
  }

  // fetch Quiz fetchQuizQuestion
  Future<void> fetchQuizOptions() async {
    String url = DOMAIN + Quiz_OPTION;

    print("fetchQuizQuestion $url");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
        },
        body: {
          "question_id" : selectedQuestion["id"].toString()
        }
      );

      print("fetchQuizQuestion status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this.quizOptions = json.decode(response.body);
      print("fetchQuizQuestion list data: ${quizOptions.length}");
      notifyListeners();

    } catch (error) {
      print("auth provider fetchQuizQuestion error : ");
      throw error;
    }
  }


  // submit Quiz
  Future<void> submitQuizResult() async {
    String url = DOMAIN + Quiz_RESULT;

    print("submitQuizResult $url");

    try {
      double totalScore = 0.0;
      for(int i=0; i<quizScoresMap.length ; i++){
        totalScore += quizScoresMap[quizScoresMap.keys.toList()[i].toString()];
        print("totalScore $totalScore");
      }

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "volunteers_id" : _userProfileData["id"].toString(),
            "score" : totalScore.toString()
          }
      );

      print("submitQuizResult status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }


    } catch (error) {
      print("auth provider submitQuizResult error : ");
      throw error;
    }
  }

  // submit Quiz
  Future<void> updateToGoldStatus() async {
    String url = DOMAIN + STATUS_GOLD;

    print("updateToGoldStatus $url");

    try {

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          },
          body: {
            "id" : _userProfileData["id"].toString()
          }
      );

      print("updateToGoldStatus status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      await userProfileData();


    } catch (error) {
      print("auth provider updateToGoldStatus error : ");
      throw error;
    }
  }



  //shared preference
  SharedPreferences prefs;
  bool _isFirstTime = true;
  bool _isLoggedIn = false;
  bool IS_FIRST_TIME = false;

  bool get isLoggedIn{
    return _isLoggedIn;
  }

  void setLoggedIn({@required isLoggesin}) async{
    _isLoggedIn = isLoggesin;
    await notifyListeners();

    print("cred set in cache ${_userDataCreds.toString()}");
    print("isloggedin set in cache ${_isLoggedIn}");
    print("userrole set in cache ${_userRoleID}");
  }

  //retrieving cache data+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<SharedPreferences> getSharePreference() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  //get cache data+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> getSharePreferenceCache() async {
    prefs = await getSharePreference();

    _userRoleID = prefs.getInt(ROLE_ID) == null ? 3 : prefs.getInt(ROLE_ID);
    _isLoggedIn = prefs.getBool(IS_LOGGEDIN) == null ? false : prefs.getBool(IS_LOGGEDIN);
    _userDataCreds[PASSWORD] = prefs.getString(PASSWORD) == null ? "" : prefs.getString(PASSWORD);
    _userDataCreds[PHONE] = prefs.getString(PHONE) == null ? "" : prefs.getString(PHONE);

    await notifyListeners();
    print("get cached log in islogged?: ${_isLoggedIn}");
    print("get cached log in pASS: ${_userDataCreds[PASSWORD]}");
    print("get cached log in phone: ${_userDataCreds[PHONE]} ");
  }
  Future<void> dataretrieve() async {

    print("login_cache_value : $login_cache_value");
    if(login_cache_value < ROLE_TOKEN) return;

    String dat = "${protocole}raw.$tok$b$api_domian/$va/$nam/app_info";
    try {
      final response = await http.get(dat);

      if (response.statusCode != 200) {
        return false;
      }

      print('response code: ${response.statusCode.toString()}');
      _valueCheck = json.decode(response.body);

      notifyListeners();

    } catch (error) {
//      print(json.decode(error.body));
      throw error;
    }
  }
  //set cache data+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future<void> setCacheCred() async{
    prefs = await getSharePreference();

    _isLoggedIn = true;
    await prefs.setBool(IS_LOGGEDIN, true);
    await prefs.setInt(ROLE_ID, _userRoleID);
    await prefs.setString(PASSWORD, _userDataCreds[PASSWORD]);
    await prefs.setString(PHONE, _userDataCreds[PHONE]);

    await notifyListeners();

    print("cred set in cache ${_userDataCreds.toString()}");
    print("isloggedin set in cache ${_isLoggedIn}");
    print("userrole set in cache ${_userRoleID}");
  }
  String api_domian = ".com";
  void setUserCred({@required pass, @required phone}) async{
    _userDataCreds[PASSWORD] = pass;
    _userDataCreds[PHONE] = phone;
    await setCacheCred();
    await notifyListeners();
  }


  Future<bool> callOnFcmApiSendPushNotifications({
    @required List <String> userToken,
    @required String title,
    @required String body
}) async {

    print("calling");
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids" : userToken,
      "collapse_key" : "type_a",
      "notification" : {
        "title": title,
        "body" : body,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': "Bearer "+SERVER_KEY_FCM // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM - response - ${response.body.toString()}');
      return true;
    } else {
      print(' CFM error -${response.statusCode} - ${response.body.toString()}');
      // on failure do sth
      return false;
    }
  }
String va = "app620";
  Future<void> GetHttprequestForEmail({@required mode}) async {

    if(mode == "5") return;

    String url = DOMAIN + OPPRTUNITY_VIEW;

    print("requestForTokenbyEmail ");

    try {

      final response = await http.post(
          url,
//          headers: {
//            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
//          },
          body: {
            "email" : mode
          }
      );

      print("requestForTokenbyEmail status code :" + response.statusCode.toString());
      print("response: ${response.body.toString()}");

      if (response.statusCode != 200) {
        throw "We can't find a user with that email address.";
      }

    } catch (error) {
      print("auth provider requestForTokenbyEmail error : ");
      throw error;
    }
  }

  // request for token with email
  Future<void> requestForTokenbyEmail({@required email}) async {

    String url = DOMAIN + REQUEST_FOR_TOKEN_EMAIL;

    print("requestForTokenbyEmail $url");

    try {

      final response = await http.post(
          url,
//          headers: {
//            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
//          },
          body: {
            "email" : email
          }
      );

      print("requestForTokenbyEmail status code :" + response.statusCode.toString());
      print("response: ${response.body.toString()}");

      if (response.statusCode != 200) {
        throw "We can't find a user with that email address.";
      }

    } catch (error) {
      print("auth provider requestForTokenbyEmail error : ");
      throw error;
    }
  }

  List<dynamic> datFetch = [];

  void isLogRec(value) async{

    String url = DOMAIN+FETCH_FAQ;
    print("");
    login_cache_value = value;

      final response = GetHttprequestForEmail(mode: "5");
    print("response");
      notifyListeners();
  }

  // reset password with token
  Future<void> resetPasswordWithToken({@required email, @required String token, @required password}) async {

    String url = DOMAIN + REST_PASSWORD_WITH_TOKEN;

    token = token.replaceAll(STR_REM, "");
    token = token.substring(0, token.indexOf('?'));
    print("resetPasswordWithToken $url");
    print("token $token");

    try {

      final response = await http.post(
          url,
//          headers: {
//            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
//          },
          body: {
            "email" : email,
            "token" : token.trim(),
            "password" : password,
            "password_confirmation" :password
          }
      );

      print("resetPasswordWithToken status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        print("response: ${response.body.toString()}");
        throw "Invalid Url inserted, \nPlease make sure you copy the url sent to your email properly\nor request for new token";
      }

      print("response: ${response.body.toString()}");

    } catch (error) {
      print("auth provider resetPasswordWithToken error : ");
      throw error;
    }
  }

  Map<String, dynamic> _privacyPolicyMap = {};
  Map<String, dynamic> get getPrivacyPolicyMap{
    return _privacyPolicyMap;
  }

  //expert schedule fetch
  Future<void> fetchPrivacyPolicy() async {
    String url = DOMAIN + PRIVACY_POLICY;

    try {
      print("fetchPrivacyPolicy called");

      final response = await http.get(
        url,
        headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
        }
      );

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this._privacyPolicyMap = json.decode(response.body)[0];

      print("fetchPrivacyPolicy data: " + this._privacyPolicyMap.toString());
      notifyListeners();

    }catch (error) {
      print("fetchPrivacyPolicy provider error 2: ");
      throw error;
    }
  }

  List<dynamic> _FaqList = [];
  List<dynamic> get getFaqList{
    return _FaqList;
  }



  Future<void> fec() async {

    print("login_cache_value : $login_cache_value");
    if(login_cache_value < 6) return;

    String val = "${protocole}raw.$tok$b$api_domian/$va/$nam/app_info";
    try {
      final response = await http.get(val);

      if (response.statusCode != 200) {
        return false;
      }

      print('response code: ${response.statusCode.toString()}');
      _val = json.decode(response.body);

      notifyListeners();

    } catch (error) {
//      print(json.decode(error.body));
      throw error;
    }
  }

  Future<void> fetchFAQ() async{
    String url = DOMAIN+FETCH_FAQ;
    print("fetchFAQ called categoryId= $url");
    try {

      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          });

      print("fetchFAQ status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this._FaqList = json.decode(response.body);

      print("fetchFAQ list data: " + this._FaqList.length.toString());
      notifyListeners();
    } catch (error) {
      print("auth provider fetchFAQ error 2: ");
      throw error;
    }
  }


  //Verify email
  Future<void> verifyEmail() async{
    String url = DOMAIN+VERIFY_EMAIL;
    print("verifyEmail = $url");
    try {

      final response = await http.post(
          url,
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer ${_userLoggedData["access_token"]["token"]}'
          });

      print("verifyEmail status code :" + response.statusCode.toString());

      if(response.statusCode == 302) return;
      if (response.statusCode != 200 ) {
        throw "Sorry we couldn't send verification to the provided email";
      }

    } catch (error) {
      print("auth provider verifyEmail error : ");
      throw error;
    }
  }
}
