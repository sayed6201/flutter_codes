=============================================================================================
Collection: List, Maps, Set, Queue
-----------------------------------
   * List: an ordered collection of objects with a length (also called an array)
   * Set: an unordered collection of unique objects
   * Map: an unordered collection of key-value pairs
   * Queue: an ordered collection that can add/remove objects on both ends
   * SplayTreeMap: an ordered collection of key-value pairs based on a self-balancing binary tree
=============================================================================================

-------------------------------------------------------------
Iterating Collection
-------------------------------------------------------------
import 'dart:collection'; 
void main() { 
   Queue numQ = new Queue(); 
   numQ.addAll([100,200,300]);  
   Iterator i= numQ.iterator; 
   
   while(i.moveNext()) { 
      print(i.current); 
   } 
}


-------------------------------------------------------------
List
-------------------------------------------------------------
void main() { 
   List logTypes = new List(); 
   logTypes.add("WARNING"); 
   logTypes.add("ERROR"); 
   logTypes.add("INFO");  
   
   // iterating across list 
   for(String type in logTypes){ 
      print(type); 
   } 
   
   // printing size of the list 
   print(logTypes.length); 
   logTypes.remove("WARNING"); 
   
   print("size after removing."); 
   print(logTypes.length); 
}


-------------------------------------------------------------
Set
-------------------------------------------------------------
void main() { 
   Set numberSet = new  Set(); 
   numberSet.add(100); 
   numberSet.add(20); 
   numberSet.add(5); 
   numberSet.add(60); 
   numberSet.add(70);
   print("Default implementation :${numberSet.runtimeType}");  
   
   // all elements are retrieved in the order in which they are inserted 
   for(var no in numberSet) { 
      print(no); 
   } 
}    


-------------------------------------------------------------
Maps
-------------------------------------------------------------
void main() { 
  var details = new Map(); 
  details['Usrname']='admin'; 
  details['Password']='admin@123'; 
  print(details); 
}   


-------------------------------------------------------------
Queue
-------------------------------------------------------------
import 'dart:collection'; 
void main() { 
   Queue queue = new Queue(); 
   print("Default implementation ${queue.runtimeType}"); 
   queue.add(10); 
   queue.add(20); 
   queue.add(30); 
   queue.add(40); 
   
   for(var no in queue){ 
      print(no); 
   } 
}     