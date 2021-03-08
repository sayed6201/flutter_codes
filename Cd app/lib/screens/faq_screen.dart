
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/screens/vol_profile_view.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../text_style.dart';

class FAQScreen extends StatefulWidget {
  static final String tag = "FAQScreen";
  FAQScreen();
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  var _isInit = true;
  var _isLoading = true;
  var header_text = "FAQ";
  List<dynamic> faqList = [];
  Map<String,dynamic> catagoryInfo = {};

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      if(mounted){
        print("isloading $_isLoading");
        await Provider.of<AuthProvider>(context,listen: false).fetchFAQ();
        _isInit = false;
        setState(() {
          _isLoading = false;
          print("isloading $_isLoading");
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    faqList = Provider.of<AuthProvider>(context).getFaqList;

//    setState(() {
//      header_text = "${faqList.length ?? ""} Volunteers found";
//    });
    print("faqList-length-ui:  ${faqList.length}");

    return Scaffold(
      body: Stack(children: [
        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        Positioned(
            top: SizeConfig.blockSizeVertical * 10,
            left: 5,
            right: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5, bottom: SizeConfig.blockSizeVertical * 5),
                    height: SizeConfig.blockSizeVertical * 85,
                    child:
                    _isLoading ?
                    Center(
                      child: CircularProgressIndicator(),)
                        :
                    (
                        faqList.length == 0 ?
                        NoData(text: "No Data Found...",)
                            :
                        ListView.builder(
                          padding: EdgeInsets.only(
                            top:SizeConfig.blockSizeVertical * 1,
                            left: SizeConfig.blockSizeHorizontal * 3,
                            right: SizeConfig.blockSizeHorizontal * 3,
                            bottom: SizeConfig.blockSizeHorizontal * 15,
                          ),
                          itemBuilder: (ctx,index){
                            return InkWell(
                              onTap: () async{
//                              if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID != REQRUITER_ROLE_ID)
//                              Navigator.of(context).pushNamed(ReqruiterProfileScreen.tag);
                              },
                              child: Container(
                                padding: EdgeInsets.all(0),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1,
                                    right: SizeConfig.blockSizeHorizontal * 1,
                                    top: SizeConfig.blockSizeVertical * 1,
                                    bottom: SizeConfig.blockSizeVertical * 1),
                                child: Card(
                                    elevation: 5,
                                    child: Container(
                                        padding: EdgeInsets.all(0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 50,
                                              width: 5,
                                              color: primaryColor,
                                            ),
//                                            Container(
//                                              margin: EdgeInsets.symmetric(
//                                                vertical: 10,
//                                                horizontal: 15,
//                                              ),
//                                              decoration: BoxDecoration(
//                                                border: Border.all(
//                                                  color: Colors.purple,
//                                                  width: 2,
//                                                ),
//                                              ),
//                                              padding: EdgeInsets.all(10),
//                                              child: Icon(FontAwesomeIcons.infoCircle, color: primaryColor,),
//                                            ),
                                            Expanded(
                                              child: Column(
                                                  children : <Widget>[ Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 10,right: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child:
                                                                      Padding(
                                                                      padding: EdgeInsets.all(10),
                                                                                child:
                                                                                Text(
                                                                                  faqList[index]["subject"]??"Sayed",
                                                                                  style: TextStyle(
                                                                                      fontSize: SizeConfig.blockSizeVertical * 2,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      color: Colors.black38
                                                                                  ),
                                                                                ) ),
                                                                  ),
//                                                                  Container(
//                                                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                    decoration: BoxDecoration(
//                                                                      color:Colors.blue,
//                                                                      border: Border.all(color: Colors.blue),
//                                                                      borderRadius: BorderRadius.circular(100),
//                                                                    ),
//                                                                    child: Icon(Icons.info),)
                                                                ],
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Divider(color: Colors.black38,),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Padding(
                                                                          padding: EdgeInsets.all(10),
                                                                          child: Text(faqList[index]["details"],
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: SizeConfig.blockSizeVertical * 1.9,
                                                                              )),
                                                                        ),
                                                                        SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                                        Text("DOB: "+faqList[index]["age"],
//                                                                            textAlign: TextAlign.left,
//                                                                            style: TextStyle(
//                                                                              color: Colors.black38,
//                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                            )),
//                                                                        SizedBox(height: SizeConfig.blockSizeVertical * 1,),
//                                                                        Text("Institute: "+faqList[index]["instituation_name"],
//                                                                            textAlign: TextAlign.left,
//                                                                            style: TextStyle(
//                                                                              color: Colors.black38,
//                                                                              fontSize: SizeConfig.blockSizeVertical * 1.5,
//                                                                            )),
                                                                      ],
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    ),
                                                                  ),
//                                                                  Container(
//                                                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                    decoration: BoxDecoration(
//                                                                      color:Colors.white,
//                                                                      border: Border.all(color: Colors.white),
//                                                                      borderRadius: BorderRadius.circular(100),
//                                                                    ),
//                                                                    child:
//                                                                    Column(
//                                                                      children: <Widget>[
//                                                                        SizedBox(height: SizeConfig.blockSizeVertical * 0.5,),
//                                                                        if(faqList[index]["status"] == "Active")
//                                                                          Container(
//                                                                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                            decoration: BoxDecoration(
//                                                                              color:Colors.grey,
//                                                                              border: Border.all(color: Colors.grey),
//                                                                              borderRadius: BorderRadius.circular(100),
//                                                                            ),
//                                                                            child: Text(
//                                                                              "Silver Badge",
//                                                                              style: TextStyle(
//                                                                                  fontSize: SizeConfig.blockSizeVertical * 2,
//                                                                                  fontWeight: FontWeight.w500,
//                                                                                  color: Colors.white
//                                                                              ),
//                                                                            ),),
//                                                                        if(faqList[index]["status"] == "Gold")
//                                                                          Container(
//                                                                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                            decoration: BoxDecoration(
//                                                                              color:Colors.orangeAccent,
//                                                                              border: Border.all(color: Colors.orangeAccent),
//                                                                              borderRadius: BorderRadius.circular(100),
//                                                                            ),
//                                                                            child: Text(
//                                                                              "Gold Badge",
//                                                                              style: TextStyle(
//                                                                                  fontSize: SizeConfig.blockSizeVertical * 2,
//                                                                                  fontWeight: FontWeight.w500,
//                                                                                  color: Colors.white
//                                                                              ),
//                                                                            ),),
//                                                                        if(faqList[index]["status"] == "Platinum")
//                                                                          Container(
//                                                                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                                                            decoration: BoxDecoration(
//                                                                              color:Colors.blue,
//                                                                              border: Border.all(color: Colors.blue),
//                                                                              borderRadius: BorderRadius.circular(100),
//                                                                            ),
//                                                                            child: Text(
//                                                                              "Platinum Badge",
//                                                                              style: TextStyle(
//                                                                                  fontSize: SizeConfig.blockSizeVertical * 2,
//                                                                                  fontWeight: FontWeight.w500,
//                                                                                  color: Colors.white
//                                                                              ),
//                                                                            ),),
//                                                                        SizedBox(height: SizeConfig.blockSizeVertical * 0.5,),
//                                                                      ],
//                                                                    )
////                                                      Text(
////                                                        "ID: ${volInfo["id"]}",
////                                                        style: TextStyle(
////                                                            fontSize: SizeConfig.blockSizeVertical * 2,
////                                                            fontWeight: FontWeight.w500,
////                                                            color: Colors.white
////                                                        ),
////                                                      )
//                                                                    ,),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ]
                                              ),
                                            )
                                          ],
                                        )
                                    )),
                              ),
                            );
                          },
                          itemCount: faqList.length,
                        )
                    )
                ),
              ],
            )),

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
                          "FAQ",
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
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        header_text,
//                        style: heading_style.copyWith(
//                          fontSize: SizeConfig.blockSizeVertical * 2,
//                        ),
//                      ),
//
//                    ],
//                  )
                ],
              ),
            )),
      ]),
    );
  }
}
