await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Could not fetch data!'),
          content: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 50.0,
                      child: Image.asset(
                        SAD,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 20,),
                  Text(e.toString(), textAlign: TextAlign.center,)
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