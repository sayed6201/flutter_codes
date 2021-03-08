

/*
===========================================================================================
Navigatioin Result, Home Page
===========================================================================================
*/

  void onPickImageSelected(String source) async {
    var imageSource;
    if (source == CAMERA_SOURCE) {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final scaffold = _scaffoldKey.currentState;

    try {
      final file =
      await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }


      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => DetailWidget(file, _selectedScanner)),
      );

    } catch(e) {
      scaffold.showSnackBar(SnackBar(content: Text(e.toString()),));
    }
  }