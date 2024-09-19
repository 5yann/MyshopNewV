import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
 String id;
 String name;
 String? description;
 String category;
 double saleprice ;
 double purchaseprice ;
 double quantity;
 late List<String> suppliers;
 Item({required this.id,
 required this.name,
  required this.description,
 required this.category,
 required this.saleprice,
 required this.purchaseprice,
 required this.quantity,
 required this.suppliers});

   Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'description':description,
     'category':category,
     'price':saleprice,
     'Pprice':purchaseprice,
     'quantity':quantity,
     'suppliers':suppliers
    };
  }

   factory Item.fromDocument(DocumentSnapshot doc) {
    return Item(
      id: doc['id'],
      name:doc['name'],
      description: doc['description'],
      category: doc['category'],
      saleprice: doc['price'],
      purchaseprice: doc['Pprice'],
      quantity: doc['quantity'],
      suppliers:doc['suppliers'],
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