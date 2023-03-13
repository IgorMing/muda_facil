import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> addUserRole(String uid, {String role = "user"}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({"role": role});
  }

  static Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) async {
    final createdUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    addUserRole(createdUser.user!.uid);
    return createdUser;
  }

  static Future<void> resetPasswordByEmail(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
