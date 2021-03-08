                                        Text(
                                            (() {
                                              if (snapShot.data[index]['des']
                                                      .length >
                                                  20) {
                                                return snapShot.data[index]
                                                            ['des']
                                                        .toString()
                                                        .substring(0, 20) +
                                                    "...";
                                              } else {
                                                return snapShot.data[index]
                                                        ['des']
                                                    .toString();
                                              }
                                            }()),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            )),

=============================================================================================
Use an immediate anonymous function
=============================================================================================

class StatmentExample extends StatelessWidget {
  Widget build(BuildContext context) {
    return Text((() {
      if(true){
        return "tis true";}

      return "anything but true";
    })());
  }
}

=============================================================================================
ie wrap your statements in a function
=============================================================================================


(() {
  // your code here
}())
I would heavily recommend against putting too much logic directly with your UI 'markup' but I found that type inference in Dart needs a little bit of work so it can be sometimes useful in scenarios like that.

=============================================================================================
Use the ternary operator
=============================================================================================


condition? Text("True"): null,
Use If or For statements or spread operators in collections
children: [
  ...manyItems,
  oneItem,
  if(canIKickIt)
    ...kickTheCan
  for (item in items)
    Text(item)

=============================================================================================
Use a method
=============================================================================================
child: getWidget()

Widget getWidget() {
  if (x > 5) ...
  //more logic here and return a Widget

=============================================================================================
Redefine switch statement
=============================================================================================

As another alternative to the ternary operator, you could create a function version of the switch statement such as in the following post https://stackoverflow.com/a/57390589/1058292.

  child: case2(myInput,
  {
    1: Text("Its one"),
    2: Text("Its two"),
  }, Text("Default"));