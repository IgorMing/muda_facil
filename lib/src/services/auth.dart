import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muda_facil/src/models/user_model.dart';

class AuthService {
  late final CollectionReference<UserModel> collection;
  final user = FirebaseAuth.instance.currentUser;

  User? get loggedInUser => user;

  AuthService() {
    collection = FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  Stream<User?> get onStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<UserModel?> getUserInfo({String? uid}) async {
    final id = uid ?? loggedInUser?.uid;
    final userData = await collection.doc(id).get();
    return userData.data();
  }

  Future<String?> getUserRole(String uid) async {
    final userData = await collection.doc(uid).get();
    return userData.data()?.role;
  }

  Future<void> setUser(UserModel user) {
    return collection.doc(user.uid).set(user);
  }

  static Future<void> addUserRole(String uid, {String role = "user"}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({"role": role}, SetOptions(merge: true));
  }

  static Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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

  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
