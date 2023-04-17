import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muda_facil/src/models/user_model.dart';

class AuthService {
  late Stream<User?> _authStream;
  late final CollectionReference<UserModel> collection;

  AuthService() {
    collection = FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()),
          toFirestore: (value, _) => value.toJson(),
        );
    _authStream = FirebaseAuth.instance.authStateChanges();
  }

  Stream<User?> get stream => _authStream;

  Future<String?> getUserRole(String uid) async {
    final userData = await collection.doc(uid).get();
    return userData.data()?.role;
  }

  Future<void> setUser(UserModel user) {
    return collection.doc(user.uid).set(user);
  }

  static Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> addUserRole(String uid, {String role = "user"}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({"role": role}, SetOptions(merge: true));
  }

  static Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) async {
    final createdUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await addUserRole(createdUser.user!.uid);
    return createdUser;
  }

  static Future<void> resetPasswordByEmail(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
