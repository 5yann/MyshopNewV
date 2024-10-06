

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopnewversion/Riverpod_providers/supplierProvider.dart';
import 'package:shopnewversion/controllers/homepage_control/homepage_controller.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/views/suppliersView/newSupplier.dart';
import 'package:shopnewversion/views/suppliersView/suppliersViewWigdets.dart';

class Supplierlist extends ConsumerStatefulWidget{
  const Supplierlist({super.key});

  
  @override
  SupplierlistState createState()=> SupplierlistState();
 }

 class SupplierlistState extends ConsumerState<Supplierlist>{

  @override
  Widget build(BuildContext context) {
    final suppliersAsyncValue = ref.watch(suppliersListProvider);
    final controller = ref.watch(suppliersControllerProvider);
    final homeController = ref.watch(homeControllerProvider);

   return Scaffold(
    backgroundColor: const  Color.fromARGB(255, 209, 216, 225),
    appBar: AppBar(
      title: const Text("Suppliers",
                             style: TextStyle(
                              color: Colors.white
                             ),),
      backgroundColor:const  Color.fromARGB(255, 20, 58, 74),
      actions:[
          IconButton(
            onPressed: (){}, 
            icon:const Icon(Icons.search,color: Colors.white)),
          IconButton(
            onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Newsupplierform()),
          );
            },
             icon:const  Icon(
              Icons.add_circle_sharp,
              color: Colors.white,))
        ],
    ),
    body: suppliersAsyncValue.when(
      data: (suppliers){
               return ListView.builder(
                          itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return Slidable(
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(), 
                  children: [
                    SlidableAction(
                      onPressed:(context){
                         controller.deleteSup(supplier);
                         homeController.deleteSupInItems(supplier);
                      } ,
                       backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Delete',)
                  ]),
                  child: inkwellSupplierList(context, supplier),
              );
              }
                );
      }, 
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Erreur: $err'),
      ),
   ));
  }

 }