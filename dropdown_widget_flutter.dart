DropdownButton<String>(
                value: _gender,
                icon: Icon(Icons.arrow_drop_down),
                hint: Text(SELECT_GENDER_TEXT),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Colors.deepPurple
                ),
//                underline: Container(
//                  height: 1,
//                  color: Theme.of(context).primaryColor,
//                ),
                onChanged: (String newValue) {
                  setState(() {
                    _gender = newValue;
                  });
                },
                items: <String>[SELECT_GENDER_TEXT, 'Male', 'Female', 'Others']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
              ),

=============================================================================================
Gender drop down from Call4tours
=============================================================================================

        for(var i = 0; i < _locationIdData.length; i++){
          _locationIdMap[_locationIdData[i]['name']] = _locationIdData[i]['id'].toString();
        }

              //gender, +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text('Gender', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).primaryColor)
                ),
                child: DropdownButton<String>(
                  value: _gender,
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Text(SELECT_GENDER_TEXT),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: Colors.deepPurple
                  ),
//                underline: Container(
//                  height: 1,
//                  color: Theme.of(context).primaryColor,
//                ),
                  onChanged: (String newValue) {
                    setState(() {
                      _gender = newValue;
                    });
                  },
                  items: <String>[SELECT_GENDER_TEXT, 'Male', 'Female', 'Others']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              ),