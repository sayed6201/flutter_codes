
/*
===========================================================================================
Firestore-flutter
----------------------
CURD
===========================================================================================
*/


---------------------------------------------------------------------------------------
Fetching-Data - list
---------------------------------------------------------------------------------------
StreamBuilder(
    stream: Firestore.instance.collection("products").snapshots(),
    builder: (context, snapshot) {},
            );
builder: (context, snapshot) {
  return !snapshot.hasData
      ? Text('PLease Wait')
      : ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot products =
                snapshot.data.documents[index];
            return ProductItem(
              name: products['name'],
              imageUrl: products['imageURL'],
              price: products['price'],
              discription: products['description'],
            );
          },
        );
},



---------------------------------------------------------------------------------------
Fetching-Data - single doc
---------------------------------------------------------------------------------------
var document =  Firestore.instance.collection('users').document('3vol_3');
        document.get().then((doc) {
          print("doc printing: ");
        print(doc.data.toString());
        });

---------Or in more simpler way: -----------

var document = await Firestore.instance.document('COLLECTION_NAME/TESTID1');
document.get() => then((doc) {
    print(document.data.toString());
});

--------- If you want to get data in realtime, please use the following code: ------

Widget build(BuildContext context) {
  return new StreamBuilder(
      stream: Firestore.instance.collection('COLLECTION_NAME').document('TESTID1').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument["name"]);
      }
  );
}



/*
===========================================================================================
Firestore - OPeration Class
----------------------------
CURD
===========================================================================================
*/
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadingData(String _productName, String _productPrice,
    String _imageUrl, bool _isFavourite) async {
  await Firestore.instance.collection("products").add({
    'productName': _productName,
    'productPrice': _productPrice,
    'imageUrl': _imageUrl,
    'isFavourite': _isFavourite,
  });
}

Future<void> editProduct(bool _isFavourite,String id) async {
  await Firestore.instance
      .collection("products")
      .document(id)
      .updateData({"isFavourite": !_isFavourite});
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await Firestore.instance
      .collection("products")
      .document(doc.documentID)
      .delete();
}