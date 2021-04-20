import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_with_firestore_app/models/customer.dart';

class FirestoreCustomerService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('customers');

  Stream<List<Customer>> getCustomers() {
    return _ref
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Customer.fromJson(doc.data(), doc.id)).toList());
  }

  Stream<Customer> getCustomer(String idCustomer) {
    return _ref.doc(idCustomer).snapshots().map((doc) => Customer.fromJson(doc.data(), doc.id));
  }

  Future<DocumentReference> addCustomer(Customer customer) {
    return _ref.add(customer.toJson());
  }

  Future<void> setCustomer(Customer customer) {
    return _ref.doc(customer.id).set(customer.toJson());
  }

  Future<void> deleteCustomer(String idCustomer) {
    return _ref.doc(idCustomer).delete();
  }
}
