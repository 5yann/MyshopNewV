import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/categoriesProvider.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';

class Categoriescontroller {
  Category cat = Category(categoryname: '', total: 0, description: '',catId: '');
  User? user = FirebaseAuth.instance.currentUser;
  List<Category> cats=[];
  bool selectedMod=false;
  final Ref ref;
  Categoriescontroller(this.ref);

 void updatecatname(String name) {
    cat.categoryname=name;
  }
  
 void updatedesc(String desc) {
    cat.description=desc;
  }
 void updateuid() {
    final categoriesAsyncValue = ref.watch(categoriesListProvider);
    Category val = categoriesAsyncValue.maybeWhen(
  data: (categories) => categories.isNotEmpty
  ?categories.last
  :Category(
    categoryname: '',
    total: 0.0,
    description: '',
    catId: 'cat0'),
     orElse :()=> Category(
    categoryname: '',
    total: 0.0,
    description: '',
    catId: 'cat0') 
  
);
  String s = val.catId.replaceAll(RegExp(r'[^0-9]'), '');
  int n = int.parse(s);
    cat.catId='cat${n+1}';
  }
  
  bool isSelectedcat(Category c){
      return cats.contains(c);
  }
  
   void updateselectedMod(){
      if(selectedMod==true){
        selectedMod=false;
      }
      else{
        selectedMod=true;
      }
  }

  void selectedItems(bool selected,Category c){
    if(selected){
      cats.add(c);
    }
    else{
      cats.remove(c);
    }
  }

  void clearItems(){
    cats.clear();
  }
  
  Future<void> newCtgry()async{
    ref.read(categoryDatabaseProvider).addItem(user!.uid, cat);
  }

  Future<void> deleteCtgry()async{
     for (Category item in cats) {
           ref.read(categoryDatabaseProvider).removeItem(user!.uid, item);
       } 
    print('deleted');
  }

  Future<void> updateCtgry()async{
    ref.read(categoryDatabaseProvider).updateItem(user!.uid, cat);
  }

}

  final categoriesControllerProvider = Provider((ref) {
  return Categoriescontroller(ref);
});

