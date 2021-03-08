import 'package:crowdv/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/auth_screens/login_screen.dart';
import 'package:crowdv/screens/auth_screens/sign_up.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';
import 'auth_screens/user_choosing_screen.dart';

class RecruiterProfileSetup extends StatefulWidget {
  static final String tag  ="/RecruiterProfileSetup";
  @override
  _RecruiterProfileSetupState createState() => _RecruiterProfileSetupState();
}

class _RecruiterProfileSetupState extends State<RecruiterProfileSetup> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String title_text = "Profile";
  String btn_text = "Register";

  List<String> gender = [
    "Male",
    "Female",
    "Others",
    "Prefer not to disclose"
  ];

  Map<String,String> routeData= {};
  Map<String,dynamic> profileData = {};

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var occupationController = TextEditingController();
  var InstituationNameController = TextEditingController();
  var nidFieldController = TextEditingController();
  var ageController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var phoneController = TextEditingController();

  var passObsecure = true;

  var _isLoading = true;
  var isBtnSelected = 0;
  var _isInit = true;
  var _profieCase = "1";
  String SELECT_CATEGORY_TEXT = "Select Category";
  String _categoryName = "Select Category";
  Map<String,dynamic> caregoryId;
  List<String> _selecteddisabilityList = [];
  List<dynamic> disabilityList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isInit){

      await Provider.of<GuestProvider>(context).fetchExpertCatagoryList();

      routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;

      print(routeData['title']+" - "+routeData['btn_text']);

      setState(() {
        title_text = routeData['title'];
        btn_text = routeData['btn_text'];
        _profieCase = routeData['is_signup'];
      });

      if(_profieCase != "1"){
        profileData = Provider.of<AuthProvider>(context,listen: false).getAData;
        nameController.text = profileData["recruiter_name"];
        addressController.text = profileData["address"];
        InstituationNameController.text = profileData["instituation_name"];
        occupationController.text = profileData["occupation_name"];

        print("data setup ${nameController.text} - ${addressController.text}- ${InstituationNameController.text} - ${nidFieldController.text}");
      }
      caregoryId = Provider.of<GuestProvider>(context,listen: false).getCategoryMap;

      setState(() {
        _categoryName =  caregoryId.keys.toList()[0].toString();
      });
      await Provider.of<AuthProvider>(context,listen: false).fetchDisabilityList();
      setState(() {
        disabilityList =  Provider.of<AuthProvider>(context,listen: false).getDisabilityList;
        _isLoading = false;
      });
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
//    caregoryId = Provider.of<GuestProvider>(context).getnidFieldMap;

    //phone++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final phone = TextFormField(
      keyboardType: TextInputType.phone,
      controller: phoneController,
      autovalidate: true,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        }else if (val.length < 10 && val.length > 13) {
          return"Invalid Phone Number";
        }else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Phone',
        icon: Icon(Icons.phone_android),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //Password++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final pass = TextFormField(
      keyboardType: TextInputType.text,
      controller: passController,
      autofocus: false,
      autovalidate: true,
      obscureText: passObsecure,
      cursorColor: primaryColor.withOpacity(0.4),
      validator: (val) {
        if (val.length < 6) {
          return"Password must be at lest 6 char long";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Password',
        icon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
          icon: Icon(
            passObsecure ? Icons.visibility : Icons.visibility_off,
            color: primaryColor,
          ),
          onPressed: (){
            setState(() {
              passObsecure = ! passObsecure;
            });
          },
        ),
      ),
    );

    //Confirm Password++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final confPass = TextFormField(
      keyboardType: TextInputType.text,
      controller: confirmPassController,
      autofocus: false,
      autovalidate: true,
      obscureText: passObsecure,
      cursorColor: primaryColor.withOpacity(0.4),
      validator: (val) {
        if (passController.text.toString() != confirmPassController.text.toString() ) {
          return "Password Does not match";
        }
        else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        icon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
          icon: Icon(
            passObsecure ? Icons.visibility : Icons.visibility_off,
            color: primaryColor,
          ),
          onPressed: (){
            setState(() {
              passObsecure = ! passObsecure;
            });
          },
        ),
      ),
    );


    //name++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final name = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidate: true,
      controller: nameController,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        }
        if (val.length < 3) {
          return "Name must be 3 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Your name',
        icon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //Email++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autovalidate: true,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Email',
        icon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //address++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final address = TextFormField(
      keyboardType: TextInputType.text,
      autovalidate: true,
      controller: addressController,
      autofocus: false,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Location',
        icon: Icon(Icons.location_on),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      validator: (val) {
        if (val.isEmpty) {
          return "Must be filled";
        } else {
          return null;
        }
      },
    );


    //bmdc++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final occupationName = TextFormField(
      keyboardType: TextInputType.text,
      controller: occupationController,
      autovalidate: true,
      autofocus: false,
      validator:(val){
//        if (val.isEmpty) {
//          return "must be filled";
//        } else {
          return null;
//        }
      },
      decoration: InputDecoration(
        hintText: 'Enter Your Profession',
        icon: Icon(Icons.credit_card),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );


    //InstituationName++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final InstituationName = TextFormField(
      keyboardType: TextInputType.text,
      controller: InstituationNameController,
      autovalidate: true,
      autofocus: false,
      validator:(val){
//        if (val.isEmpty) {
//          return "Must be filled";
//        } else {
          return null;
//        }
      },
      decoration: InputDecoration(
        hintText: 'Enter Instituation Name',
        icon: Icon(Icons.credit_card),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    //nidFieldController++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    final nidField = TextFormField(
//      keyboardType: TextInputType.number,
//      controller: nidFieldController,
//      autovalidate: true,
//      autofocus: false,
//      validator:(val){
//        if (val.isEmpty) {
//          return "Must be filled";
//        } else {
//          return null;
//        }
//      },
//      decoration: InputDecoration(
//        hintText: 'Enter NID',
//        icon: Icon(Icons.credit_card),
//        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//      ),
//    );


    //ageFieldController++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    final age = TextFormField(
//      keyboardType: TextInputType.number,
//      controller: ageController,
//      autovalidate: true,
//      autofocus: false,
//      validator:(val){
//        if (val.isEmpty) {
//          return "Must be filled";
//        } else {
//          return null;
//        }
//      },
//      decoration: InputDecoration(
//        hintText: 'Enter Age',
//        icon: Icon(Icons.credit_card),
//        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//      ),
//    );

    //registration Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final regButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 0),
        child: RaisedButton(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            validation();
          },
          padding: EdgeInsets.all(12),
          color: primaryColor,
          child: Text(
              btn_text,
              style: TextStyle(color: Colors.white,letterSpacing: 1)),
        ),
      ),
    );


    final formUi = Form(
      key: _formKey,
      autovalidate: true,
      child:
      Column(
        children: <Widget>[

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: name,
          ),

          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          if(_profieCase == "1")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: phone,
            ),

          if(_profieCase == "1")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: email,
            ),


          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          if(_profieCase == "1")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: pass,
            ),

          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          if(_profieCase == "1")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: confPass,
            ),


          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: address,
          ),

          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

//          if(_profieCase == "1")
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: InstituationName,
          ),


//          if(_profieCase == "1")
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

//          if(_profieCase == "1")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: occupationName,
            ),

//          if(_profieCase == "1")
          SizedBox(height: SizeConfig.blockSizeVertical * 2),

//          if(_profieCase == "1")
//          Padding(
//            padding: EdgeInsets.symmetric(horizontal: 5),
//            child: nidField,
//          ),
//
//          if(_profieCase == "1")
//          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),

//          if(_profieCase == "1")
//          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
//
//          if(_profieCase == "1")
//          //Category, +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//          Align(
//            alignment: Alignment.centerLeft,
//            child: Container(
//              padding: EdgeInsets.symmetric(horizontal: 5),
//              margin: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal * 10),
//              child: Text('Select Caategory', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
//            ),
//          ),
//
//          if(_profieCase == "1")
//          SizedBox(height: SizeConfig.blockSizeVertical * 1),
//
//          if(caregoryId != null && _profieCase == "1")
//            Padding(
//                padding: EdgeInsets.symmetric(horizontal: 5),
//                child: Container(
//                  width: SizeConfig.blockSizeHorizontal * 70,
//                  padding: EdgeInsets.symmetric(horizontal: 10),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(5),
//                      border: Border.all(color: Theme.of(context).primaryColor)
//                  ),
//                  child: DropdownButton<String>(
//                    value: caregoryId == null ? null : _categoryName ,
//                    icon: Icon(Icons.arrow_drop_down),
//                    hint: Text("Select Category"),
//                    iconSize: 24,
//                    elevation: 16,
//                    style: TextStyle(
//                        color: Colors.deepPurple
//                    ),
////                underline: Container(
////                  height: 1,
////                  color: Theme.of(context).primaryColor,
////                ),
//                    onChanged: (String newValue) {
//                      setState(() {
//                        _categoryName = newValue;
//                        print("selected $_categoryName");
//                        print("selected id ${caregoryId[_categoryName]}");
//                      });
//                    },
//                    items: caregoryId.keys.toList()
////                <String>[SELECT_CATEGORY_TEXT, 'Male', 'Female', 'Others']
//                        .map<DropdownMenuItem<String>>((String value) {
//                      return DropdownMenuItem<String>(
//                        value: value,
//                        child: Text(value),
//                      );
//                    })
//                        .toList(),
//                  ),
//                )
////            nidField,
//            ),
//
//          if(_profieCase == "1")
//            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),


            SizedBox(height: SizeConfig.blockSizeVertical * 3.0),


            _isLoading ?
            Center(
              child: LoaderWidget(
                text: "Loading data",
              ),
            )
                :
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    margin: EdgeInsets.only( left: SizeConfig.blockSizeHorizontal * 10),
                    child: Text('Choose Disability', style: TextStyle(color: Colors.grey,fontSize: 17 ,fontWeight: FontWeight.bold),),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 1,
//                      childAspectRatio: 10,
//                      crossAxisSpacing: 5,
//                      mainAxisSpacing: 5,
//                    ),
                    itemCount: disabilityList.length,
                    itemBuilder: (ctx, index){
                      return  CheckboxListTile(
                        dense: true,
                        value: _selecteddisabilityList.contains(disabilityList[index]["id"].toString()) ? true : false,
                        onChanged: (v){
                          if(mounted){
                            setState(() {
                              print("v: $v");
                              if(_selecteddisabilityList.contains(disabilityList[index]["id"].toString())){
                                _selecteddisabilityList.remove(disabilityList[index]["id"].toString());
                              }else{
//                                if(_selecteddisabilityList.length > 0)
//                                  _selecteddisabilityList.removeLast();
//                                if(_selecteddisabilityList.length < 1)
                                  _selecteddisabilityList.add(disabilityList[index]["id"].toString());
                              }
                              print("added list: ${_selecteddisabilityList.toString()}");
                              print("added len: ${_selecteddisabilityList.length}");
                            });
                          }
                        },
                        title:  Text(disabilityList[index]["disability_name"], style: TextStyle(fontSize: 13),),
                        controlAffinity: ListTileControlAffinity.leading,
//                     subtitle: new Text('Subtitle'),
//                     secondary:  Icon(Icons.bookmark, color: primaryColor,),
                        activeColor: Colors.red,
                      );
                    }
                )
              ],
            ),

            SizedBox(height: SizeConfig.blockSizeVertical * 4.0),

          //date field ............................
//          if(_profieCase == "1")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      highlightColor: Colors.orange,
                      icon: Icon(Icons.date_range, color: primaryColor,),
                      iconSize: 50,
                      onPressed: (){
                        _selectDate(context);
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Choose Birthdate: ",
                          style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          dateText,
                          style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

//          if(_profieCase == "1")
          SizedBox(height: SizeConfig.blockSizeVertical * 2),

//          if(_profieCase == "1")
          buildButton(),

          SizedBox(height: SizeConfig.blockSizeVertical * 4),

          _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          )
              :regButton,
          SizedBox(height: SizeConfig.blockSizeVertical * 5),

        ],
      ),
    );

    return Scaffold(
        body:
        //in stack widgets are placed on top of each other================================================================
        Stack(children: [

          //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
          SingleChildScrollView(
            child:Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15, bottom: SizeConfig.blockSizeVertical * 5),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5
              ),
              child:
              _isLoading ?
              Center(
                child: LoaderWidget(text: "Loading ... \nwe are fetching required information ..."),
              ):
              formUi,
            ),
          ),

          //App-bar ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: SizeConfig.blockSizeVertical * 15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.statusBarSize,
                    ),
                    //app-bar data=========================================
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )),
                        Expanded(
                          child: Text(
                            title_text,
                            textAlign: TextAlign.center,
                            style: heading_style.copyWith(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight, child: Text(" ")))
                      ],
                    ),
//                    Divider(),
//                    SizedBox(
//                      height: SizeConfig.blockSizeVertical * 1,
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          title_text,
//                          style: heading_style.copyWith(
//                            fontSize: SizeConfig.blockSizeVertical * 2,
//                          ),
//                        ),
////                    Container(
////                      margin: EdgeInsets.only(
////                          top: SizeConfig.blockSizeVertical * 0.5),
////                      child: Icon(
////                        FontAwesomeIcons.search,
////                        color: Colors.white70,
////                      ),
////                    ),
//                      ],
//                    )
                  ],
                ),
              )),
        ]));
  }

  Widget buildButton() {
    TextStyle selectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.bold, color: Colors.white);

    TextStyle unSelectedTextColor = TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.bold,
        color: Theme
            .of(context)
            .primaryColor);

    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 10,bottom: 0),
              child: Text(
                "Gender:",
                style: heading_style.copyWith(
                    color: Colors.black38,
                    fontSize: SizeConfig.blockSizeVertical * 2.3
                ),
              ),
            )
        ),
        Container(
          width: SizeConfig.blockSizeVertical * 100,
          height: SizeConfig.blockSizeHorizontal * 23,
          child: ListView(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isBtnSelected = 0;
                  });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) =>
//
//                ),
//              );
                },
                child: Container(
                    margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                    width: SizeConfig.blockSizeHorizontal * 20,
                    height: SizeConfig.blockSizeHorizontal * 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isBtnSelected == 0
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: isBtnSelected == 0
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.male,
                          color: isBtnSelected == 0
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          size: SizeConfig.blockSizeHorizontal * 7,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Flexible(
                          child: Text(
                            "Male",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: isBtnSelected == 0
                                ? selectedTextColor
                                : unSelectedTextColor,
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isBtnSelected = 1;
                  });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) =>
//
//                ),
//              );
                },
                child: Container(
                    margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                    width: SizeConfig.blockSizeHorizontal * 20,
                    height: SizeConfig.blockSizeHorizontal * 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isBtnSelected == 1
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: isBtnSelected == 1
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.female,
                          color: isBtnSelected == 1
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          size: SizeConfig.blockSizeHorizontal * 7,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Flexible(
                          child: Text(
                            "Female",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: isBtnSelected == 1
                                ? selectedTextColor
                                : unSelectedTextColor,
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isBtnSelected = 2;
                  });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) =>
//
//                ),
//              );
                },
                child: Container(
                    margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                    width: SizeConfig.blockSizeHorizontal * 20,
                    height: SizeConfig.blockSizeHorizontal * 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isBtnSelected == 2
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: isBtnSelected == 2
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.transgender,
                          color: isBtnSelected == 2
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          size: SizeConfig.blockSizeHorizontal * 7,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Flexible(
                          child: Text(
                            "Others",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: isBtnSelected == 2
                                ? selectedTextColor
                                : unSelectedTextColor,
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isBtnSelected = 3;
                  });
//              Navigator.of(context).push(
//                // With MaterialPageRoute, you can pass data between pages,
//                // but if you have a more complex app, you will quickly get lost.
//                MaterialPageRoute(
//                  builder: (context) =>
//
//                ),
//              );
                },
                child: Container(
                    margin:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                    width: SizeConfig.blockSizeHorizontal * 33,
                    height: SizeConfig.blockSizeHorizontal * 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isBtnSelected == 3
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: isBtnSelected == 3
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.userSecret,
                          color: isBtnSelected == 3
                              ? Colors.white
                              : Theme
                              .of(context)
                              .primaryColor,
                          size: SizeConfig.blockSizeHorizontal * 7,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Flexible(
                          child: Text(
                            "Prefer not to disclose",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: isBtnSelected == 3
                                ? selectedTextColor
                                : unSelectedTextColor,
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  void validation() async{

    if (_formKey.currentState.validate()) {
      print("validation success");

      if(dateText == "Choose Your BirthDate") dateText = "";
      String dis = _selecteddisabilityList.length > 0 ?_selecteddisabilityList[0] : "";

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      try{



        if(_profieCase == "1"){

//          Map<String,dynamic> regData = Provider.of<AuthProvider>(context, listen: false).getInsertedRecInfoForReg;

          await Provider.of<AuthProvider>(context,listen: false).setRegRecInfo(
              password: passController.text.toString().trim(),
              phone: phoneController.text.toString().trim(),
              address: addressController.text.toString().trim(),
              email: emailController.text.toString().trim(),
              name: nameController.text.toString().trim(),
              disability_id: dis,
              categories_id: ""
//              caregoryId[_categoryName].toString().trim()
              ,
              institution_name: InstituationNameController.text.toString(),
              age:dateText.toString(),
              gender: gender[isBtnSelected].toString(),
              occupation_name: occupationController.text.toString(),
              nid: ""
          );

          await Provider.of<AuthProvider>(context, listen: false).recruiterRegister();

          setState(() {
            _isLoading = false;
          });

          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: Text(msg[SUCCESS_TITLE]),
              content: Wrap(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 50.0,
                            child: Image.asset(
                              SUCCESS,
                              fit: BoxFit.contain,
                            )),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(msg[SUCCESS_REG_MSG],
                          textAlign: TextAlign.center,),
                      )
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      ModalRoute.withName(UserChooseScreen.tag),
                    );
                  },
                )
              ],
            ),
          );

        }else{
          await Provider.of<AuthProvider>(context,listen: false).updateRecProfile(
              name: nameController.text.toString().trim(),
              address: addressController.text.toString().trim(),
              disability_id: dis,
              age:  dateText.toString().trim(),
              gender: gender[isBtnSelected].toString(),
              instituation_name: InstituationNameController.text.toString().trim(),
              occupation_name: occupationController.text.toString().trim()
          );
          setState(() {
            _isLoading = false;
          });

          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: Text(msg[SUCCESS_TITLE]),
              content: Wrap(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 50.0,
                            child: Image.asset(
                              SUCCESS,
                              fit: BoxFit.contain,
                            )),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Profile Updated Successfully",
                          textAlign: TextAlign.center,),
                      )
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
          Navigator.of(context).pop();
        }

      }catch(e){
        setState(() {
          _isLoading = false;
        });
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(msg[ERR_TITLE]),
            content: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 50.0,
                          child: Image.asset(
                            ERROR,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(e.toString(),
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }


    }else{
      print("validation falied");
      setState(() {
        _isLoading = false;
      });

      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(msg[ERR_TITLE]),
          content: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 50.0,
                        child: Image.asset(
                          ERROR,
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(msg[CRED_FILL],
                      textAlign: TextAlign.center,),
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }
//  DateTime.now().year
  DateTime selectedDate = DateTime.now();
  int yearNow = DateTime.now().year - 15;
  String dateText = "Choose Your BirthDate";
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(yearNow),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(yearNow, 12));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateText =  "${selectedDate.toLocal()}".split(' ')[0].toString();
        print("selectedDate : $selectedDate ");
        print("dateText : $dateText ");
        print("current year ${yearNow}");
      });
  }
}
