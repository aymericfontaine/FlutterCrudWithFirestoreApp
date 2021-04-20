import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationService {
  FirebaseAuth _firebaseAuth;

  AuthentificationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<String> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<String> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<String> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return '';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
