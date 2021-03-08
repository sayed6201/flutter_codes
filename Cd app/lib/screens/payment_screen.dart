import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/size_config/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../color_file.dart';
import '../string.dart';
import '../text_style.dart';

class PaymentScreen extends StatefulWidget {
  static const String tag = "/PaymentScreen";
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String title_text = "Payment Confirmation";
  String btn_text = "Submit";

  Map<String,String> routeData= {};
  Map<String,dynamic> bookingHistoryIds = {};

  var traxIdController = TextEditingController();
  var amountController = TextEditingController();

  var _isLoading = false;
  var isBtnSelected = 0;
  var _isInit = true;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isInit){
//      routeData = ModalRoute.of(context).settings.arguments as Map<String, String>;
//      print(routeData['title']+" - "+routeData['btn_text']);
//      setState(() {
//        title_text = routeData['title'];
//        btn_text = routeData['btn_text'];
//        _profieCase = routeData['is_signup'];
//      });
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    bookingHistoryIds = Provider.of<AuthProvider>(context).getSelectedBokingDataId;
    print("bokoing data ids : ${bookingHistoryIds.toString()}");

    //transection id ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final transectionId = TextFormField(
      keyboardType: TextInputType.text,
      controller: traxIdController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Enter transection ID',
        icon: Icon(Icons.phone_android),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      validator: (val){
        if(val.isEmpty) return "Must be filled";
        return null;
      },
      autovalidate: true,
    );

    //amount ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final amount = TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      controller: amountController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Enter paid amount',
        icon: Icon(Icons.monetization_on),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      validator: (val){
        if(val.isEmpty) return "Please add suggestion";
        return null;
      },
      autovalidate: true,
    );


    //Button+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    final button = Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 0),
        child: RaisedButton(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: validation,
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
          SizedBox(height: SizeConfig.blockSizeVertical * 4.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Your booking is pending, Please first Make payment using Bkash and then enter enter following information,\n after validation your booking will be activated",
              textAlign: TextAlign.center,
              style: big_style.copyWith(fontSize: SizeConfig.blockSizeVertical * 1.7),
            ),
          ),
          Divider(),
          SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: transectionId,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: amount,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5),

          _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          )
              :button,
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
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15, bottom: SizeConfig.blockSizeVertical * 5),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5
              ),
              child: formUi,
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
                            "",
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                    Column(
                      children: <Widget>[
                        Text(
                          title_text,
                          style: heading_style.copyWith(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
//                    Container(
//                      margin: EdgeInsets.only(
//                          top: SizeConfig.blockSizeVertical * 0.5),
//                      child: Icon(
//                        FontAwesomeIcons.search,
//                        color: Colors.white70,
//                      ),
//                    ),
                      ],
                    )
                  ],
                ),
              )),
        ]));
  }

  void validation() async{

    if (_formKey.currentState.validate()) {
      print("validation success");

      setState(() {
        _isLoading = true;
      });

      print("validation started");

      try{

        await Provider.of<AuthProvider>(context, listen: false).paymentSubmit(
            amount: amountController.text.toString().trim(),
            tranxID: traxIdController.text.toString().trim());

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
                      child: Text(msg[SUCCESS_POST_PAYMENT],
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
      print("validation failed");

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
}
