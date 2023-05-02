import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/providers/authentication.dart';
import 'package:muda_facil/src/services/auth.dart';

class AppUser extends StateNotifier<UserModel?> {
  late final AuthService authService;
  late final StateNotifierProviderRef<AppUser, UserModel?> _ref;
  late final StreamSubscription<UserModel?> _subscription;

  AppUser(StateNotifierProviderRef<AppUser, UserModel?> ref) : super(null) {
    _ref = ref;
    authService = ref.read(authenticationProvider);
  }

  void subscribe() {
    _subscription = authService.onUserChanges.listen((event) {
      state = event;
    });
  }

  void unsubscribe() {
    _subscription.cancel();
  }

  Future<void> signIn(String email, String password) {
    return authService.signInByEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) {
    return authService.resetPasswordByEmail(email);
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUpByEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    await _ref.read(userOrderOrNullProvider.notifier).cancelSubscription();
    await _subscription.cancel();
    _ref.invalidate(userOrderOrNullProvider);
    _ref.invalidate(appUserProvider);

    return await authService.signOut();
  }

  setFullName(String fullName) async {
    state = state!.copyWith(name: fullName);
  }

  setPhone(String phone) {
    state = state!.copyWith(phone: phone);
    authService.setUser(user: state!);
  }
}

// FIXME: check all places that call this provider, and condition it to be called being logged in
final appUserProvider =
    StateNotifierProvider<AppUser, UserModel?>((ref) => AppUser(ref));
