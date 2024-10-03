



// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
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
            const Text(
              'Suppliers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
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
                    leading:  IconButton(onPressed: () {
                      //create a purchase here
                    },
                      icon:const  Icon(Icons.local_shipping,color: Colors.teal), 
                      ),
                    title: Text(supplier[0]), // get the supplier first
                    subtitle: Text('Purchase Price: ${widget.currency} ${supplier[1]}'),
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
    );
  }
}
