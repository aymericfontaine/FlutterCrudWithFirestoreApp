import 'package:flutter_crud_with_firestore_app/services/firestore_customer_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<FirestoreCustomerService>(() => FirestoreCustomerService());
}
