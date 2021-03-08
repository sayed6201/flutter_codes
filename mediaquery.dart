class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final String tag = 'MAINAPP';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
      builder: (BuildContext context, Widget child){
        var mediaquery = MediaQuery.of(context);
        var paddingBottom = 50.0;
        if(mediaquery.orientation == Orientation.landscape){
          paddingBottom = 0.0;
        }
          return Padding(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: child,
          );
      },
    );
  }
}