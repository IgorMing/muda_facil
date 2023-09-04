import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/providers/providers.dart';
import 'package:muda_facil/src/repositories/exceptions.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  User? getCurrentUser();
  Future<UserCredential> signInByEmailAndPassword(
      String email, String password);
  Future<UserCredential> signUpByEmailAndPassword(
      String email, String password);

  Future<void> resetPasswordByEmail(String email);
  Future<void> signOut();
}

class AuthRepository implements BaseAuthRepository {
  final FirebaseAuth firebaseAuth;
  // final UserController userController;

  AuthRepository(this.firebaseAuth);

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  User? getCurrentUser() {
    try {
      return firebaseAuth.currentUser;
    } on FirebaseAuthException catch (err) {
      throw CustomException(message: err.message.toString());
    }
  }

  @override
  Future<void> resetPasswordByEmail(String email) async {
    try {
      if (email != 'igor.ming@gmail.com') {
        firebaseAuth.sendPasswordResetEmail(email: email);
      }
    } on FirebaseAuthException catch (err) {
      throw CustomException(message: err.message.toString());
    }
  }

  @override
  Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    try {
      return firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (err) {
      throw CustomException(message: err.message.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // await userOrder.cancelSubscription();
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (err) {
      throw CustomException(message: err.message.toString());
    }
  }

  @override
  Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) async {
    try {
      final createdUser = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // final uid = createdUser.user!.uid;
      // userController
      //     .createUser(UserModel(uid: uid, email: email, role: Role.user));
      return createdUser;
    } on FirebaseAuthException catch (err) {
      throw CustomException(message: err.message.toString());
    }
  }
}

final authUidProvider = Provider<String?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.currentUser?.uid;
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
    // ref.read(userControllerProvider.notifier),
  ),
);
