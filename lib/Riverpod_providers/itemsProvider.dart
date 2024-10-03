//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/DatabaseServices/itemsDatabaseservices.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';




final itemsDatabaseProvider = Provider<Itemsdatabaseservices>((ref) {
  return Itemsdatabaseservices(); 
});


final itemsListProvider = StreamProvider<List<Item>>((ref) {
 // User? user = FirebaseAuth.instance.currentUser;
  final databaseService = ref.watch(itemsDatabaseProvider);
  return databaseService.getItemsStream(); 
});