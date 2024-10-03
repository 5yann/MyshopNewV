
// ignore_for_file:, use_build_context_synchronously, use_build_context_synchronously, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopnewversion/controllers/itemController/itemsController.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/views/categoriesView/categoryWigets.dart';

class ItemUpdateform extends ConsumerStatefulWidget{
  final Item  item;
  const ItemUpdateform({super.key,required this.item});

  @override
  ItemUpdateformState createState()=> ItemUpdateformState();
}

class ItemUpdateformState extends ConsumerState<ItemUpdateform>{
   final formKey = GlobalKey<FormState>();
   File? _image;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nametextController;
  late TextEditingController desctextController;
  late TextEditingController pricrtextController;
  late TextEditingController qtytextController;

  Future<void> takePicture(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

    @override
  void initState() {
    super.initState();
    nametextController = TextEditingController(text: widget.item.name);
    desctextController = TextEditingController(text: widget.item.description);
    pricrtextController = TextEditingController(text: widget.item.saleprice.toString());
    qtytextController = TextEditingController(text: widget.item.quantity.toString());
  }

  @override
  void dispose() {
    nametextController.dispose();
    desctextController.dispose();
    pricrtextController.dispose();
    qtytextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final controller = ref.watch(itemsControllerProvider);
     controller.updateItem(widget.item);

     return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 216, 225),
      appBar: AppBar(title:  Text(controller.item.name,
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
                decoration: inputdecoration('ItemName'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateItemname(val);
                },
              ),
               const SizedBox(height: 20.0),
                TextFormField(
                  controller: desctextController,
                decoration: inputdecoration('Description'),
                validator: validatr,
                onChanged: (val) {
                  controller.updateItemdesc(val);
                },
              ),
               const SizedBox(height: 20.0),
              TextFormField(
                controller: pricrtextController,
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
                  controller: qtytextController,
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
              Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.item.image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  takePicture(ImageSource.camera);
                },
                child:const Text("Take a new picture"),
              ),
              ElevatedButton(
                onPressed: (){
                  takePicture(ImageSource.gallery);
                } ,
                child:const Text("Upload"),
              ),
            ],
          ),
                ],
              )),

           TextButton(
          
          onPressed: () async {
              if (formKey.currentState?.validate() ??false) {
                 
                  if(_image!=null) await controller.updateImage(_image);
                   await controller.updateItems();
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