

import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
 String id;
 String name;
 String? description;
 String category;
 double saleprice ;
 double quantity;
 String  image;
 late List<String> suppliers;
 Item({required this.id,
 required this.name,
  required this.description,
 required this.category,
 required this.saleprice,
 required this.quantity,
 required this.image,
 required this.suppliers});

   Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'description':description,
     'category':category,
     'saleprice':saleprice,
     'quantity':quantity,
     'image':image,
     'suppliers':suppliers
    };
  }

   factory Item.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc['id'],
      name:doc['name'],
      description: doc['description'],
      category: doc['category'],
      saleprice: doc['saleprice'],
      quantity: doc['quantity'],
      image  : doc['image'],
      suppliers:List<String>.from(data['suppliers']),
    );
  }

}

class Category{
 String categoryname;
 double total;
 String description;
 String catId;
 Category({required this.categoryname,
 required this.total,
 required this.description,
 required this.catId
 });

 Map<String, dynamic> toMap() {
    return {
    'categoryname' :categoryname,
    'total':total,
    'description' : description,
    'catId' : catId
    };
  }

  factory Category.fromDocument(DocumentSnapshot doc) {
    return Category(
      categoryname:doc['categoryname'],
      total:doc['total'],
      description:doc['description'],
      catId:doc['catId']
    );
  }
}