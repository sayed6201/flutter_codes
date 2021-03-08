=============================================================================================
Stepper form
=============================================================================================

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

//  @override
//  void dispose() {
//    _focusNode.dispose();
//    super.dispose();
//  }

  List<Step> steps = [

    //name:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    new Step(
        title: const Text('Name'),
        //subtitle: const Text('Enter your name'),
        isActive: true,
        //state: StepState.error,
        state: StepState.indexed,
        content: Column(
          children: <Widget>[
            new TextFormField(
              focusNode: _focusNode,
              keyboardType: TextInputType.text,
              autocorrect: false,
              onSaved: (String value) {
                data.name = value;
              },
              maxLines: 1,
              //initialValue: 'Aseem Wangoo',
              validator: (val) {
                if (val.isEmpty) {
                  return "must be filled";
                }
//            else if (val.length < 6) {
//              return "must be 6 chars long";
//            }
                else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter name',
                icon: Icon(Icons.person),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ],
        )
    ),

    //Phone:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    new Step(
        title: const Text('Contact'),
        //subtitle: const Text('Subtitle'),
        isActive: true,
        //state: StepState.editing,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.phone,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length < 10) {
              return 'Please enter valid number';
            } else {
              return null;
            }
          },
          onSaved: (String value) {
            data.phone = value;
          },
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Enter Phone number',
            icon: Icon(Icons.call),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        )),

    //Email:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    new Step(
        title: const Text('Email'),
        // subtitle: const Text('Subtitle'),
        isActive: true,
        state: StepState.indexed,
        // state: StepState.disabled,
        content: new TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter valid email';
              } else
                return null;
            },
            onSaved: (String value) {
              data.email = value;
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Enter Email',
              icon: Icon(Icons.email),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
        )),

    //Address:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    new Step(
        title: const Text('Address'),
        // subtitle: const Text('Subtitle'),
        isActive: true,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.text,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length > 2) {
              return 'Please enter valid age';
            } else
              return null;
          },
          maxLines: 1,
          onSaved: (String value) {
            data.age = value;
          },
            decoration: InputDecoration(
              hintText: 'Enter Address',
              icon: Icon(Icons.location_on),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
        )),


  ];

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        print("Name: ${data.name}");
        print("Phone: ${data.phone}");
        print("Email: ${data.email}");
        print("Age: ${data.age}");

        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("Details"),
              //content: new Text("Hello World"),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text("Name : " + data.name),
                    new Text("Phone : " + data.phone),
                    new Text("Email : " + data.email),
                    new Text("Age : " + data.age),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
    }

    return Container(
        child: new Form(
          key: _formKey,
          child: new ListView(children: <Widget>[
            new Stepper(
              steps: steps,
              type: StepperType.vertical,
              currentStep: this.currStep,
              onStepContinue: () {
                setState(() {
                  if (currStep < steps.length - 1) {
                    currStep = currStep + 1;
                  } else {
                    currStep = 0;
                  }
                  // else {
                  // Scaffold
                  //     .of(context)
                  //     .showSnackBar(new SnackBar(content: new Text('$currStep')));

                  // if (currStep == 1) {
                  //   print('First Step');
                  //   print('object' + FocusScope.of(context).toStringDeep());
                  // }

                  // }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (currStep > 0) {
                    currStep = currStep - 1;
                  } else {
                    currStep = 0;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  currStep = step;
                });
              },
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: RaisedButton(
                child: Text(
                  'Save',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: _submitDetails,
                color: Colors.blue,
              ),
            ),
          ]),
        ));
  }
}