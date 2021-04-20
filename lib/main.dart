import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_with_firestore_app/locator.dart';
import 'package:flutter_crud_with_firestore_app/routes.dart';
import 'package:flutter_crud_with_firestore_app/services/authentification_service.dart';
import 'package:flutter_crud_with_firestore_app/views/customers/customers.dart';
import 'package:flutter_crud_with_firestore_app/views/login_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthentificationService>(create: (_) => AuthentificationService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) => context.read<AuthentificationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: "Firestore CRUD example",
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerater.kRouteInitial,
        onGenerateRoute: RouteGenerater.generateRoute,
      ),
    );
  }
}

class MyAppWrapper extends StatefulWidget {
  @override
  _MyAppWrapperState createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser == null) {
      return LoginView();
    } else {
      return CustomersView();
    }
  }
}
