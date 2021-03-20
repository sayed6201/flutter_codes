/*
===========================================================================================
ListView ()
===========================================================================================
*/
Wrap(
              children: <Widget>[
                ListView(
                
                  physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 250.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(17.0),
                          color: Color(0xFF7A9BEE)),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Adult: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (adultNum <= adultMin || adultNum >= adultMax ) return;
                                adultNum--;
                              });
                            },
                            child: Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(7.0),
                                  color: Colors.white),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Color(0xFF7A9BEE),
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Text('$adultNum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                adultNum++;
                              });
                            },
                            child: Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(7.0),
                                  color: Colors.white),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF7A9BEE),
                                  size: 20.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    
                  ],
                )
              ],
            ),
            Padding( padding: const EdgeInsets.all(10.0), ),