import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/utils/constants.dart';

class AuthService {
  late final CollectionReference<UserModel> collection;

  AuthService() {
    collection = FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  Stream<User?> get onStateChanges => FirebaseAuth.instance.authStateChanges();
  Stream<UserModel?> get onUserChanges => collection
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((event) => event.data());

  Future<UserModel?> getUserInfo({String? uid}) async {
    final id = uid ?? FirebaseAuth.instance.currentUser?.uid;
    final userData = await collection.doc(id).get();
    return userData.data();
  }

  Future<Role?> getUserRole(String uid) async {
    final userData = await collection.doc(uid).get();
    return userData.data()?.role;
  }

  Future<void> setUser({required UserModel user}) {
    return collection.doc(user.uid).set(user, SetOptions(merge: true));
  }

  Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) async {
    final createdUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final uid = createdUser.user!.uid;

    await setUser(user: UserModel(uid: uid, email: email, role: Role.user));
    return createdUser;
  }

  Future<void> resetPasswordByEmail(String email) async {
    if (email != 'igor.ming@gmail.com') {
      return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
