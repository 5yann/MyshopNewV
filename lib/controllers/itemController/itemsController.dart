
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/itemsProvider.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';

class Itemscontroller {
  Item item = Item(id: '', name: '', description: '', category: '', saleprice: 0.0, quantity: 0.0,image: '', suppliers: []);
    final Ref ref;
    List<Item> items=[];
    bool checksup=false;
     List<String> list=[];
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
   void updateSuppliers(String sup) {
    item.suppliers.add(sup);
    updateItems();
  }

      bool supcheck(Supplier sup){
      bool check=false;
      for (var value in item.suppliers) {
        List<String> list = value.split('-');
        if(list[0]==sup.id && list[1]==sup.name){
          check= true;
        }
      }
      return check;
    }
    
    Future<void> deleteSupForitem()async{
       for(var value in list){
          item.suppliers.remove(value);
       }
    }

  Future<void> deletesup(List<String> itemslist,String s) async {
    for(var val in itemslist){
       List<String> l = val.split('-');
       Item? i = await getitem(l[0]);
       if(i!=null){
         updateItem(i);
         for(var value in item.suppliers){
      List<String> list = value.split('-');
      if(list[0]==s){
        item.suppliers.remove(value);
        updateItems();
        break;
      }
    }
       }
       
    }
    
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
  item.suppliers=[];
    item.id='item${n+1}';
  }



    bool isSelectedIt(Item i){
      return items.contains(i);
  }
  
    void selectedSup(bool selected,String s){
    if(selected){
      list.add(s);
    }
    else{
      list.remove(s);
    }
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
  
          bool isSelectedsup(String s){
      return list.contains(s);
  }
  

  bool ischeck(){
    if(checksup == false){
      checksup=true;
    }
    else{
      checksup=false;
    }
    return checksup;
  }

    Future<void> newItem()async{
    ref.read(itemsDatabaseProvider).additem(item);
  }
  
   Future<List<Item>> getitems()async{
    return await ref.read(itemsDatabaseProvider).getitems();
      }

  Future<Item?> getitem(String s)async{
    return await ref.read(itemsDatabaseProvider).getItemById(s);
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