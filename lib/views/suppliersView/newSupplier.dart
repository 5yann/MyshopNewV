
// use_build_context_synchronously, 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/controllers/suppliersController/suplliersContoller.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class Newsupplierform extends ConsumerStatefulWidget{
  
  const Newsupplierform({super.key,});

  @override
  NewsupplierformState createState()=> NewsupplierformState();
}

class NewsupplierformState extends ConsumerState<Newsupplierform>{
   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(suppliersControllerProvider);
    controller.supplier;
     return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(title: const Text("New aupplier",
                             style: TextStyle(
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
                decoration: inputdecoration('Name'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateSupName(val);
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
                decoration: inputdecoration('adress'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateSupAdress(val);
                },
              ),
               const SizedBox(height: 20.0),
              TextFormField(
                decoration: inputdecoration('phone number'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateContact(val);
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
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
                controller.updateSupId();
              if (formKey.currentState?.validate() ??false) {
                print(controller.supplier.list);
                   await controller.newSup(controller.supplier);
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
            child: Text('Add',
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