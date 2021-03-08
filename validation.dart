=============================================================================================
Vlidation
=============================================================================================

void loginValidation() async{
    if(passwordController.text.toString().isEmpty || passwordController.text.toString().isEmpty){
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Opps!'),
          content: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 50.0,
                      child: Image.asset(
                        LOGO,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 20,),
                  Text("Please fill up all credintials",
                    textAlign: TextAlign.center,)
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
    }else{
      if(passwordController.text.toString().length < 6){
        final snackBar = SnackBar(
          content: Text(
              'Make sure your passowrd is at least 5 char long',
            style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.white,
            onPressed: () {
            },
          ),);
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }

      print("validation");
    }
  }