
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';
import 'package:shopnewversion/views/suppliersView/supplierdetails.dart';

SizedBox inkwellSupplierList(BuildContext context, Supplier sup){
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
                      sup.list.toString(),
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

SpeedDial floatButtonSupplier(BuildContext context){
  return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child:const  Icon(Icons.search),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Add Item',
            onTap: () {},
          ),
          SpeedDialChild(
            child:const  Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Delete Item',
            onTap: () {},
          ),
          
        ],
      );
}

/*class AddItemsToSup extends ConsumerWidget {
  final Supplier supplier;
  final List<Item>  items ;
  const AddItemsToSup({super.key, required this.supplier, required this.items});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final controller = ref.watch(suppliersControllerProvider);
     final List<String> price =[];
     return Scaffold(
      backgroundColor: const  Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index){
          final item = controller.items[index];
          return ListTile(
            title: Row(
              children: [
                Text(item.name),
                const SizedBox(width: 20,),
                SizedBox(
                  child: TextField(               
                    decoration: inputdecoration('price'),
                    onChanged: (val) {
                    price[index]=val;
                    }),
                )
              ],
            ),
          );
        }
        ) ,
     );
  }
  
  
}*/


void AddItemsToSup(Supplier sup,List<Item> items,WidgetRef ref){
         final controller = ref.watch(suppliersControllerProvider);
         final List<String> price =[];

}