
// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/Riverpod_providers/categoriesProvider.dart';
import 'package:shopnewversion/controllers/categoriescontroller/CategoriesController.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class Categoriesmainpage extends ConsumerStatefulWidget{

   @override
  CategoriesmainpageState createState() => CategoriesmainpageState();
}

class CategoriesmainpageState extends ConsumerState<Categoriesmainpage> {
  bool selectedMod=false;

  @override
  Widget build(BuildContext context) {
    final categoriesAsyncValue = ref.watch(categoriesListProvider);
    final controller = ref.watch(categoriesControllerProvider);
    
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225),
      appBar:  AppBar(
            title: const Text("My categories",
                             style: TextStyle(
                              color: Colors.white
                             ),),
            backgroundColor:const  Color.fromARGB(255, 20, 58, 74),
            actions: [
                  selectedMod
                  ?TextButton(onPressed:(){ 
                    setState(() {
                      selectedMod=false;
                      controller.clearItems();
                    });
                  }, 
                  child:const Text('Cancel',style: TextStyle(color: Colors.white),))
                  :IconButton(onPressed:(){
                    showSimpleDialogcatAdd(context, ref);
                  } , 
                 icon: const Icon(Icons.add ,color: Colors.white ,)),              
            ],
          ),
          
          body: categoriesAsyncValue.when(
        
        data: (items) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: selectedMod
                ? Checkbox(
                        value: controller.isSelectedcat(item),
                        onChanged: (bool? value) {
                             setState(() {
                              controller.selectedItems(value!, item);
                             });
                        },
                      )
                    : null,
                     onTap: controller.isSelectedcat(item)
                     ?() {
                       controller.selectedItems(false, item);
                        }
                     :null,

                title:inkWell(item, context,ref,items.length,
                   (isSelected){
                      setState(() {
                  selectedMod = isSelected;
                });
                   }
                ) ,    
              );//
            },
          );
        },
        
        loading: () => const Center(child: CircularProgressIndicator()),
        
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      bottomNavigationBar: controller.cats.isNotEmpty?
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
                                          selectedMod=false;
                                          controller.clearItems();
                                         });
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                      TextButton(
                                     onPressed: ()async{
                                      await   controller.deleteCtgry();
                                      setState(() {
                                          selectedMod=false;
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