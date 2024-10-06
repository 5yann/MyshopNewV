
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/models/registermodel/registermodel.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';

class HomepageController {
  final Ref ref;
  late UserRegister mainUser;

  HomepageController(this.ref);
  

  void initUser(UserRegister user){
    mainUser = user;
  }

  // delete supplier in items.suppliers when you delete Supplier object
  Future<void> deleteSupInItems(Supplier sup) async {
     final itemscontroller = ref.watch(itemsControllerProvider);
     List<Item> items = await itemscontroller.getitems();
     if(items.isNotEmpty){
      for(var item in items){
        itemscontroller.updateItem(item);
        for(var value in itemscontroller.item.suppliers){
          List<String> S = value.split('-');
           if(S[0]==sup.id){
              itemscontroller.item.suppliers.remove(value);
              itemscontroller.updateItems();
              break;
           }
        }

      }
     }

  }
  // delete Item in suppliers.list  when you delete Item object
  Future <void> deleteItemInSuppliers(Item item)async{
    final supplierController = ref.watch(suppliersControllerProvider);
    List<Supplier> sups = await supplierController.getSuppliersList();
    if(sups.isNotEmpty){
      for(var sup in sups){
        supplierController.getsup(sup);
        for(var value in supplierController.supplier.list){
          List<String> S = value.split('-');
          if(S[0]==item.id){
            supplierController.supplier.list.remove(value);
            supplierController.updateSup();
            break;
          }
        }
      }
    }
}
}

 final homeControllerProvider = Provider((ref) {
  return HomepageController(ref);
});