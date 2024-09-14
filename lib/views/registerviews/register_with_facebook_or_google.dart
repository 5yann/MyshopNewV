
// ignore_for_file: library_private_types_in_public_api, camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shopnewversion/controllers/register_control/register_control.dart';

// ignore: must_be_immutable
class RegisterWithFacebookOrGoogle extends StatefulWidget{
        String email; 
        String uid; 

    RegisterWithFacebookOrGoogle({super.key, required this.email,required this.uid});

  @override
  _register_state createState() =>_register_state();
   
}

class _register_state extends State<RegisterWithFacebookOrGoogle>{
  final RegisterControl _registerController= RegisterControl();
  final _formKey = GlobalKey<FormState>();
  bool hide =true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
           child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [ 
                Padding(
                padding: const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0, top: 10.0),
                child: Image.asset('images/tof1.jpg'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                     const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "your name",
                border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, 
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  _registerController.updateUsername(val);
                },
              ),
               const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "StoreName",
                border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, 
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  _registerController.updateenterprisename(val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "description",
                border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, 
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  _registerController.updatedescription(val);
                },
              ),
                const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "adress",
                border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  _registerController.updateadress(val);
                },
              ),
                const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "phoneNumer",
                border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, 
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  _registerController.updatephoneNumber(val);
                },
              ),

                  ],
                ),),
                TextButton(
          
          onPressed: () async {
             
              if (_formKey.currentState?.validate() ??false) {
                _registerController.updateuid(widget.uid);
                    _registerController.updateemail(widget.email);
                    await _registerController.Register_With_Facebook_Google();
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(_registerController.error,
                       style: const TextStyle(
                        color: Colors.redAccent
                       ),)));
                  } else {
                    
                       ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Veuillez corriger les erreurs')),
                    );
                    
                  }
          },
          style:const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(500)),
              backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
            ),
          child:const Center(
            child: Text('Sign in',
            style: TextStyle(
              color:  Color.fromARGB(255, 209, 216, 225)
            ),),
          )
            )
               ],
           ),),
      ),
    );
  }

}