

// ignore_for_file: non_constant_identifier_names


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopnewversion/models/registermodel/registermodel.dart';

class RegisterControl {
  final UserRegister userRegister = UserRegister(id: 0, name: '', enterpriseName: '', adress: '', description: '', email: '', phoneNumber: '',uId: '');
  String error ='';
  String Password='';
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
   void updateuid(String uid) {
    userRegister.uId=uid;
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
  
}