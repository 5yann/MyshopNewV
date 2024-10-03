import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';

class Itemsdatabaseservices {
   FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

      // data feed method
 Stream<List<Item>> getItemsStream() {
  return FirebaseFirestore.instance
      .collection('Users')
      .doc(user!.uid)
      .collection('items')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Item.fromDocument(doc))
          .toList());
}

  Future<List<Category>> getitems() async {
    // itemlist
    final querySnapshot = await db.collection('Users').doc(user!.uid).collection('items').get();
    return querySnapshot.docs.map((doc) => Category.fromDocument(doc)).toList();
  }
  

  Future<void> additem(Item newItem) async {
    // Add item to DB
    await db.collection('Users').doc(user!.uid).collection('items').doc(newItem.id).set(newItem.toMap());
    print('item add : ${newItem.name}');
  }

   Future<void> updateitem(Item item) async {
    // Update item to DB
     print('try item add : ${item.name}');
    await db.collection('Users').doc(user!.uid).collection('items').doc(item.id).update(item.toMap());
    print('item updated : ${item.name}');
  }

  Future<void> removeitem(Item item) async {
    // delete item to DB
    await db.collection('Users').doc(user!.uid).collection('items').doc(item.id).delete();
    print('delete : ${item.name}');
  }
}