
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';
import 'package:shopnewversion/views/suppliersView/addItemstoSupllier.dart';
import 'package:shopnewversion/views/suppliersView/supplierdetails.dart';

SizedBox inkwellSupplierList(BuildContext context, Supplier sup){
  List<String> list =[];
    for(var value in sup.list){
      List<String> s=value.split('-');
      list.add(s[1]);
    }
    
    return SizedBox(
  width: double.infinity, // Prend toute la largeur disponible
  child: InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupplierDetailsPage(supplier: sup)),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      shadowColor: const Color.fromARGB(255, 69, 128, 77),
      color: const Color.fromARGB(255, 20, 58, 74),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 250,
          height: 150,
          child: Row(
            children: [
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Icon(
                  Icons.person,
                  size: 80,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sup.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 216, 222, 220),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      list.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 216, 222, 220),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      sup.contact,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 216, 222, 220),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sup.adress!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 216, 222, 220),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);

}

SpeedDial floatButtonSupplier(Supplier sup,WidgetRef ref ,BuildContext context,Supllierscontoller control){
  return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child:const  Icon(Icons.add),
            backgroundColor: const Color.fromARGB(255, 29, 155, 209),
            label: 'Add Item',
            onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => additemstosupllier(control)),
              
            );
            
            },
          ),
          SpeedDialChild(
            child:const  Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Delete Item',
            onTap: () {
              
            },
          ),
          
        ],
      );
}




