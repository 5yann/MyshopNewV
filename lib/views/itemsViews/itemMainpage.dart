

// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/itemsProvider.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/views/itemsViews/itemsViewsWidgets.dart';

class Itemmainpage extends ConsumerStatefulWidget{
  final String currency;

  const Itemmainpage({super.key, required this.currency});
  
  @override
  ItemmainpageState createState()=> ItemmainpageState();
}

class ItemmainpageState extends ConsumerState<Itemmainpage>{
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
        :const Text("My items",
                             style: TextStyle(
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
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
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
      floatingActionButton: floatButtonItems(context),
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