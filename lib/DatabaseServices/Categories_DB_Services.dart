
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';

class CategoryDatabaseService {
   FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
   
  // data feed method
 Stream<List<Category>> getCategoriesStream(String userId) {
  return FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('categories')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Category.fromDocument(doc))
          .toList());
}


  Future<List<Category>> getItems(String userId) async {
    // categorylist
    final querySnapshot = await db.collection('Users').doc(userId).collection('categories').get();
    return querySnapshot.docs.map((doc) => Category.fromDocument(doc)).toList();
  }
  

  Future<void> addItem(String userId,Category newCat) async {
    // Add category to DB
    await db.collection('Users').doc(userId).collection('categories').doc(newCat.catId).set(newCat.toMap());
    print('cat add : ${newCat.categoryname}');
  }

   Future<void> updateItem(String userId,Category cat) async {
    // Update category to DB
     print('try cat add : ${cat.categoryname}');
    await db.collection('Users').doc(userId).collection('categories').doc(cat.catId).update(cat.toMap());
    print('cat updated : ${cat.categoryname}');
  }

  Future<void> removeItem(String userId,Category cat) async {
    // delete category to DB
    await db.collection('Users').doc(userId).collection('categories').doc(cat.catId).delete();
    print('delete : ${cat.categoryname}');
  }
}