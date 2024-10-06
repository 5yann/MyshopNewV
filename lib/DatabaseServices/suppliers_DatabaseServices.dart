import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';

class SuppliersDatabaseservices {
   FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

      // data feed method
 Stream<List<Supplier>> getSuppliersStream() {
  return FirebaseFirestore.instance
      .collection('Users')
      .doc(user!.uid)
      .collection('suppliers')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Supplier.fromDocument(doc))
          .toList());
}

  Future<List<Supplier>> getSuppliers() async {
    // itemlist
    final querySnapshot = await db.collection('Users').doc(user!.uid).collection('suppliers').get();
    return querySnapshot.docs.map((doc) => Supplier.fromDocument(doc)).toList();
  }

   Future<Supplier?> getSupById(String supId) async {
  try {
    // Récupérer le document avec un ID spécifique
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('suppliers')
        .doc(supId) // Utiliser l'ID pour accéder directement au document
        .get();

    // Vérifier si le document existe
    if (documentSnapshot.exists) {
      // Transformer le document en objet Item
      return Supplier.fromDocument(documentSnapshot);
    } else {
      print('Aucun sup trouvé avec cet ID.');
      return null;
    }
  } catch (e) {
    print('Erreur lors de la récupération de l\'item: $e');
    return null;
  }
} 

  Future<void> addSupplier(Supplier newItem) async {
    // Add supplier to DB
    await db.collection('Users').doc(user!.uid).collection('suppliers').doc(newItem.id).set(newItem.toMap());
    print('item add : ${newItem.name}');
  }

   Future<void> updateSupllier(Supplier item) async {
    // Update supplier to DB
     print('try supplier add : ${item.name}');
    await db.collection('Users').doc(user!.uid).collection('suppliers').doc(item.id).update(item.toMap());
    print('supplier updated : ${item.name}');
  }

  Future<void> removeSupplier(Supplier item) async {
    // delete supplier to DB
    print('delete : ${item.id}');
    await db.collection('Users').doc(user!.uid).collection('suppliers').doc(item.id).delete();
    print('delete : ${item.name}');
  }
}