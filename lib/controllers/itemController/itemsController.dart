
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/itemsProvider.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';

class Itemscontroller {
  Item item = Item(id: '', name: '', description: '', category: '', saleprice: 0.0, quantity: 0.0,image: '', suppliers: []);
    final Ref ref;
    List<Item> items=[];
  Itemscontroller(this.ref);
 

  void updateItemname(String name) {
    item.name=name;
  }
   void updateItemdesc(String desc) {
    item.description=desc;
  }
   void updatecat(String category) {
    item.category=category;
  }
   void updateSaleprice(double sprice) {
    item.saleprice=sprice;
  }
 
   void updateQty(double qty) {
    item.quantity=qty;
  }
   void updateSuppliers(List<String> sup) {
    item.suppliers.addAll(sup);
  }

  Future<String> uploadImage(File imageFile) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");
  TaskSnapshot snapshot = await ref.putFile(imageFile);
  if (FirebaseAuth.instance.currentUser != null) {
  print("User is authenticated");
  try {
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print("Download URL: $downloadUrl");
  } catch (e) {
    print("Error getting download URL: $e");
  }
} else {
  print("User is not authenticated");
}
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl; 
}
   Future updateImage(File? image) async{
    String s =await uploadImage(image!) ;
    print('IMAGE $s');
    item.image=s;
  }
   void updateItem(Item i) {
    item=i;
  }
   void updateId() {
      final itemsAsyncValue = ref.watch(itemsListProvider);
    Item val = itemsAsyncValue.maybeWhen(
  data: (itms) => itms.isNotEmpty
  ?itms.last
  :Item(
    id: 'item0',
    name: '',
    description: '',
    category: '',
    saleprice: 0.0,
    quantity: 0.0,
    image: '',
    suppliers: []),
     orElse :()=> Item(
    id: 'sup0',
    name: '',
    description: '',
    category: '',
    saleprice: 0.0,
    quantity: 0.0,
    image: '',
    suppliers: []) 
  
);
  String s = val.id.replaceAll(RegExp(r'[^0-9]'), '');
  int n = int.parse(s);
    item.id='item${n+1}';
  }



    bool isSelectedIt(Item i){
      return items.contains(i);
  }
  


  void selecteditems(bool selected,Item i){
    if(selected){
      items.add(i);
    }
    else{
      items.remove(i);
    }
  }

  void clearItems(){
    items.clear();
  }

    Future<void> newItem()async{
    ref.read(itemsDatabaseProvider).additem(item);
  }

  Future<void> deleteItems()async{
     for (Item itm in items) {
           ref.read(itemsDatabaseProvider).removeitem(itm);
       } 
    print('deleted');
  }

  Future<void> updateItems()async{
    ref.read(itemsDatabaseProvider).updateitem(item);
  }

}

  final itemsControllerProvider = Provider((ref) {
  return Itemscontroller(ref);
});