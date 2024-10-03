 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class SupplierUpdateform extends ConsumerStatefulWidget{
  final Supplier item;
  const SupplierUpdateform({super.key,required this.item});

  @override
  SupplierUpdateformState createState()=> SupplierUpdateformState();
}

class SupplierUpdateformState extends ConsumerState<SupplierUpdateform>{
   final formKey = GlobalKey<FormState>();
  late TextEditingController nametextController;
  late TextEditingController adresstextController;
  late TextEditingController emailtextController;
  late TextEditingController contacttextController;


    @override
  void initState() {
    super.initState();
    nametextController = TextEditingController(text: widget.item.name);
    adresstextController = TextEditingController(text: widget.item.adress!);
    emailtextController = TextEditingController(text: widget.item.email);
    contacttextController = TextEditingController(text: widget.item.contact);
  }

  @override
  void dispose() {
    nametextController.dispose();
    emailtextController.dispose();
    adresstextController.dispose();
    contacttextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final controller = ref.watch(suppliersControllerProvider);
     controller.supplier=widget.item;

     return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(title:  Text(controller.supplier.name,
                             style:const TextStyle(
                              color: Colors.white
                             ),),
            backgroundColor:const  Color.fromARGB(255, 20, 58, 74),) ,
      body: SingleChildScrollView(
        child: Padding(padding:  const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey, 
              child: Column(
                children: <Widget>[
                TextFormField(
                  controller: nametextController,
                decoration: inputdecoration('name'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateSupName(val);
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
                  controller: adresstextController,
                decoration: inputdecoration('adress'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateSupAdress(val);
                },
              ),
               const SizedBox(height: 20.0),
              TextFormField(
                controller: contacttextController,
                decoration: inputdecoration('phoneNumber'),
                validator: validatr,
                onChanged: (val) {
                controller.updateContact(val);
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
                  controller: emailtextController,
                decoration: inputdecoration('Email'),
                validator: validatr,
                onChanged: (val) {
                 controller.updateSupEmail(val);
                },
              ),
               const SizedBox(height: 20.0),
                ],
              )),

           TextButton(
          
          onPressed: () async {
              if (formKey.currentState?.validate() ??false) {
                   await controller.updateSup();
                   // ignore: use_build_context_synchronously
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('done',
                       style: TextStyle(
                        color: Colors.green
                       ),)));
                       // ignore: use_build_context_synchronously
                       Navigator.pop(context);
                  } else {
                    
                       ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('some field(s) are empty')),
                    );
                    
                  }
          },
          style:const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(500)),
              backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
            ),
          child:const Center(
            child: Text('Update',
            style: TextStyle(
              color:  Color.fromARGB(255, 209, 216, 225)
            ),),
          )
            )    
          ],
        ),),
      )   
     );
  }
  
}