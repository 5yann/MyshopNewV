//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnewversion/DatabaseServices/suppliers_DatabaseServices.dart';
import 'package:shopnewversion/models/supplier_and_client_models/supplierModel.dart';




final suppliersDatabaseProvider = Provider<SuppliersDatabaseservices>((ref) {
  return SuppliersDatabaseservices(); 
});


final suppliersListProvider = StreamProvider<List<Supplier>>((ref) {
 // User? user = FirebaseAuth.instance.currentUser;
  final databaseService = ref.watch(suppliersDatabaseProvider);
  return databaseService.getSuppliersStream(); 
});