//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/supplierProvider.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';

class  Supllierscontoller {
  Supplier supplier= Supplier(id: '', name: '', contact: '', adress: '', email: '', list: []);

      final Ref ref;
    List<Supplier> suppliers=[];
    List<Item> items=[];
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
      void updateSupItems(List<String> itemsid, List<double> prices) {
       for(int i=0;i<itemsid.length;i++){
        String s1=prices[i].toString();
        supplier.list.add('${itemsid[i]}-$s1');
       }
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
    list: []),
     orElse :()=> Supplier(
    id: 'sup0',
    name: '',
    contact: '',
    adress: '',
    email: '',
    list: []) 
  
);
  String s = val.id.replaceAll(RegExp(r'[^0-9]'), '');
  int n = int.parse(s);
    supplier.id='sup${n+1}';
    }
    


      bool isSelectedcat(Supplier s){
      return suppliers.contains(s);
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

       Future<void> newSup()async{
    ref.read(suppliersDatabaseProvider).addSupplier(supplier);
  }

  Future<void> deleteSup()async{
     for (Supplier itm in suppliers) {
           ref.read(suppliersDatabaseProvider).removeSupplier(itm);
       } 
    print('deleted');
  }

  Future<void> updateSup()async{
    ref.read(suppliersDatabaseProvider).updateSupllier(supplier);
  }
}


  final suppliersControllerProvider = Provider((ref) {
  return Supllierscontoller(ref);
});