//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/supplierProvider.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';

class  Supllierscontoller {
  Supplier supplier= Supplier(id: '', name: '', contact: '', adress: '', email: '', list: []);

      final Ref ref;
    List<Supplier> suppliers=[];
    List<String> list=[];
    List<Item> items=[];
    bool checkit=false;
    Supllierscontoller(this.ref);


    void updateSupName(String name) {
       supplier.name=name;
     }
    void updateContact(String contact) {
       supplier.contact=contact;
     }
      void updateSupAdress(String adres) {
       supplier.adress=adres;
    }
      void updateSupEmail(String mail) {
       supplier.email=mail;
    }
      Future<void> updateSupItems(Map<Item, double> items) async{
       items.forEach((item,value){
         supplier.list.add('${item.id}-${item.name}-${value.toString()}');
       });
       updateSup();
    }

    bool itemcheck(Item item){
      bool check=false;
      for (var value in supplier.list) {
        List<String> list = value.split('-');
        if(list[0]==item.id && list[1]==item.name){
          check= true;
        }
      }
      return check;
    }

    Future<void> deleteitemForsup()async{
       for(var value in list){
          supplier.list.remove(value);
       }
       updateSup();
    }

      void updateSupId() {
      final supplierssAsyncValue = ref.watch(suppliersListProvider);
    Supplier val = supplierssAsyncValue.maybeWhen(
  data: (supps) => supps.isNotEmpty
  ?supps.last
  :Supplier(
    id: 'sup0',
    name: '',
    contact: '',
    adress: '',
    email: '',
    list: [],
  ),
     orElse :()=> Supplier(
    id: 'sup0',
    name: '',
    contact: '',
    adress: '',
    email: '',
    list: [],
    ) 
  
);
  String s = val.id.replaceAll(RegExp(r'[^0-9]'), '');
  int n = int.parse(s);
    supplier.list=[];
    supplier.id='sup${n+1}';
    }
    


      bool isSelectedcat(Supplier s){
      return suppliers.contains(s);
  }
  
  void takeSup(Supplier sup){
     supplier=sup;
  }

  void selectedItems(bool selected,Supplier s){
    if(selected){
      suppliers.add(s);
    }
    else{
      suppliers.remove(s);
    }
  }

  void clearItems(){
    suppliers.clear();
  }

        bool isSelectedit(String s){
      return list.contains(s);
  }
  

  bool ischeck(){
    if(checkit == false){
      checkit=true;
    }
    else{
      checkit=false;
    }
    return checkit;
  }

  void selectedItem(bool selected,String s){
    if(selected){
      list.add(s);
    }
    else{
      list.remove(s);
    }
  }

  void clearItem(){
    list.clear();
  }

    Future<void> deleteit(List<String> itemslist,String s) async {
    for(var val in itemslist){
       List<String> l = val.split('-');
       Supplier? i = await getSup(l[0]);
       if(i!=null){
        
         getsup(i);
         print(supplier.id);
         for(var value in supplier.list){
      List<String> list = value.split('-');
      if(list[0]==s){
        supplier.list.remove(value);
        updateSup();
        break;
      }
    }
       }
       
    }
    
  }

    Future<Supplier?> getSup(String s)async{
    return await ref.read(suppliersDatabaseProvider).getSupById(s);
      }

  void getsup(Supplier s){
    supplier=s;
  }

  Future<List<Supplier>>  getSuppliersList() async {
    List<Supplier>  sups = await ref.read(suppliersDatabaseProvider).getSuppliers();
    return sups;
  }

       Future<void> newSup(Supplier sup)async{
    ref.read(suppliersDatabaseProvider).addSupplier(sup);
  }

  Future<void> deleteSup(Supplier s)async{
     
           ref.read(suppliersDatabaseProvider).removeSupplier(s);
       
    print('deleted');
  }

  Future<void> updateSup()async{
    ref.read(suppliersDatabaseProvider).updateSupllier(supplier);
  }
}


  final suppliersControllerProvider = Provider((ref) {
  return Supllierscontoller(ref);
});