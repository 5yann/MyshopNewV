
// ignore_for_file:, use_build_context_synchronously, use_build_context_synchronously, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class Newitemform extends ConsumerStatefulWidget{
  final String  ctgy;
  const Newitemform({super.key,required this.ctgy});

  @override
  NewitemformState createState()=> NewitemformState();
}

class NewitemformState extends ConsumerState<Newitemform>{
   final formKey = GlobalKey<FormState>();
   File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> takePicture(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(itemsControllerProvider);
     return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(title: const Text("New item",
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
                decoration: inputdecoration('ItemName'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateItemname(val);
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
                decoration: inputdecoration('Description'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateItemdesc(val);
                },
              ),
               const SizedBox(height: 20.0),
              TextFormField(
                decoration: inputdecoration('Sale price'),
                validator: validatr,
                onChanged: (val) {
                  double? convertedValue = double.tryParse(val);
                  if (convertedValue != null) {
                  controller.updateSaleprice(convertedValue);
                  } else {
                  val='';
                  }
                  
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
                decoration: inputdecoration('Quantity'),
                validator: validatr,
                onChanged: (val) {
                   double? convertedValue = double.tryParse(val);
                  if (convertedValue != null) {
                  controller.updateQty(convertedValue);
                  } else {
                  val='';
                  }
                },
              ),
               const SizedBox(height: 20.0),
                _image != null
              ? Image.file(_image!)
              :const Text("No Picture"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => takePicture(ImageSource.camera),
                child:const Text("Take a Picture"),
              ),
              ElevatedButton(
                onPressed: () => takePicture(ImageSource.gallery),
                child:const Text("Upload"),
              ),
            ],
          ),
                ],
              )),

           TextButton(
          
          onPressed: () async {
                controller.updateId();
                controller.updatecat(widget.ctgy);
             
              if (formKey.currentState?.validate() ??false) {
                 if (_image!=null){
                   await controller.updateImage(_image);
                   await controller.newItem();
                   // ignore: use_build_context_synchronously
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('done',
                       style: TextStyle(
                        color: Colors.green
                       ),)));
                       // ignore: use_build_context_synchronously
                       Navigator.pop(context);
                 }
                 else{
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('please take or upload a picture!')),
                    );
                 }
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