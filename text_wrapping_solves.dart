 

 /*
===========================================================================================
Give a fixed size
===========================================================================================
*/
SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),
                                  softWrap: true,
                                ),
                              )



 /*
===========================================================================================
ENUM
----
used to convert text into number...
===========================================================================================
*/

 Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 250,
                              child: Wrap(
                                children: <Widget>[
                                  Text(
                                    'eVisa - 15 days Single Entry eVisa - 15 days Single Entry eVisa - 15 days Single Entry',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                ),
                                Text(
                                  'Turkey',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
 /*
===========================================================================================
Text overflow handling
===========================================================================================
*/

                        Flexible(
                                        child: Text(
                                          item["address"] == null
                                              ? ''
                                              : item["address"],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

 /*
===========================================================================================
Text Alignment-------
===========================================================================================
*/

Align(
  alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
  child: Text("My Text"),
),


/*
===========================================================================================
Text Alignment-------
===========================================================================================
*/
Container(
                              width: MediaQuery.of(context).size.width/2 - 50,
                                child: Wrap(
                                  children: <Widget>[
                                    Text(
                                      '${_topTours['address']}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )),