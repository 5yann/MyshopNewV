// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/itemsProvider.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/views/itemsViews/itemsViewsWidgets.dart';

class ItemPercategory extends ConsumerStatefulWidget{
  final Category category;
  
  final String currency;

  const ItemPercategory({super.key,required this.category,required this.currency});

  @override
  ItemCatState createState()=> ItemCatState();
}

class ItemCatState extends ConsumerState<ItemPercategory>{
  bool selectedMode=false;
  bool searchMode=false;
  @override
  Widget build(BuildContext context) {
    final itemsAsyncValue = ref.watch(itemsListProvider);
    final controller = ref.watch(itemsControllerProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(
        title: searchMode?
        const Text('')
        : Text(widget.category.categoryname,
                             style:const TextStyle(
                              color: Colors.white
                             ),),
            backgroundColor:const  Color.fromARGB(255, 20, 58, 74),
        actions: [
                  selectedMode
                  ?TextButton(onPressed:(){ 
                    setState(() {
                      selectedMode=false;
                      controller.clearItems();
                    });
                  }, 
                  child:const Text('Cancel',style: TextStyle(color: Colors.white),))
                  :const Text('')]      
      ),

      body: itemsAsyncValue.when(
        
        data: (items) {
          final finalItems = items.where((it)=>it.category==widget.category.catId).toList();
          return ListView.builder(
            itemCount: finalItems.length,
            itemBuilder: (context, index) {
              final item = finalItems[index];
              return ListTile(
                leading: selectedMode
                ? Checkbox(
                        value: controller.isSelectedIt(item),
                        onChanged: (bool? value) {
                             setState(() {
                              controller.selecteditems(value!, item);
                             });
                        },
                      )
                    : null,
                     onTap: controller.isSelectedIt(item)
                     ?() {
                       controller.selecteditems(false, item);
                        }
                     :null,

                title:inkWellItem(item, context,widget.currency) ,    
              );//
            },
          );
        },
        
        loading: () => const Center(child: CircularProgressIndicator()),
        
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      floatingActionButton: floatButtonItemsPerCategory(context,widget.category.catId, (isSelected){
                      setState(() {
                  selectedMode = isSelected;
                });
                   }),
            bottomNavigationBar: controller.items.isNotEmpty?
          BottomAppBar(
              child: TextButton(
               onPressed: ()async{
             await   showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), 
                       ),
                  contentPadding: const EdgeInsets.all(20), 
                  titlePadding: const EdgeInsets.all(20), 
                  title: const  Text('Are you sure you want to delete ?'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                                     onPressed: (){
                                        setState(() {
                                          selectedMode=false;
                                          controller.clearItems();
                                         });
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                      TextButton(
                                     onPressed: ()async{
                                      await   controller.deleteItems();
                                      setState(() {
                                          selectedMode=false;
                                          controller.clearItems();
                                         });
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('yes',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold))),

                    ],
                  ),
                );
               });     
               },
               child:const Text('Delete',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
          ))
          :null
    );
  }

}