import 'package:cloud_firestore/cloud_firestore.dart';
class UserRegister {
    int     id;
    String  name;
    String  enterpriseName;
    String  description;
    String  adress;
    String  email;
    String  uId;
    String  phoneNumber;
  
 
     
    UserRegister({
    required this.id,
    required this.name,
    required this.enterpriseName,
    required this.adress,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.uId});


    Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'enterpriseName':enterpriseName,
     'adress':adress,
     'email':email,
     'description':description,
     'phoneNumber' : phoneNumber,
     'uId': uId
    };
  }

  factory UserRegister.fromDocument(DocumentSnapshot doc) {
    return UserRegister(
      id:doc['id'],
      name: doc['name'],
      enterpriseName: doc['enterpriseName'],
      adress: doc['adress'],
      email: doc['email'],
      description:doc['description'],
      phoneNumber: doc['phoneNumber'],
      uId: doc['uId']
    );
  }
}



