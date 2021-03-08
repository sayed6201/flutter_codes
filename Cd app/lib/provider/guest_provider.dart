import 'package:flutter/cupertino.dart';
import 'package:crowdv/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:crowdv/string.dart';

class GuestProvider with ChangeNotifier {

  List<dynamic> _catagoryList = [];
  List<dynamic> _volList = [];
  List<dynamic> _opportunityList = [];

  Map<String,dynamic> _selectedCategoryInfo = {
    CATAGORY_ID : "",
    CATAGORY_NAME : ""
  };

  Map<String, dynamic> _selectedDoctorInfo = {};
  Map<String,String> _categoryIdMap = {};

  List<dynamic> _expertSchedule = [];
  
  List<dynamic> get getCatagoryList{
    return _catagoryList;
  }

  List<dynamic> get getVolList{
    return _volList;
  }

  List<dynamic> get getOpportunityList{
    return _opportunityList;
  }

  Map<String,dynamic> get getSelectedCategoryInfo{
    return _selectedCategoryInfo;
  }

  Map<String,String> get getCategoryMap{
    return _categoryIdMap;
  }

  Map<String,dynamic> get getSelectedDoctorInfo{
    return _selectedDoctorInfo;
  }

  List<dynamic> get getSelectedDoctorSchedule{
    return _expertSchedule;
  }
  
  void setCategoryInfo({@required var categoryId, @required var catagoryName}) async{
    _selectedCategoryInfo[CATAGORY_NAME] = catagoryName;
    _selectedCategoryInfo[CATAGORY_ID] = categoryId;
    await notifyListeners();
  }

  void setDoctorInfo({@required doctorData}) async{
    _selectedDoctorInfo = doctorData;
    await notifyListeners();
  }


  //expert catagory fecth
  Future<void> fetchExpertCatagoryList() async {
    String url = DOMAIN+CATAGORY_LIST;
    try {
      print("fetchExpert_catagoryList called $url");
      print("before call");
      final response = await http.get(url);
      print("after call");
      if (response.statusCode != 200) {
        print("errr status code");
        throw "Oops ! something went wrong";
      }
      this._catagoryList = json.decode(response.body);
      print("${_catagoryList.toString()}");

      for(var i = 0; i < _catagoryList.length; i++){
        _categoryIdMap[_catagoryList[i]['category_name']] = _catagoryList[i]['id'].toString();
      }

      print("fetchExpert_catagoryID Map :" + _categoryIdMap.toString());
      print("fetchExpert_catagoryList status code :" + response.statusCode.toString());
      print("fetchExpert_catagoryList list data: " + this._catagoryList.length.toString());

      notifyListeners();
    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  //vol list fetch by category
  Future<void> fetchVolListByCatagory() async {
    String url = DOMAIN+VOL_LIST;
    print("fetchExpertListByCatagory called categoryId= $url");
    try {
      print("fetchExpertListByCatagory called categoryId= ${_selectedCategoryInfo[CATAGORY_ID]}");

      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body:
          json.encode(
          {"categories_id": _selectedCategoryInfo[CATAGORY_ID]}
          )
      );

      print("fetchExpertListByCatagory status code :" + response.statusCode.toString());

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this._volList = json.decode(response.body);

      print("fetchExpertListByCatagory list data: " + this._volList.length.toString());
      notifyListeners();
    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }


  List<dynamic> recentRecList = [];
  List<dynamic> recentVolList = [];

  List<dynamic> get getRecentRecList{
    return recentRecList;
  }

  List<dynamic> get getRecentVolList{
    return recentVolList;
  }

  //recent recruiter
  Future<void> fetchRecentRecruiter() async {

//    if(recentRecList.length > 0) return;

    String url = DOMAIN+RECENT_RECRUITER_LIST;
    try {
      print("fetchRecentRecruiter called $url");

      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this.recentRecList = json.decode(response.body);

      print("fetchRecentRecruiter list len: ${recentRecList.length}");

      notifyListeners();
    } catch (error) {
      print("auth provider error: $error");
      throw error;
    }
  }

  //recent vol
  Future<void> fetchRecentVol() async {

//    if(recentVolList.length > 0) return;

    String url = DOMAIN+RECENT_VOLUNTEER_LIST;
    try {
      print("fetchRecentVol called $url");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this.recentVolList = json.decode(response.body);

      print("fetchRecentVol list len : ${recentVolList.length}");

      notifyListeners();
    } catch (error) {
      print("auth provider error: $error");
      throw error;
    }
  }

  //expert schedule fetch
  Future<void> fetchExpertSchedule({expertId = null}) async {
    String url = DOMAIN + SCHEDULE_VIEW;

    String id = expertId ?? _selectedDoctorInfo["id"].toString();
    print("fetchExpertSchedule id= $id");

    try {
      print("fetchExpertSchedule called categoryId= ${_selectedDoctorInfo["id"]}");

      final response = await http.post(
          url,
          body: {
            "expert_details_id": id
          });

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this._expertSchedule = json.decode(response.body);

      print("fetchExpertSchedule status code :" + response.statusCode.toString());
      print("fetchExpertSchedule list data: " + this._volList.length.toString());

      notifyListeners();

    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }

  //vol list fetch by category
  Future<void> fetchApplicationList() async {
    String url = DOMAIN+VOL_LIST;
    print("fetchExpertListByCatagory called categoryId= $url");
    try {
      print("fetchExpertListByCatagory called categoryId= ${_selectedCategoryInfo[CATAGORY_ID]}");

      final response = await http.post(
          url,
          body: {
            "categories_id": _selectedCategoryInfo[CATAGORY_ID].toString()});

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }
      this._volList = json.decode(response.body);

      print("fetchExpertListByCatagory status code :" + response.statusCode.toString());
      print("fetchExpertListByCatagory list data: " + this._volList.length.toString());
      notifyListeners();
    } catch (error) {
      print("auth provider error 2: ");
      throw error;
    }
  }


  Map<String, dynamic> _aboutUsMap = {};
  Map<String, dynamic> get getAboutus{
    return _aboutUsMap;
  }

  //expert schedule fetch
  Future<void> fetch13() async {
    String url = DOMAIN + ABOUT_US;

    try {
      print("fetchAboutUs called");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw "Oops ! something went wrong";
      }

      this._aboutUsMap = json.decode(response.body)[0];

      print("_aboutUsMap data: " + this._aboutUsMap.toString());
      notifyListeners();

    } catch (error) {
      print("_aboutUsMap provider error 2: ");
      throw error;
    }
  }

}
