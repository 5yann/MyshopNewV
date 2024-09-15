
// ignore_for_file: library_private_types_in_public_api, camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController currency = TextEditingController();
  late Future<void> _fetchCountriesFuture;
  final _formKey = GlobalKey<FormState>();
  bool hide =true;
  bool isPhoneNumberValid = false;

     @override
  void initState(){
    super.initState();
       _fetchCountriesFuture = _registerController.updatelist();
      print('init countries end!');
  }

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
                decoration: inputdecoration("your name"),
                validator:validatr,
                onChanged: (val) {
                  _registerController.updateUsername(val);
                },
              ),
               const SizedBox(height: 20.0),
              TextFormField(
                decoration:inputdecoration("StoreName"),
                validator:validatr,
                onChanged: (val) {
                  _registerController.updateenterprisename(val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: inputdecoration("description"),
                validator: validatr,
                onChanged: (val) {
                  _registerController.updatedescription(val);
                },
              ),
                const SizedBox(height: 20.0),
              TextFormField(
                decoration: inputdecoration("adress"),
                validator:validatr,
                onChanged: (val) {
                  _registerController.updateadress(val);
                },
              ),
                const SizedBox(height: 20.0),
                           FutureBuilder<void>(
        future: _fetchCountriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data has been loaded, return the dropdown button
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select your country'),
              validator: (val) {
                if(val == null || val.isEmpty) return 'Empty field';
                return null;
              },
              items: _registerController.countries_list.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  String dropmenuVal=value!;
                  _registerController.updatedropdowval(value);
                  _registerController.updatecountry(dropmenuVal);
                  _registerController.updatecurrency(dropmenuVal);
                  currency.text = _registerController.selectedCurrency;
                  _registerController.updateprefix(dropmenuVal);
                  _registerController.updatePhone(dropmenuVal);
                });
              },
              value: _registerController.dropmenuVal
            );
          }
        },
      ),
                  const SizedBox(height: 20),
            TextFormField(
              decoration: inputdecoration("currency"),
                validator: validatr,
              readOnly: true,
              controller: currency,
            ),
            const SizedBox(height: 20),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber phone) {
                _registerController.updatePhone(phone.phoneNumber.toString());
                print(phone.phoneNumber);
              },
              onInputValidated: (bool isValid) {
                setState(() {
              isPhoneNumberValid = isValid; 
               });
                print(isValid ? 'Valid number' : 'Invalid number');
                
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN, 
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled, 
              textFieldController: phoneController,
              formatInput: true, 
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
              inputDecoration: inputdecoration("phone number"),
                validator:validatr,
            ),
                
                  ],
                ),),
                TextButton(
          
          onPressed: () async {
             
              if (_formKey.currentState?.validate() ??false) {

                 if(isPhoneNumberValid){
                  _registerController.updateuid(widget.uid);
                    _registerController.updateemail(widget.email);
                    await _registerController.Register_With_Facebook_Google();
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(_registerController.error,
                       style: const TextStyle(
                        color: Colors.redAccent
                       ),)));
                 }
                 else{
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Invalid phone number',
                       style: TextStyle(
                        color: Colors.redAccent
                       ),)));
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

   InputDecoration inputdecoration(String hintext){
    return  InputDecoration(hintText: hintext,
                border: const OutlineInputBorder(),
                  focusedBorder:const  OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, 
                      width: 2.0,
                    ),
                  ),
                  errorBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, 
                      width: 2.0,
                    ),
                  ),
                );
  }

  String? validatr(String ? val){
       if (val == null || val.isEmpty) {
    return 'empty field'; 
  }
  return null;
  }



}