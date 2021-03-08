import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdv/database/db_helper.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:crowdv/string.dart';
import 'package:crowdv/widgets/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../text_style.dart';

class ChatScreen extends StatefulWidget {
  static final String tag  ="/ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String title_text = "Chat Screen";
  String btn_text = "Register";


  Map<String,dynamic> opportunityData= {};

  var chatController = TextEditingController();
  var isBtnSelected = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    if(_isInit){
//      routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;
//      print(routeData['title']+" - "+routeData['btn_text']);
//      setState(() {
//        title_text = routeData['title'];
//        btn_text = routeData['btn_text'];
//        _profieCase = routeData['is_signup'];
//      });
//      _isInit = false;
//    }
  }

  @override
  Widget build(BuildContext context) {

    opportunityData = Provider.of<AuthProvider>(context).getSelectedOpportunityData;

    print("booking data ${opportunityData.toString()}");

    //chat++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final chatField = TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: chatController,
      maxLines: 3,
      decoration: InputDecoration(
//        fillColor: Colors.white,
        hintText: 'Enter message',
        hintStyle: TextStyle( color: Colors.white),
//        icon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//        border: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(5.0),
//          borderSide: BorderSide(
//            color: Colors.white,
//            width: 2.0,
//          ),
//        ),
//        hoverColor: Colors.white,
//        focusColor: Colors.white,
      ),
    );



    return Scaffold(
      body:
      //in stack widgets are placed on top of each other================================================================
      Stack(children: [
        //main-body-scrollable list++++++++++++++++++++++++++++++++++++++++++++
        SingleChildScrollView(
            child:
            Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.blockSizeVertical * 12,),
                Container(
                  height: SizeConfig.blockSizeVertical * 75,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("${opportunityData["rec_id"].toString()}_${opportunityData["id"].toString()}_${opportunityData["vol_id"].toString()}")
                        .orderBy("timestamp").snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(child: CircularProgressIndicator())
                          :
                      snapshot.data.documents.length == 0 ?
                      NoData(text: "No Chat Data"):
                      ListView.builder(
//                      physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.documents[index];
                          return Align(
                              alignment:
                              data["user_role"] == Provider.of<AuthProvider>(context).getUserRoleID.toString() ?
                              Alignment.centerRight:
                              Alignment.centerLeft,
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color:
                                      data["user_role"] == Provider.of<AuthProvider>(context).getUserRoleID.toString() ?
                                      Colors.lightBlueAccent :
                                      Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "${data["msg"]}",
                                      style: TextStyle(
                                          fontSize: SizeConfig.blockSizeVertical * 1.83,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),
                                    ),
                                    margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.2),
                                  ),

                                ],
                              )
                          );
                        },
                      );
                    },
                  ),

                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 13,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: chatField,
                      ),
                      InkWell(
                        onTap:validation,
                        child: Icon(Icons.send, color: Colors.white,size: 30,),
                      )
                    ],
                  ),
                ),
              ],

            )
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
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        title_text,
//                        style: heading_style.copyWith(
//                          fontSize: SizeConfig.blockSizeVertical * 2,
//                        ),
//                      ),
//                    ],
//                  )
                ],
              ),
            )),
      ]),
    );
  }


  void validation() async{
    print("validation success");
    if(chatController.text.toString().trim().isNotEmpty){
      try{
        uploadingData(
            msg: chatController.text.toString().trim(),
            isSeen: "0",
            userRole: Provider.of<AuthProvider>(context,listen: false).getUserRoleID.toString(),
            chatName: "${opportunityData["rec_id"].toString()}_${opportunityData["id"].toString()}_${opportunityData["vol_id"].toString()}");

        //getting token
        String token = "";
        String senderName = "";
        String messageBody = chatController.text.toString().trim();
        String userId = "";

        chatController.clear();

        if(Provider.of<AuthProvider>(context,listen: false).getUserRoleID == REQRUITER_ROLE_ID){
          userId =  "vol_" + opportunityData["vol_id"].toString();
          senderName = "Recruiter";
        }else{
          userId =  "rec_" + opportunityData["rec_id"].toString();
          senderName = "Volunteer";
        }

        print("notification data - userId: $userId - senderName: $senderName - messageBody - $messageBody ");

        var document =  Firestore.instance.collection('users').document(userId);
        await document.get().then((doc) {
          print("doc printing: ");
          print(doc.data.toString());
          token = doc.data["token"];
          print("token : $token");
        });

        //sending notification.
        Provider.of<AuthProvider>(context,listen: false).callOnFcmApiSendPushNotifications(
            userToken: [token],
            title: "New message from $senderName",
            body: messageBody
        );

      }catch(e){
        print("chatUi error "+e.toString());
      }
    }
  }
}






















