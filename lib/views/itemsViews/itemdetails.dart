



// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/views/itemsViews/addsuptoItem.dart';
import 'package:shopnewversion/views/itemsViews/itemsViewsWidgets.dart';

class ItemsDetailsPage extends ConsumerStatefulWidget {
  final Item item;
  final String currency;
  const ItemsDetailsPage({super.key, required this.item,required this.currency});

    @override
  ItemsDetailsPageState createState()=> ItemsDetailsPageState();
}

class ItemsDetailsPageState extends ConsumerState<ItemsDetailsPage>{
  bool selectedMode=false;
  

  @override
  Widget build(BuildContext context) {
    Item it=widget.item;
    final controller = ref.watch(itemsControllerProvider);
    final control = ref.watch(suppliersControllerProvider);
     controller.updateItem(it);
     
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225), 
      appBar: AppBar(
        title: Text(controller.item.name,style:const TextStyle(
                              color: Colors.white)),
        backgroundColor:  const  Color.fromARGB(255, 20, 58, 74),   
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // picture
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  controller.item.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // product name
            Text(
              controller.item.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Description 
            Text(
              controller.item.description!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Quantity
            Row(
              children: [
                const Icon(Icons.inventory, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Quantity: ${controller.item.quantity}',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // price
            Row(
              children: [
                const Icon(Icons.price_check, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Sale price: \$${controller.item.saleprice}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // suppliers
          Row(children: [
              const Text(
              'Suppliers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(width: 50),
             IconButton(
              onPressed: () async {
               await Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => addsupllierstoItem(controller)),
                );
                 setState(() {
                 controller.item;
                 });
                
              }, 
              icon: const Icon(Icons.add)
              ),
              IconButton(
                onPressed: (){
                 setState(() {
                  controller.ischeck();
                });
                }, 
                icon:const  Icon(Icons.delete))
          ],),
            const SizedBox(height: 10),

            // Supplierslist
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.item.suppliers.length,
              itemBuilder: (context, index) {
                final List<String>  supplier = controller.item.suppliers[index].split('-');
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading:controller.checksup? Checkbox(
                        value: controller.isSelectedsup(controller.item.suppliers[index]), 
                        onChanged:  (bool? value) {
                             setState(() {
                              controller.selectedSup(value!, controller.item.suppliers[index]);
                             });
                        },)
                        :  IconButton(onPressed: () {
                      //create a purchase here
                    },
                      icon:const  Icon(Icons.local_shipping,color: Colors.teal), 
                      ),
                    title: Text(supplier[1]), // get the supplier first
                    subtitle: Text('Purchase Price: ${widget.currency} ${supplier[2]}'),
                  ),
                );
              },
            ),

          ],
        ),
      ),
      floatingActionButton: floatButtonItemDetails(context, controller.item, widget.currency, (isSelected){
                      setState(() {
                  selectedMode = isSelected;
                  controller.item;
                });
                   }),
           bottomNavigationBar: controller.checksup?
          BottomAppBar(
              child: Row(
                children: [
                  TextButton(
                    onPressed:(){
                      setState(() {
                  controller.ischeck();
                });
                    }, 
                    child: const Text('Cancel')),
                  TextButton(
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
                                           controller.ischeck();
                                          controller.list.clear();
                                         
                                         });
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                      TextButton(
                                     onPressed: ()async{
                                      await control.deleteit(controller.list, controller.item.id);
                                      await controller.deleteSupForitem() ; 
                                      await controller.updateItems();
                                      setState(() {
                                            controller.list.clear();
                                           controller.ischeck();
                                         });
                                       // ignore: use_build_context_synchronously
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('yes',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold))),

                    ],
                  ),
                );
               });     
               },
               child:const Text('Delete',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
          )  
                ],
              ))
          :null             
    );
  }
}
