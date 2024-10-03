

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/categoriescontroller/CategoriesController.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/views/itemsViews/itemsPerCategory.dart';

void showSimpleDialogcatAdd(BuildContext context, WidgetRef ref,String currency) {
  final controller = ref.watch(categoriesControllerProvider);
  final formKey = GlobalKey<FormState>();
  controller.updateuid();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
        ),
        contentPadding: const EdgeInsets.all(20), 
        titlePadding: const EdgeInsets.all(20), 
        title: const Text(
          'Add a Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: <Widget>[
                const SizedBox(height: 15),
                TextFormField(
                  decoration: inputdecoration('Category Name'),
                  validator: validatr,
                  onChanged: (val) {
                    controller.updatecatname(val);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: inputdecoration("Description"),
                  validator: validatr,
                  onChanged: (val) {
                    controller.updatedesc(val);
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 10, bottom: 10), 
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey), 
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), 
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
            ),
            child: const Text('Add'),
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                await controller.newCtgry();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}




void showSimpleDialogcatUpdate(BuildContext context, WidgetRef ref, Category cat) {
  final controller = ref.watch(categoriesControllerProvider);
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
        ),
        contentPadding: const EdgeInsets.all(20), 
        titlePadding: const EdgeInsets.all(20), 
        title: const Text(
          'Update Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), 
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: <Widget>[
                const SizedBox(height: 15),
                TextFormField(
                  decoration: inputdecoration(cat.categoryname),
                  validator: validatr,
                  onChanged: (val) {
                    controller.updatecatname(val);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: inputdecoration(cat.description),
                  validator: validatr,
                  onChanged: (val) {
                    controller.updatedesc(val);
                  },
                ),
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 10, bottom: 10), 
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey), 
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), 
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
            ),
            child: const Text('Update'),
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                controller.cat.catId = cat.catId;
                await controller.updateCtgry();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}


    InputDecoration inputdecoration(String hintext){
    return  InputDecoration(hintText: hintext,
                border: const OutlineInputBorder(),
                  focusedBorder:const  OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, 
                      width: 2.0,
                    ),
                  ),
                );
  }

  String? validatr(String ? val){
       if (val == null || val.isEmpty) {
    return 'empty field'; 
  }
  return null;
  }

   InkWell inkWell(Category cat,BuildContext context,WidgetRef ref,int n, Function(bool) mod,String currency){
    
    return InkWell(
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemPercategory(category:cat,currency: currency,)),
            );

          },
          onLongPress: () {
            showOptions(context, ref, cat,n,mod,currency);
          },
          child:    Card(
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10), 
                       ),
               elevation: 20,
               shadowColor: const Color.fromARGB(255, 69, 128, 77),
               color: const  Color.fromARGB(255, 20, 58, 74),
               child: ClipRRect(
               borderRadius: BorderRadius.circular(10), 
               child: SizedBox(
               width: 180,
               height: 120,
               child: Row(
                children: [
                  const SizedBox(width: 20,),
                  Text(cat.categoryname,style: const TextStyle(
                    fontSize: 30,
                    color:  Color.fromARGB(255, 216, 222, 220),
                  ),),
                  Text(': ${cat.description}',
                  style: const TextStyle(
                    
                    color:  Color.fromARGB(255, 216, 222, 220),
                  ),)
                ],
               )
                  ),
                ),
              ),       
    );
  }

  void showOptions(BuildContext context,WidgetRef ref,Category cat,int n, Function(bool) mod,String currency){
       showDialog(
        context: context, 
        builder: (BuildContext context){
           return AlertDialog(
             shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
      contentPadding:const EdgeInsets.all(16),
            content: Column(
               mainAxisSize: MainAxisSize.min,
              children: [ 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                      TextButton(onPressed:() async {
                         Navigator.pop(context);
                         showSimpleDialogcatAdd(context,ref,currency);
                        
                      }
                , child:const Text('New category')),
                const Icon(Icons.add)
                 ],
                ),
                 const Divider(),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                      TextButton(onPressed:(){
                        Navigator.pop(context);
                        showSimpleDialogcatUpdate(context, ref, cat);
                      }
                , child:const Text('Modify')),
                const SizedBox(width: 30,),
                const Icon(Icons.update)
                 ],
                ),
                 const Divider(),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   TextButton(onPressed: (){
                     mod(true);
                     Navigator.pop(context);
                   }
                , child:const Text('Delete',style: TextStyle(color: Colors.red))),
                const SizedBox(width: 30,),
                const Icon(Icons.delete,
                color: Colors.red,)
                 ],
                ),
              ],
            ),
           );
        });
  }