// ignore_for_file: camel_case_types, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/itemsProvider.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class additemstosupllier extends ConsumerStatefulWidget {
  
  final Supllierscontoller controller;
   const additemstosupllier(this.controller, {super.key,});

  @override
  _ItemsSelectionPageState createState() => _ItemsSelectionPageState();
}

class _ItemsSelectionPageState extends ConsumerState<additemstosupllier> {
  
  Map<Item, double> selectedItemsWithValues = {};

  @override
  Widget build(BuildContext context) {
    final itemsAsyncValue = ref.watch(itemsListProvider);
    final controller = widget.controller;
    final controller1 = ref.watch(itemsControllerProvider);
    

    return itemsAsyncValue.when(
      loading: () =>const CircularProgressIndicator(),
      error: (error, stack) => Text('Erreur: $error'),
      data: (items) {
        final visibleItems = items.where((item) => !controller.itemcheck(item)).toList();
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
                        
                        selectedItemsWithValues[item] = 0.0; 
                      } else {
                        
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
                    : null, 
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
             
              print(selectedItemsWithValues);
              selectedItemsWithValues.forEach((item,value){
                controller1.updateItem(item);
                controller1.updateSuppliers('${controller.supplier.id}-${controller.supplier.name}-${value.toString()}');
              });
             await  controller.updateSupItems(selectedItemsWithValues);
             await controller.updateSup();
             // ignore: use_build_context_synchronously
             Navigator.pop(context,controller.supplier.list.last);
            },
            child:const Icon(Icons.check),
          ),
        );
      },
    );
  }
}
