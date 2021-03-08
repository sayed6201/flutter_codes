
=============================================================================================
Container:
height: full width
width: 
=============================================================================================
Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent
            )



=============================================================================================
Container wrap content
=============================================================================================
Wrap (
  childre : [ Container(...) ]
)

=============================================================================================
Container width problem fix, Align
=============================================================================================
Align(
child: Container(

=============================================================================================
Container: BoxDecoration : LinearGradient
Gradinrt color display
=============================================================================================
Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
      //display gradient color....
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );

  
=============================================================================================
Text: softWrap: overflow
=============================================================================================
  Container(
                    width: 300,
                    //setting container bg color transperent......
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      //making text wrap, fade if its too big
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
 
=============================================================================================
 Border
=============================================================================================
//round border +++++++++++++++++++++++++++++++++++++
Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );

//BoxDecoration +++++++++++++++++++++++++++++++++++++
    decoration: BoxDecoration(
                  border: Border.all(
                      color: isBtnSelected == 2
                          ? Colors.white
                          : Theme
                          .of(context)
                          .primaryColor,
                      width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: isBtnSelected == 2
                      ? Theme
                      .of(context)
                      .primaryColor
                      : Colors.white,
                ),

=============================================================================================
Box shadow
=============================================================================================
    Container(
      margin: EdgeInsets.only(top: 150, right: 20, left: 20),
      height: 600,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child: myCard(
        widgetColor: widgetColor,
      ),
    );


=============================================================================================
Container: curved top and left
=============================================================================================
    Positioned(
                        top: 75.0,
                        child: Container(
                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.only(
//                                  topLeft: Radius.circular(45.0),
//                                  topRight: Radius.circular(45.0),
//                                ),
                                color: Colors.white),
                            height: MediaQuery.of(context).size.height - 100.0,
                            width: MediaQuery.of(context).size.width)
                    ),