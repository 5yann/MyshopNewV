import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/DatabaseServices/Categories_DB_Services.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart'; 



final categoryDatabaseProvider = Provider<CategoryDatabaseService>((ref) {
  return CategoryDatabaseService(); 
});


final categoriesListProvider = StreamProvider<List<Category>>((ref) {
  User? user = FirebaseAuth.instance.currentUser;
  final databaseService = ref.watch(categoryDatabaseProvider);
  return databaseService.getCategoriesStream(user!.uid); 
});

