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
  final Ref _ref;

  AuthRepository(this._ref);

  @override
  Stream<User?> get authStateChanges =>
      _ref.read(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() {
    try {} on FirebaseAuthException catch (err) {
      throw CustomException(message: err.message.toString());
    }
    return _ref.read(firebaseAuthProvider).currentUser;
  }

  @override
  Future<void> resetPasswordByEmail(String email) async {
    if (email != 'igor.ming@gmail.com') {
      _ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: email);
    }
  }

  @override
  Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    return _ref
        .read(firebaseAuthProvider)
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return _ref.read(firebaseAuthProvider).signOut();
  }

  @override
  Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) async {
    final createdUser = await _ref
        .read(firebaseAuthProvider)
        .createUserWithEmailAndPassword(email: email, password: password);
    // final uid = createdUser.user!.uid;
    // TODO: Add here the rest of the flow
    return createdUser;
  }
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref));
