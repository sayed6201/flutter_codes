import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadingData( {String chatName, String msg, String userRole, String isSeen}) async {
  print("chatname $chatName");
  try{
    await Firestore.instance.collection(chatName).add({
      'msg': msg,
      'user_role': userRole,
      'is_seen' : isSeen,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });

    print("timestamp ${DateTime.now().millisecondsSinceEpoch}");
  }catch(e){
    print("erroe"+e.toString());
  }
  print("done");
}



//Future<void> editProduct(bool _isFavourite,String id) async {
//  await Firestore.instance
//      .collection("products")
//      .document(id)
//      .updateData({"isFavourite": !_isFavourite});
//}

//Future<void> deleteProduct(DocumentSnapshot doc) async {
//  await Firestore.instance
//      .collection("products")
//      .document(doc.documentID)
//      .delete();
//}