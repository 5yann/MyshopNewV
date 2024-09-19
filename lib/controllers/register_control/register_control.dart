

// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shopnewversion/models/registermodel/registermodel.dart';
import 'package:shopnewversion/views/homepageViews/homepage_view.dart';

class RegisterControl {
  final UserRegister userRegister = UserRegister(id: 0, name: '', enterpriseName: '', adress: '', description: '', email: '', phoneNumber: '',country: '',currency: '', uId: '');
  String error ='';
  String Password='';
  List<Map<String, String>> countries = [];
  List<String> countries_list =[];
  String? selectedCountry;
  String selectedCurrency = '';
  String selectedPrefix = '';
  String selectedIsocode = '';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');
  String dropmenuVal='';


   void updateUsername(String name) {
    userRegister.name=name;
  }

  void updateenterprisename(String enterpriseName) {
    userRegister.enterpriseName=enterpriseName;
  }
  void updateadress(String adress) {
    userRegister.adress=adress;
  }
  void updatedescription(String description) {
    userRegister.description=description;
  }
  void updateemail(String email) {
    userRegister.email=email;
  }
  void updatephoneNumber(String phoneNumber) {
    userRegister.phoneNumber=phoneNumber;
  }
   void updatePassword(String password) {
   Password=password;
  }
   void updatecountry(String Country) {
  userRegister.country=Country;
  }
   void updatecurrency(String Currency) {
  
  String incorrectSymbol = countries.firstWhere(
                          (map) => map['country'] == Currency,
    orElse: () => {}  
                        )['currencySymbol'].toString();
                        selectedCurrency =utf8.decode(incorrectSymbol.codeUnits);
                        print(selectedCurrency);
             userRegister.currency=selectedCurrency;
                         
  }
   void updateuid(String uid) {
    userRegister.uId=uid;
  }
   void updateprefix(String prefix) {
   selectedPrefix = countries.firstWhere(
                          (map) => map['country'] == prefix,
    orElse: () => {}  
                        )['prefix'].toString();
                        print(selectedPrefix);
  }
   void updateisoCod(String isoCod) {
   selectedIsocode= countries.firstWhere(
                          (country) => country['country'] == isoCod,
                        )['isoCode']!;
                        print(isoCod);
  }
  void updatePhone(String ph){
    phoneNumber = PhoneNumber(isoCode: selectedIsocode,phoneNumber: ph);
    userRegister.phoneNumber=phoneNumber.phoneNumber.toString();
  }
  
  void updatedropdowval(String val) {
   dropmenuVal=val;
  }

  Future RegisterWithEmailAndPassword(BuildContext context)async{
    try {
  
   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: userRegister.email,
    password: Password,
     );  
        User? user = userCredential.user!;
     updateuid(user.uid);
      try {
    await   FirebaseFirestore.instance.collection('Users').doc(user.uid).set(userRegister.toMap());
    print("new user registered and database created!");
    // the user database has been perfectly created on firebabse
     Navigator.pushReplacement(
                          context,
              MaterialPageRoute(builder: (context) =>  HomePage(storeName: userRegister.enterpriseName,)),
            );

  } on FirebaseException catch (e) {
    print("error on database creation : ${e.message}");
    // error on database creation
  } catch (e) {
    print("unexpected error : $e");
    // other errors
  }
    

    // await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('Items').add({});
      /*await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('orders').add({});
      await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('Deliveries').add({});
      await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('invoices').add({});*/
  
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    error='The password provided is too weak.';
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    error = 'The account already exists for that email.';
    print('The account already exists for that email.');
  } else if(e.code== 'invalid-email'){
    error = 'invalid-email.';
  }
} catch (e) {
  print(e);
}
}

Future Register_With_Facebook_Google()async{
   try {
    await   FirebaseFirestore.instance.collection('Users').doc(userRegister.uId).set(userRegister.toMap());
    print("new user registered and database created!");
    // the user database has been perfectly created on firebabse
     /*Navigator.pushReplacement(
                          context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            );*/

  } on FirebaseException catch (e) {
    print("error on database creation : ${e.message}");
    // error on database creation
  } catch (e) {
    print("unexpected error : $e");
    // other errors
  }
}


 Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

     
        countries = data.map((country) {
          
          String countryName = country['name']['common'];
          Map<String, dynamic>? currencies = country['currencies'];
        String currencyCode = 'N/A';
        String currencySymbol = 'N/A';

        if (currencies != null) {
          currencyCode = currencies.keys.first; 
          currencySymbol = currencies[currencyCode]['symbol'] ?? 'N/A'; 
        }
          
          String prefix = country['idd'] != null
    ? (country['idd']['root'] ?? '') + 
      (country['idd']['suffixes']?.isNotEmpty == true 
        ? (country['idd']['suffixes']?.first ?? '') 
        : '') 
    : 'N/A'; 

             
          String isoCode = country['cca2'];
          return {
            'country': countryName,
            'currencySymbol': currencySymbol,
            'prefix': prefix,
            'isoCode': isoCode,
          };
        }).toList();
      
    } else {
      throw Exception('Failed to load countries');
    }
  }
  
Future<void> updatelist()async{
    await fetchCountries();
    countries_list= countries.where((map) => map.containsKey('country')) 
      .map((map) => map['country'] as String)     
      .toList();
      countries_list.sort();
    updatedropdowval(countries_list[0]);
}

}