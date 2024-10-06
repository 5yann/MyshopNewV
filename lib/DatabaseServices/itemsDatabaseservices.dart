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

  Future<List<Item>> getitems() async {
    // itemlist
    final querySnapshot = await db.collection('Users').doc(user!.uid).collection('items').get();
    return querySnapshot.docs.map((doc) => Item.fromDocument(doc)).toList();
  }
  
 Future<Item?> getItemById(String itemId) async {
  try {
    // Récupérer le document avec un ID spécifique
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('items')
        .doc(itemId) // Utiliser l'ID pour accéder directement au document
        .get();

    // Vérifier si le document existe
    if (documentSnapshot.exists) {
      // Transformer le document en objet Item
      return Item.fromDocument(documentSnapshot);
    } else {
      print('Aucun item trouvé avec cet ID.');
      return null;
    }
  } catch (e) {
    print('Erreur lors de la récupération de l\'item: $e');
    return null;
  }
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