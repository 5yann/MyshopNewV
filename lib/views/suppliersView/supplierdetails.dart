import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';
import 'package:shopnewversion/views/suppliersView/supplierUpdate.dart';
import 'package:shopnewversion/views/suppliersView/suppliersViewWigdets.dart';

class SupplierDetailsPage extends ConsumerStatefulWidget {
  final Supplier supplier;

  const SupplierDetailsPage({super.key, required this.supplier});
  @override
  SupplierDetailsPageState createState()=>SupplierDetailsPageState();
}

class SupplierDetailsPageState extends ConsumerState<SupplierDetailsPage>{
  
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(suppliersControllerProvider);
    controller.supplier=widget.supplier;
    return Scaffold(
     backgroundColor:  const  Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(
        title:const Text('Supplier details',style: TextStyle(color: Colors.white),),
        backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
        actions: [
          IconButton
          (onPressed: ()async{
           await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupplierUpdateform(item: controller.supplier)),
          );
          setState(() {});
          }, 
          icon:const Icon(Icons.edit,color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section d'en-tête avec nom, email, contact et adresse
            Text(
              controller.supplier.name,
              style:const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height: 10),
            Row(
              children: [
               const  Icon(Icons.email, color: Colors.blue),
               const SizedBox(width: 10),
                Text(
                  controller.supplier.email!,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
           const  SizedBox(height: 10),
            Row(
              children: [
               const  Icon(Icons.phone, color: Colors.green),
               const  SizedBox(width: 10),
                Text(
                 controller.supplier.contact,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    controller.supplier.adress!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

           const  Divider(),

            // Liste des produits fournis par le fournisseur
           const  Text(
              'Items supplied',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: controller.supplier.list.length,
                itemBuilder: (context, index) {
                  List<String> item= controller.supplier.list[index].split('-');
                  return Card(
                    margin:const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(item[0][0].toUpperCase()),
                      ),
                      title: Text(
                        item[0],
                        style:const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('price per unit: \$${item[1]}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatButtonSupplier(context),
    );
  }
  
}

