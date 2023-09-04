import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/controllers/user_order.dart';
import 'package:muda_facil/src/repositories/auth_repository.dart';
import 'package:muda_facil/src/repositories/user_repository.dart';

class AuthController extends StateNotifier<User?> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Ref ref;
  StreamSubscription<User?>? _streamSubscription;

  AuthController(this.authRepository, this.userRepository, this.ref)
      : super(null) {
    _streamSubscription?.cancel();
    _streamSubscription = authRepository.authStateChanges.listen((user) {
      state = user;

      if (user != null) {
        userRepository.getCurrentUser();
        ref.invalidate(userOrderOrNullProvider);
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Stream<User?> get authStream => authRepository.authStateChanges;

  Future<UserCredential> signInByEmailAndPassword(
      String email, String password) async {
    _streamSubscription?.resume();
    return authRepository.signInByEmailAndPassword(email, password);
  }

  Future<UserCredential> signUpByEmailAndPassword(
      String email, String password) {
    return authRepository.signUpByEmailAndPassword(email, password);
  }

  Future<void> resetPasswordByEmail(String email) {
    return authRepository.resetPasswordByEmail(email);
  }

  Future<void> signOut() async {
    await ref.read(userOrderOrNullProvider.notifier).cancelSubscription();
    _streamSubscription?.pause();
    return authRepository.signOut();
  }

  Future<void> resetPassword(String email) {
    return authRepository.resetPasswordByEmail(email);
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(
    ref.read(authRepositoryProvider),
    ref.read(userRepositoryProvider),
    ref,
  ),
);

final authStreamProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStream;
});
