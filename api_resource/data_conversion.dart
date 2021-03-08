=============================================================================================
ClipRRect : can be used to broder any widget....
=============================================================================================
|I was able to solve using 'keys'   |
|                                   |
|for a json example like this:      |  
|-----------------------------------|

{
"1-0001": {
  "name": "red",
  "hex": "FF0000"
 },
"1-0002": {
  "name": "blue",
  "hex": "0000FF"
 },
"1-0003": {
  "name": "green",
  "hex": "008000"
 }
}
I was able to use

Map<String, dynamic> decoded = json.decode(jsonString);
for (var colour in decoded.keys) {
  print(colour);                   // prints 1-0001
  print(decoded[colour]['name']);  // prints red
  print(decoded[colour]['hex']);   // prints FF0000
}