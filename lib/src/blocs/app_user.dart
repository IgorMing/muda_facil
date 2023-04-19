import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/services/auth.dart';

class AppUser extends StateNotifier<UserModel?> {
  final authService = AuthService();
  late final StateNotifierProviderRef<AppUser, UserModel?> _ref;

  AppUser(StateNotifierProviderRef<AppUser, UserModel?> ref) : super(null) {
    _ref = ref;
  }

  Future<void> init() async {
    state ??= await authService.getUserInfo();
  }

  Future<void> signIn(String email, String password) {
    return authService.signInByEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) {
    return authService.resetPasswordByEmail(email);
  }

  Future<void> signUp(String email, String password) {
    return authService.signUpByEmailAndPassword(email, password);
  }

  Future<void> signOut() {
    _ref.read(userOrderOrNullProvider.notifier).cancelSubscription();
    _ref.invalidate(userOrderOrNullProvider);
    _ref.invalidate(appUserProvider);

    return authService.signOut();
  }
}

final appUserProvider = StateNotifierProvider<AppUser, UserModel?>((ref) {
  return AppUser(ref);
});
