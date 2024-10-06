import 'package:cloud_firestore/cloud_firestore.dart';


class Supplier {
   String  id;
   String name;
   String contact;
   String? adress;
   String? email;
  List<String> list ;
   
  
  Supplier ({required this.id,
  required this.name,
  required this.contact,
  required this.adress,
  required this.email,
  required this.list,
  });

  Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'contact':contact,
     'adress':adress,
     'email':email,
     'list' : list,
    };
  }

  factory Supplier.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Supplier(
      id:doc['id'],
      name: doc['name'],
      contact: doc['contact'],
      adress: doc['adress'],
      email: doc['email'],
      list: List<String>.from(data['list']),
    );
  }
}