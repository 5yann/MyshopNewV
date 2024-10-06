
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/itemsProvider.dart';
import 'package:shopnewversion/Riverpod_providers/supplierProvider.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class addsupllierstoItem extends ConsumerStatefulWidget {
  
  final Itemscontroller controller;
   const addsupllierstoItem(this.controller, {super.key,});

  @override
  _SupplierSelectionPageState createState() => _SupplierSelectionPageState();
}

class _SupplierSelectionPageState extends ConsumerState<addsupllierstoItem> {
  // Map pour stocker les items sélectionnés et leurs valeurs
  Map<Supplier, double> selectedItemsWithValues = {};

  @override
  Widget build(BuildContext context) {
    final suppliersAsyncValue = ref.watch(suppliersListProvider);
    final controller = widget.controller;
    final controller1 = ref.watch(suppliersControllerProvider);
    

    return suppliersAsyncValue.when(
      loading: () =>const CircularProgressIndicator(),
      error: (error, stack) => Text('Erreur: $error'),
      data: (items) {
        final visibleItems = items.where((item) => !controller.supcheck(item)).toList();
        return Scaffold(
          appBar: AppBar(
            title:const Text("select item(s)"),
          ),
          body: ListView.builder(
            itemCount: visibleItems.length,
            itemBuilder: (context, index) {
              final item = visibleItems[index];
              return ListTile(
                title: Text(item.name),
                trailing: Checkbox(
                  value: selectedItemsWithValues.containsKey(item),
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked == true) {
                        // Ajouter un champ de saisie de valeur quand l'item est sélectionné
                        selectedItemsWithValues[item] = 0.0; // Valeur initiale
                      } else {
                        // Retirer l'item s'il est décoché
                        selectedItemsWithValues.remove(item);
                      }
                    });
                  },
                ),
                subtitle: selectedItemsWithValues.containsKey(item)
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:inputdecoration('Enter Purchase Price'),
                        onChanged: (value) {
                          setState(() {
                            selectedItemsWithValues[item] = double.tryParse(value) ?? 0.0;
                          });
                        },
                      )
                    : null, // Champ de texte affiché uniquement si l'item est sélectionné
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // Valider et soumettre les items sélectionnés avec leurs valeurs
              print(selectedItemsWithValues);
              
              selectedItemsWithValues.forEach((item,value){
                controller1.supplier=item;
                Map<Item, double> selectedSuppliersWithValues = {};
                selectedSuppliersWithValues[controller.item]= value;
                controller1.updateSupItems(selectedSuppliersWithValues);
                controller.updateSuppliers('${controller1.supplier.id}-${controller1.supplier.name}-${value.toString()}');
                
              });
             
             await controller.updateItems();
             // ignore: use_build_context_synchronously
             Navigator.pop(context,);
            },
            child:const Icon(Icons.check),
          ),
        );
      },
    );
  }
}
