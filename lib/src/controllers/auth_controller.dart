import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/repositories/auth_repository.dart';

class AuthController extends StateNotifier<User?> {
  final AuthRepository authRepository;
  AuthController(this.authRepository) : super(null);

  Stream<User?> get authStream => authRepository.authStateChanges;

  Future<UserCredential> signInByEmailAndPassword(
      String email, String password) {
    return authRepository.signInByEmailAndPassword(email, password);
  }

  Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) {
    return authRepository.signInByEmailAndPassword(email, password);
  }

  Future<void> resetPasswordByEmail(String email) {
    return authRepository.resetPasswordByEmail(email);
  }

  Future<void> signOut() {
    return authRepository.signOut();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
    (ref) => AuthController(ref.read(authRepositoryProvider)));

final authStreamProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStream;
});
